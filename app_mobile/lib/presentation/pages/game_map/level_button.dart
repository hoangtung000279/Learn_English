import 'package:app_mobile/model/level_item.dart';
import 'package:app_mobile/presentation/pages/game_map/stars_rank.dart';
import 'package:flutter/material.dart';

class LevelButton extends StatelessWidget {
  final LevelItem level;
  final VoidCallback? onTap;

  const LevelButton({
    super.key,
    required this.level,
    this.onTap,
  });

  double get buttonWidth {
    switch (level.shape) {
      case LevelButtonShape.pill:
        return level.size * 1.35;
      case LevelButtonShape.circle:
      case LevelButtonShape.roundedSquare:
        return level.size;
    }
  }

  BorderRadius get _borderRadius {
    switch (level.shape) {
      case LevelButtonShape.circle:
        return BorderRadius.circular(999);
      case LevelButtonShape.roundedSquare:
        return BorderRadius.circular(20);
      case LevelButtonShape.pill:
        return BorderRadius.circular(999);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final isLocked = level.status == LevelStatus.locked;

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Opacity(
        opacity: isLocked ? 0.9 : 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: buttonWidth,
                  height: level.size,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 6,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: level.status.darkColor,
                            borderRadius: _borderRadius,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 6,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                level.status.mainColor.withOpacity(0.95),
                                level.status.mainColor,
                              ],
                            ),
                            borderRadius: _borderRadius,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: level.showLock
                              ? Icon(
                                  Icons.lock_rounded,
                                  color: Colors.white,
                                  size: level.size * 0.34,
                                )
                              : Text(
                                  '${level.number}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: level.size * 0.34,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                StarsRank(
                  starCount: level.levelStar.count,
                  starSize: level.size * 0.24,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                level.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}