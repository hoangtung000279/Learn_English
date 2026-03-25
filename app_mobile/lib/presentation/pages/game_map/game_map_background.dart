import 'package:flutter/material.dart';

class GameMapBackground extends StatelessWidget {
  const GameMapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Nền cỏ
        Positioned.fill(
          child: Container(
            color: const Color(0xFF7ED348),
          ),
        ),

        // Các mảng cỏ sáng
        const Positioned(
          top: 30,
          left: 10,
          child: GrassPatch(width: 140, height: 40),
        ),
        const Positioned(
          top: 180,
          right: 20,
          child: GrassPatch(width: 80, height: 30),
        ),
        const Positioned(
          top: 430,
          left: 20,
          child: GrassPatch(width: 110, height: 35),
        ),

        // Sông
        Positioned(
          left: -20,
          right: -20,
          top: 260,
          child: Transform.rotate(
            angle: 0.02,
            child: Container(
              height: 95,
              decoration: BoxDecoration(
                color: const Color(0xFF4AA8FF),
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          ),
        ),

        // Viền sáng của sông
        Positioned(
          left: -20,
          right: -20,
          top: 255,
          child: Transform.rotate(
            angle: 0.02,
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF7CC5FF),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),

        // Cầu
        const Positioned(
          right: 35,
          top: 245,
          child: BridgeWidget(),
        ),

        // Cây
        const Positioned(
          left: 12,
          top: 250,
          child: TreeWidget(),
        ),
        const Positioned(
          left: 35,
          top: 255,
          child: TreeWidget(size: 26),
        ),
        const Positioned(
          right: 10,
          top: 360,
          child: TreeWidget(),
        ),
        const Positioned(
          right: 38,
          top: 365,
          child: TreeWidget(size: 24),
        ),

        // Đá
        const Positioned(
          right: 20,
          top: 160,
          child: RockWidget(),
        ),

        // Gốc cây
        const Positioned(
          left: 145,
          top: 305,
          child: StumpWidget(),
        ),
        const Positioned(
          left: 30,
          top: 450,
          child: StumpWidget(),
        ),
      ],
    );
  }
}

class GrassPatch extends StatelessWidget {
  final double width;
  final double height;

  const GrassPatch({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFDDF6D1),
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}

class TreeWidget extends StatelessWidget {
  final double size;

  const TreeWidget({super.key, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size + 10,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: size * 0.18,
            height: size * 0.35,
            color: const Color(0xFF7A4A22),
          ),
          Positioned(
            bottom: size * 0.18,
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: Color(0xFF4F8E2F),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RockWidget extends StatelessWidget {
  const RockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 45,
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              width: 28,
              height: 22,
              decoration: BoxDecoration(
                color: const Color(0xFF9E9E9E),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            right: 6,
            top: 18,
            child: Container(
              width: 18,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFFBDBDBD),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 20,
            child: Container(
              width: 16,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF7E4),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StumpWidget extends StatelessWidget {
  const StumpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 14,
      decoration: BoxDecoration(
        color: const Color(0xFF8B5A2B),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class BridgeWidget extends StatelessWidget {
  const BridgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 55,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: 70,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(0xFFB57A42),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFFD39A5D),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          ...List.generate(5, (index) {
            return Positioned(
              bottom: 4,
              left: 10 + index * 11,
              child: Container(
                width: 3,
                height: 28,
                color: const Color(0xFF8B5A2B),
              ),
            );
          }),
        ],
      ),
    );
  }
}