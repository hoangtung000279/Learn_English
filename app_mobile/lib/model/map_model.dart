import 'package:app_mobile/model/level_item.dart';

class LevelLayoutItem {
  final int number;
  final double x;
  final double y;
  final double size;

  const LevelLayoutItem({
    required this.number,
    required this.x,
    required this.y,
    this.size = 48
  });
}

class MapLayoutData {
  final int mapId;
  final String background;
  final List<LevelLayoutItem> levels;

  const MapLayoutData({
    required this.mapId,
    required this.background,
    required this.levels,
  });
}

class GameMapData {
  final int mapId;
  final String background;
  final List<LevelItem> levels;

  const GameMapData({
    required this.mapId,
    required this.background,
    required this.levels,
  });
}

GameMapData mergeGameMap({
  required MapLayoutData localMap,
  required List<LevelApiItem> apiLevels,
}) {
  final levels = localMap.levels.map((layout) {
    final api = apiLevels.firstWhere(
      (e) => e.number == layout.number,
      orElse: () => LevelApiItem(
        number: layout.number,
        title: 'Level ${layout.number}',
      ),
    );

    return LevelItem(
      number: layout.number,
      title: api.title,
      x: layout.x,
      y: layout.y,
      size: layout.size,
      shape: api.shape,
      status: api.status,
      levelStar: api.levelStar,
      showLock: api.showLock,
    );
  }).toList();

  return GameMapData(
    mapId: localMap.mapId,
    background: localMap.background,
    levels: levels,
  );
}


const List<MapLayoutData> gameMapLayouts = [
  MapLayoutData(
    mapId: 1,
    background: 'assets/images/game_map/map_1.jpg',
    levels: [
      LevelLayoutItem(number: 1, x: 0.72, y: 0.89),
      LevelLayoutItem(number: 2, x: 0.30, y: 0.87),
      LevelLayoutItem(number: 3, x: 0.42, y: 0.76),
      LevelLayoutItem(number: 4, x: 0.70, y: 0.68),
      LevelLayoutItem(number: 5, x: 0.15, y: 0.69),
      LevelLayoutItem(number: 6, x: 0.35, y: 0.61),
      LevelLayoutItem(number: 7, x: 0.72, y: 0.56),
      LevelLayoutItem(number: 8, x: 0.24, y: 0.52),
      LevelLayoutItem(number: 9, x: 0.52, y: 0.44),
      LevelLayoutItem(number: 10, x: 0.80, y: 0.37),
      LevelLayoutItem(number: 11, x: 0.48, y: 0.29),
      LevelLayoutItem(number: 12, x: 0.89, y: 0.24),
      LevelLayoutItem(number: 13, x: 0.27, y: 0.24),
      LevelLayoutItem(number: 14, x: 0.35, y: 0.10),
    ],
  ),
  MapLayoutData(
    mapId: 2,
    background: 'assets/images/game_map/map_2.jpg',
    levels: [
      LevelLayoutItem(number: 1, x: 0.60, y: 0.88),
      LevelLayoutItem(number: 2, x: 0.35, y: 0.82),
      LevelLayoutItem(number: 3, x: 0.49, y: 0.76),
      LevelLayoutItem(number: 4, x: 0.78, y: 0.70),
      LevelLayoutItem(number: 5, x: 0.20, y: 0.61),
      LevelLayoutItem(number: 6, x: 0.57, y: 0.55),
      LevelLayoutItem(number: 7, x: 0.52, y: 0.47),
      LevelLayoutItem(number: 8, x: 0.80, y: 0.37),
      LevelLayoutItem(number: 9, x: 0.48, y: 0.32),
      LevelLayoutItem(number: 10, x: 0.75, y: 0.20),
      LevelLayoutItem(number: 11, x: 0.24, y: 0.11),
    ],
  ),
  MapLayoutData(
    mapId: 3,
    background: 'assets/images/game_map/map_3.jpg',
    levels: [
      LevelLayoutItem(number: 1, x: 0.84, y: 0.89),
      LevelLayoutItem(number: 2, x: 0.27, y: 0.87),
      LevelLayoutItem(number: 3, x: 0.68, y: 0.83),
      LevelLayoutItem(number: 4, x: 0.38, y: 0.75),
      LevelLayoutItem(number: 5, x: 0.80, y: 0.70),
      LevelLayoutItem(number: 6, x: 0.27, y: 0.63),
      LevelLayoutItem(number: 7, x: 0.75, y: 0.60),
      LevelLayoutItem(number: 8, x: 0.52, y: 0.535),
      LevelLayoutItem(number: 9, x: 0.83, y: 0.495),
      LevelLayoutItem(number: 10, x: 0.30, y: 0.465),
      LevelLayoutItem(number: 11, x: 0.80, y: 0.38),
      LevelLayoutItem(number: 12, x: 0.42, y: 0.35),
      LevelLayoutItem(number: 13, x: 0.70, y: 0.28),
      LevelLayoutItem(number: 14, x: 0.25, y: 0.25),
      LevelLayoutItem(number: 15, x: 0.65, y: 0.20),
      LevelLayoutItem(number: 16, x: 0.20, y: 0.14),
      LevelLayoutItem(number: 17, x: 0.50, y: 0.09),
    ],
  ),
  MapLayoutData(
    mapId: 4,
    background: 'assets/images/game_map/map_4.jpg',
    levels: [
      LevelLayoutItem(number: 1, x: 0.31, y: 0.90),
      LevelLayoutItem(number: 2, x: 0.67, y: 0.88),
      LevelLayoutItem(number: 3, x: 0.30, y: 0.80),
      LevelLayoutItem(number: 4, x: 0.38, y: 0.74),
      LevelLayoutItem(number: 5, x: 0.70, y: 0.70),
      LevelLayoutItem(number: 6, x: 0.15, y: 0.63),
      LevelLayoutItem(number: 7, x: 0.85, y: 0.575),
      LevelLayoutItem(number: 8, x: 0.42, y: 0.535),
      LevelLayoutItem(number: 9, x: 0.45, y: 0.43),
      LevelLayoutItem(number: 10, x: 0.30, y: 0.385),
      LevelLayoutItem(number: 11, x: 0.50, y: 0.34),
      LevelLayoutItem(number: 12, x: 0.25, y: 0.25),
      LevelLayoutItem(number: 13, x: 0.65, y: 0.22),
      LevelLayoutItem(number: 14, x: 0.20, y: 0.155),
      LevelLayoutItem(number: 15, x: 0.75, y: 0.11),
      LevelLayoutItem(number: 16, x: 0.25, y: 0.06),
    ],
  ),
  const MapLayoutData(
    mapId: 5,
    background: 'assets/images/game_map/map_5.jpg',
    levels: [],
  ),
  const MapLayoutData(
    mapId: 6,
    background: 'assets/images/game_map/map_6.jpg',
    levels: [],
  ),
  const MapLayoutData(
    mapId: 7,
    background: 'assets/images/game_map/map_7.jpg',
    levels: [],
  ),
];