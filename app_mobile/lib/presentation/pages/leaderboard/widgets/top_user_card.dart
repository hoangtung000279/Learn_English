import 'package:app_mobile/model/leaderboard_user.dart';
import 'package:flutter/material.dart';

class TopUserCard extends StatelessWidget {
  final LeaderboardUser user;

  const TopUserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTop1 = user.rank == 1;

    final double avatarSize = isTop1 ? 118 : 82;
    final double badgeLeft = isTop1 ? 6 : -2;

    Color rankColor;
    if (user.rank == 1) {
      rankColor = const Color(0xFFF6C647);
    } else if (user.rank == 2) {
      rankColor = const Color(0xFFC7A446);
    } else {
      rankColor = const Color(0xFFD8D8D8);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: avatarSize + 14,
              height: avatarSize + 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF8ED4FF),
                  width: 4,
                ),
              ),
            ),
            ClipOval(
              child: Image.network(
                user.avatar,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: avatarSize,
                    height: avatarSize,
                    color: const Color(0xFFEAEAEA),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: avatarSize * 0.45,
                      color: Colors.grey,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: avatarSize,
                    height: avatarSize,
                    color: const Color(0xFFF5F5F5),
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: badgeLeft,
              bottom: 6,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: rankColor,
                ),
                child: Center(
                  child: Text(
                    '${user.rank}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          constraints: const BoxConstraints(maxWidth: 110),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: rankColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${user.score}',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}