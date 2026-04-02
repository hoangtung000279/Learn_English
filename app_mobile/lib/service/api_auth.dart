import 'dart:convert';
import 'dart:typed_data';
import 'package:app_mobile/domain/configs/app_config.dart';
import 'package:app_mobile/domain/api_request_client/api_request_client.dart';
import 'package:app_mobile/model/user_model.dart';
import 'package:flutter/foundation.dart';

class ApiAuth {
  static Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    try {
      final String url = '${AppConfig.baseURL}/auth/login';

      final response = await ApiRequestClient.post(
        url: url,
        needAuth: false,
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];

        if (data != null) {
          return UserModel.fromJson(data as Map<String, dynamic>);
        }
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('ApiAuth login error: $e');
      }
      return null;
    }
  }

  static Future<String?> uploadAvatar({
    required Uint8List fileData,
    required String fileName,
  }) async {
    try {
      final String url = '${AppConfig.baseURL}/upload/avatar';

      final response = await ApiRequestClient.postSingleFile(
        url: url,
        keyFile: 'file',
        fileName: fileName,
        fileData: fileData,
      );

      if (response == null) return null;

      final decoded = jsonDecode(response);

      if (decoded['data'] != null && decoded['data']['url'] != null) {
        return decoded['data']['url'] as String;
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('ApiAuth uploadAvatar error: $e');
      }
      return null;
    }
  }

  static Future<UserModel?> updateProfile({
    required String name,
    required String username,
    required String email,
    String? avatar,
  }) async {
    try {
      final String url = '${AppConfig.baseURL}/users/profile';

      final response = await ApiRequestClient.post(
        url: url,
        body: jsonEncode({
          'name': name,
          'username': username,
          'email': email,
          'avatar': avatar,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];

        if (data != null) {
          return UserModel.fromJson(data as Map<String, dynamic>);
        }
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('ApiAuth updateProfile error: $e');
      }
      return null;
    }
  }
}