import 'package:app_mobile/presentation/pages/leaderboard/widgets/leaderboard_list_item.dart';
import 'package:app_mobile/presentation/pages/leaderboard/widgets/top_three_section.dart';
import 'package:app_mobile/provider/leaderboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int selectedTab = 0;
  int selectedBottomNav = 2;

  final List<String> tabs = ['Today', 'Week', 'All Time'];

  String get currentType {
    switch (selectedTab) {
      case 0:
        return 'today';
      case 1:
        return 'week';
      case 2:
        return 'all_time';
      default:
        return 'today';
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LeaderboardProvider>().fetchLeaderboard(type: currentType);
    });
  }

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

                          final type = switch (index) {
                            0 => 'today',
                            1 => 'week',
                            _ => 'all_time',
                          };

                          context
                              .read<LeaderboardProvider>()
                              .fetchLeaderboard(type: type);
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

              Expanded(
                child: Consumer<LeaderboardProvider>(
                  builder: (context, provider, child) {
                    final users = provider.users;
                    final topUsers = users.take(3).toList();
                    final otherUsers = users.skip(3).toList();

                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (provider.errorMessage != null &&
                        provider.errorMessage!.isNotEmpty) {
                      return Center(
                        child: Text(provider.errorMessage!),
                      );
                    }

                    if (users.isEmpty) {
                      return const Center(
                        child: Text('No leaderboard data'),
                      );
                    }

                    return Column(
                      children: [
                        if (topUsers.length >= 3)
                          TopThreeSection(users: topUsers),

                        if (topUsers.length >= 3) const SizedBox(height: 24),

                        Expanded(
                          child: ListView.builder(
                            itemCount: otherUsers.length,
                            itemBuilder: (context, index) {
                              return LeaderboardListItem(
                                user: otherUsers[index],
                              );
                            },
                          ),
                        ),
                      ],
                    );
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