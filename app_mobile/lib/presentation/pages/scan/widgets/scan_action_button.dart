import 'package:flutter/material.dart';

class ScanActionButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const ScanActionButton({
    super.key,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = 70.0;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isLoading ? 26 : 54,
            height: isLoading ? 26 : 54,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: isLoading
                ? const Padding(
                    padding: EdgeInsets.all(5),
                    child: CircularProgressIndicator(strokeWidth: 2.2),
                  )
                : const Icon(Icons.center_focus_strong_rounded, color: Colors.black),
          ),
        ),
      ),
    );
  }
}