import 'package:app_mobile/model/leaderboard_user.dart';
import 'package:flutter/material.dart';

class LeaderboardListItem extends StatelessWidget {
  final LeaderboardUser user;

  const LeaderboardListItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    Color rankColor;
    switch (user.rank) {
      case 1:
        rankColor = const Color(0xFFF6C647);
        break;
      case 2:
        rankColor = const Color(0xFFC7A446);
        break;
      case 3:
        rankColor = const Color(0xFFD8D8D8);
        break;
      case 4:
        rankColor = const Color(0xFF8BCF4E);
        break;
      case 5:
        rankColor = const Color(0xFFFF8DC3);
        break;
      case 6:
        rankColor = const Color(0xFFF2C84B);
        break;
      case 7:
        rankColor = const Color(0xFF59BFFF);
        break;
      default:
        rankColor = const Color.fromARGB(255, 89, 94, 97);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE9E9E9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF8ED4FF),
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                user.avatar,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFEAEAEA),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${user.score}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8A8A8A),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: rankColor,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '${user.rank}',
                style: TextStyle(
                  color: rankColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}