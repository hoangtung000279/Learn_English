import 'dart:convert';
import 'package:app_mobile/domain/configs/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:app_mobile/model/leaderboard_user.dart';
import 'package:app_mobile/domain/api_request_client/api_request_client.dart';

class ApiLeaderboard {
  static Future<List<LeaderboardUser>> getLeaderboard({
    required String type,
  }) async {
    try {
      final String url = '${AppConfig.baseURL}/leaderboard';

      final response = await ApiRequestClient.get(
        url: url,
        queryParam: {
          'type': type,
        },
        needAuth: false
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'] ?? [];

        return data
            .map((e) => LeaderboardUser.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      if (kDebugMode) {
        print('ApiLeaderboard getLeaderboard error: $e');
      }
      return [];
    }
  }
}