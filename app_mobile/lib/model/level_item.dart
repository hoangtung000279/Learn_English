import 'dart:ui';

enum LevelButtonShape {
  circle,
  roundedSquare,
  pill,
}

enum LevelStatus {
  locked,
  unlocked,
  completed,
  special,
}

enum LevelStar {
  none,
  good,
  great,
  excellent,
}

class LevelItem {
  final int number;
  final String title;
  final double x;
  final double y;
  final double size;
  final LevelButtonShape shape;
  final LevelStatus status;
  final LevelStar levelStar;
  final bool showLock;

  const LevelItem({
    required this.number,
    required this.title,
    required this.x,
    required this.y,
    this.size = 48,
    this.shape = LevelButtonShape.circle,
    this.status = LevelStatus.unlocked,
    this.levelStar = LevelStar.none,
    this.showLock = false,
  });
}

extension LevelStarX on LevelStar {
  int get count {
    switch (this) {
      case LevelStar.none:
        return 0;
      case LevelStar.good:
        return 1;
      case LevelStar.great:
        return 2;
      case LevelStar.excellent:
        return 3;
    }
  }
}

extension LevelStatusX on LevelStatus {
  Color get mainColor {
    switch (this) {
      case LevelStatus.locked:
        return const Color(0xFF9E9E9E);
      case LevelStatus.unlocked:
        return const Color(0xFF2D9CFF);
      case LevelStatus.completed:
        return const Color(0xFF27AE60);
      case LevelStatus.special:
        return const Color(0xFFF2C94C);
    }
  }

  Color get darkColor {
    switch (this) {
      case LevelStatus.locked:
        return const Color(0xFF757575);
      case LevelStatus.unlocked:
        return const Color(0xFF1C78D0);
      case LevelStatus.completed:
        return const Color(0xFF1E874B);
      case LevelStatus.special:
        return const Color(0xFFD4A92E);
    }
  }
}