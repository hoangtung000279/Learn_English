import 'dart:convert';
import 'package:app_mobile/domain/configs/app_config.dart';
import 'package:app_mobile/model/level_item.dart';
import 'package:flutter/foundation.dart';
import 'package:app_mobile/domain/api_request_client/api_request_client.dart';

class ApiMap {
  static Future<List<LevelApiItem>> getMapLevels({
    required int mapId,
  }) async {
    try {
      final String url = '${AppConfig.baseURL}/maps/$mapId/levels';

      final response = await ApiRequestClient.get(
        url: url,
        needAuth: false,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'] ?? [];

        return data
            .map((e) => LevelApiItem.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      if (kDebugMode) {
        print('ApiMap getMapLevels error: $e');
      }
      return [];
    }
  }
}