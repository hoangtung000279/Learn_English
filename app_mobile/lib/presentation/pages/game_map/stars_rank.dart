import 'package:flutter/material.dart';

class StarsRank extends StatelessWidget {
  final int starCount;
  final double starSize;

  const StarsRank({
    super.key,
    required this.starCount,
    required this.starSize,
  });

  @override
  Widget build(BuildContext context) {
    if (starCount == 0) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: -12,
      left: -20,
      right: -20,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF3B2F2F),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: Colors.white70,
              width: 1.2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              starCount,
              (_) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(
                  Icons.star_rounded,
                  color: const Color(0xFFFFD54F),
                  size: starSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}