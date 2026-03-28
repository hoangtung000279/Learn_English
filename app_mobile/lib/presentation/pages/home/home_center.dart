import 'package:app_mobile/presentation/pages/game_map/game_map_screen.dart';
import 'package:app_mobile/presentation/pages/study_recap/study_recap_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile/presentation/pages/leaderboard/leaderboard_screen.dart';

class HomeCenter extends StatefulWidget {
  const HomeCenter({super.key});

  @override
  State<HomeCenter> createState() => _HomeCenterState();
}

class _HomeCenterState extends State<HomeCenter> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    GameMapScreen(),
    GameMapScreen(),
    StudyRecapScreen(),
    LeaderboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        height: 74,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.12),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomItem(Icons.sports_esports_outlined, 0),
            _buildBottomItem(Icons.settings, 1),
            _buildBottomItem(Icons.inventory_2_outlined, 2),
            _buildBottomItem(Icons.emoji_events, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomItem(IconData icon, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Icon(
        icon,
        size: 26,
        color: isSelected
            ? const Color(0xFF2EA8FF)
            : const Color(0xFFB7DDF8),
      ),
    );
  }
}