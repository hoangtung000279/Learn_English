import 'dart:io';
import 'dart:math';
import 'package:app_mobile/model/scan_result.dart';

class ScanService {
  final _rand = Random();

  Future<ScanResult> scanFile(File imageFile) async {
    // TODO: đổi sang Dio upload imageFile nếu có API
    await Future.delayed(const Duration(milliseconds: 700));

    final confidence = 0.78 + _rand.nextDouble() * 0.2;

    return ScanResult(
      title: 'Lamp (n)',
      subtitle: '/læmp/\nCái đèn',
      confidence: confidence.clamp(0, 1),
    );
  }
}