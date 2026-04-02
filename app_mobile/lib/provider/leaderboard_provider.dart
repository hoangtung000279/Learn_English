import 'package:flutter/material.dart';
import 'package:app_mobile/model/leaderboard_user.dart';
import 'package:app_mobile/service/api_leaderboard.dart';

class LeaderboardProvider extends ChangeNotifier {
  List<LeaderboardUser> _users = [];
  List<LeaderboardUser> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchLeaderboard({String type = 'today'}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _users = await ApiLeaderboard.getLeaderboard(type: type);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}