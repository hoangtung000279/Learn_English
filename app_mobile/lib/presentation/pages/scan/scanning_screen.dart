import 'package:app_mobile/presentation/pages/scan/widgets/add_to_list_dialog.dart';
import 'package:app_mobile/presentation/pages/scan/widgets/scan_action_button.dart';
import 'package:app_mobile/presentation/pages/scan/widgets/scan_camera_overlay.dart';
import 'package:app_mobile/presentation/pages/scan/widgets/scan_result_bottom_sheet.dart';
import 'package:app_mobile/presentation/pages/scan/widgets/scan_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:app_mobile/provider/scan_provider.dart';
import 'package:app_mobile/service/scan_service.dart';

class ScanningScreen extends StatelessWidget {
  const ScanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScanProvider(service: ScanService())..init(),
      child: const _ScanningView(),
    );
  }
}

class _ScanningView extends StatelessWidget {
  const _ScanningView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScanProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (provider.viewState == ScanViewState.addToList) {
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const AddToListDialog(),
        );
        if (context.mounted) {
          context.read<ScanProvider>().closeAddToList();
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview
          Positioned.fill(
            child: _CameraLayer(),
          ),

          const ScanCameraOverlay(),

          SafeArea(
            child: ScanTopBar(
              title: 'Scanning',
              onBack: () {
                if (provider.viewState == ScanViewState.result) {
                  provider.backToCamera();
                } else {
                  Navigator.of(context).maybePop();
                }
              },
              onMore: () {},
            ),
          ),

          // Bottom controls: gallery + capture
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: const EdgeInsets.only(bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SmallAction(
                    icon: Icons.photo_library_rounded,
                    onTap: provider.isBusy ? null : provider.onPickFromGallery,
                  ),
                  const SizedBox(width: 18),
                  ScanActionButton(
                    isLoading: provider.viewState == ScanViewState.scanning,
                    onTap: provider.onCapturePressed,
                  ),
                ],
              ),
            ),
          ),

          if (provider.viewState == ScanViewState.result && provider.result != null)
            ScanResultBottomSheet(
              resultTitle: provider.result!.title,
              resultSubtitle: provider.result!.subtitle,
              onAddToList: provider.openAddToList,
              onSpeak: () {},
              onFavorite: () {},
            ),
        ],
      ),
    );
  }
}

class _CameraLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ScanProvider>().cameraController;

    if (controller == null || !controller.value.isInitialized) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0E0E0E), Color(0xFF1B1B1B)],
          ),
        ),
        child: const Center(
          child: Text('Camera not available', style: TextStyle(color: Colors.white38)),
        ),
      );
    }

    // Giữ đúng tỉ lệ camera
    return Center(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
    );
  }
}

class _SmallAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _SmallAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 30,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}