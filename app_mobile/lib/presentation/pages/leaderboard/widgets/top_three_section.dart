import 'package:app_mobile/model/leaderboard_user.dart';
import 'package:app_mobile/presentation/pages/leaderboard/widgets/top_user_card.dart';
import 'package:flutter/material.dart';

class TopThreeSection extends StatelessWidget {
  final List<LeaderboardUser> users;

  const TopThreeSection({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    final topUsers = users.where((e) => e.rank <= 3).toList()
      ..sort((a, b) => a.rank.compareTo(b.rank));

    if (topUsers.length < 3) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TopUserCard(user: topUsers[1]), // rank 2
        TopUserCard(user: topUsers[0]), // rank 1
        TopUserCard(user: topUsers[2]), // rank 3
      ],
    );
  }
}