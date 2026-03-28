import 'package:app_mobile/model/leaderboard_user.dart';
import 'package:app_mobile/presentation/pages/leaderboard/widgets/leaderboard_list_item.dart';
import 'package:app_mobile/presentation/pages/leaderboard/widgets/top_three_section.dart';
import 'package:flutter/material.dart';
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int selectedTab = 0;
  int selectedBottomNav = 2;
  final List<LeaderboardUser> users = listboardusers;

  final List<String> tabs = ['Today', 'Week', 'All Time'];

  List<LeaderboardUser> get topUsers => users.take(3).toList();
  List<LeaderboardUser> get otherUsers => users.skip(3).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
          child: Column(
            children: [
              const SizedBox(height: 6),
              const Text(
                'Leaderboard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: List.generate(
                  tabs.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index == 2 ? 0 : 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = index;
                          });
                        },
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: selectedTab == index
                                ? const Color(0xFF4BB7FF)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFF8ED4FF),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: selectedTab == index
                                    ? Colors.white
                                    : const Color(0xFF303030),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              TopThreeSection(users: topUsers),

              const SizedBox(height: 24),

              Expanded(
                child: ListView.builder(
                  itemCount: otherUsers.length,
                  itemBuilder: (context, index) {
                    return LeaderboardListItem(user: otherUsers[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}