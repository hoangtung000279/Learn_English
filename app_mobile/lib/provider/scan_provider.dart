import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:app_mobile/model/scan_result.dart';
import 'package:app_mobile/model/scan_list.dart';
import 'package:app_mobile/service/scan_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

enum ScanViewState { camera, scanning, result, addToList }

class ScanProvider extends ChangeNotifier {
  final ScanService service;

  ScanProvider({required this.service});

  ScanViewState _viewState = ScanViewState.camera;
  ScanViewState get viewState => _viewState;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  ScanResult? _result;
  ScanResult? get result => _result;

  File? _imageFile;
  File? get imageFile => _imageFile;

  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  final ImagePicker _picker = ImagePicker();

  final List<ScanList> _lists = [
    const ScanList(id: 'nature', name: 'Nature'),
    const ScanList(id: 'family', name: 'Family'),
  ];
  List<ScanList> get lists => List.unmodifiable(_lists);

  String? _selectedListId;
  String? get selectedListId => _selectedListId;

  Future<void> init() async {
    _viewState = ScanViewState.camera;
    _result = null;
    _imageFile = null;
    _selectedListId = null;

    await _initCamera();
    notifyListeners();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await controller.initialize();
      _cameraController = controller;
    } catch (_) {
      // nếu fail, vẫn cho UI chạy (hiện placeholder)
      _cameraController = null;
    }
  }

  Future<void> disposeCamera() async {
    final c = _cameraController;
    _cameraController = null;
    if (c != null) {
      await c.dispose();
    }
  }

  Future<void> onCapturePressed() async {
    final c = _cameraController;
    if (_isBusy || c == null || !c.value.isInitialized) return;

    _setBusy(true);
    _viewState = ScanViewState.scanning;
    notifyListeners();

    try {
      final xfile = await c.takePicture();

      // copy qua app dir để bạn quản lý dễ hơn
      final saved = await _persistToAppDir(File(xfile.path));
      _imageFile = saved;

      await _scanCurrentFile();
    } catch (_) {
      _viewState = ScanViewState.camera;
    } finally {
      _setBusy(false);
      notifyListeners();
    }
  }

  Future<void> onPickFromGallery() async {
    if (_isBusy) return;

    _setBusy(true);
    notifyListeners();

    try {
      final xfile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 92,
      );
      if (xfile == null) return;

      _viewState = ScanViewState.scanning;
      notifyListeners();

      final saved = await _persistToAppDir(File(xfile.path));
      _imageFile = saved;

      await _scanCurrentFile();
    } catch (_) {
      _viewState = ScanViewState.camera;
    } finally {
      _setBusy(false);
      notifyListeners();
    }
  }

  Future<File> _persistToAppDir(File file) async {
    final dir = await getApplicationDocumentsDirectory();
    final filename = 'scan_${DateTime.now().millisecondsSinceEpoch}${p.extension(file.path)}';
    final dest = File(p.join(dir.path, filename));
    return file.copy(dest.path);
  }

  Future<void> _scanCurrentFile() async {
    final f = _imageFile;
    if (f == null) {
      _viewState = ScanViewState.camera;
      return;
    }
    final res = await service.scanFile(f);
    _result = res;
    _viewState = ScanViewState.result;
  }

  void openAddToList() {
    if (_result == null) return;
    _viewState = ScanViewState.addToList;
    notifyListeners();
  }

  void closeAddToList() {
    _viewState = ScanViewState.result;
    notifyListeners();
  }

  void selectList(String id) {
    _selectedListId = id;
    notifyListeners();
  }

  void createNewList(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _lists.add(ScanList(id: id, name: trimmed));
    _selectedListId = id;
    notifyListeners();
  }

  Future<void> saveToSelectedList() async {
    if (_result == null || _selectedListId == null) return;
    _setBusy(true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));

    _setBusy(false);
    _viewState = ScanViewState.result;
    notifyListeners();
  }

  void backToCamera() {
    _result = null;
    _imageFile = null;
    _viewState = ScanViewState.camera;
    notifyListeners();
  }

  void _setBusy(bool v) => _isBusy = v;
}