import 'package:app_mobile/model/level_item.dart';
import 'package:app_mobile/model/map_model.dart';
import 'package:app_mobile/service/api_map.dart';
import 'package:flutter/foundation.dart';

class MapProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  GameMapData? _gameMapData;

  bool get isLoading => _isLoading;
  String? get error => _error;
  GameMapData? get gameMapData => _gameMapData;

  Future<void> getMapData({
    required int mapId,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final List<LevelApiItem> apiLevels = await ApiMap.getMapLevels(
        mapId: mapId,
      );

      final MapLayoutData localMap = gameMapLayouts.firstWhere(
        (e) => e.mapId == mapId,
      );

      final List<LevelItem> mergedLevels = localMap.levels.map((layout) {
        final LevelApiItem? api = apiLevels.cast<LevelApiItem?>().firstWhere(
          (e) => e?.number == layout.number,
          orElse: () => null,
        );

        return LevelItem(
          number: layout.number,
          title: api?.title ?? 'Level ${layout.number}',
          x: layout.x,
          y: layout.y,
          size: layout.size,
          shape: api?.shape ?? LevelButtonShape.circle,
          status: api?.status ?? LevelStatus.locked,
          levelStar: api?.levelStar ?? LevelStar.none,
          showLock: api?.showLock ?? true,
        );
      }).toList();

      _gameMapData = GameMapData(
        mapId: localMap.mapId,
        background: localMap.background,
        levels: mergedLevels,
      );
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) {
        print('MapProvider getMapData error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}