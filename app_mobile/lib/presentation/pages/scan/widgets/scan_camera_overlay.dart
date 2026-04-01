import 'package:flutter/material.dart';

class ScanCameraOverlay extends StatelessWidget {
  const ScanCameraOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;

        // vùng focus (giống hình)
        final boxW = w * 0.52;
        final boxH = boxW * 0.72;

        return Stack(
          children: [
            // dark overlay trên dưới
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _HolePainter(
                    holeRect: Rect.fromCenter(
                      center: Offset(w * 0.65, h * 0.32),
                      width: boxW,
                      height: boxH,
                    ),
                    radius: 18,
                  ),
                ),
              ),
            ),
            // khung góc trắng
            Positioned(
              left: w * 0.65 - boxW / 2,
              top: h * 0.32 - boxH / 2,
              width: boxW,
              height: boxH,
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _CornerPainter(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HolePainter extends CustomPainter {
  final Rect holeRect;
  final double radius;

  _HolePainter({required this.holeRect, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.55);

    final full = Path()..addRect(Offset.zero & size);
    final hole = Path()
      ..addRRect(RRect.fromRectAndRadius(holeRect, Radius.circular(radius)));

    final path = Path.combine(PathOperation.difference, full, hole);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _HolePainter oldDelegate) {
    return oldDelegate.holeRect != holeRect || oldDelegate.radius != radius;
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 2.2;
    const corner = 18.0;

    final p = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      // top-left
      ..moveTo(0, corner)
      ..lineTo(0, 0)
      ..lineTo(corner, 0)
      // top-right
      ..moveTo(size.width - corner, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, corner)
      // bottom-right
      ..moveTo(size.width, size.height - corner)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - corner, size.height)
      // bottom-left
      ..moveTo(corner, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height - corner);

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}