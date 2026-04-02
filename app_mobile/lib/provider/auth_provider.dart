import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:app_mobile/model/user_model.dart';
import 'package:app_mobile/service/api_auth.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;
  String? errorMessage;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<bool> login() async {
    errorMessage = null;

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      errorMessage = 'Vui lòng nhập đầy đủ thông tin';
      notifyListeners();
      return false;
    }

    isLoading = true;
    notifyListeners();

    final user = await ApiAuth.login(
      username: username,
      password: password,
    );

    isLoading = false;

    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return true;
    } else {
      errorMessage = 'Đăng nhập thất bại';
      notifyListeners();
      return false;
    }
  }

  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    usernameController.clear();
    passwordController.clear();
    notifyListeners();
  }

  Future<bool> updateMyProfile({
    required String name,
    required String username,
    required String email,
    Uint8List? avatarBytes,
    String? avatarFileName,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      String? avatarUrl = currentUser?.avatar;

      if (avatarBytes != null && avatarFileName != null) {
        final uploadedUrl = await ApiAuth.uploadAvatar(
          fileData: avatarBytes,
          fileName: avatarFileName,
        );

        if (uploadedUrl != null) {
          avatarUrl = uploadedUrl;
        }
      }

      final updatedUser = await ApiAuth.updateProfile(
        name: name,
        username: username,
        email: email,
        avatar: avatarUrl,
      );

      if (updatedUser != null) {
        _currentUser = updatedUser;
        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('updateMyProfile error: $e');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}