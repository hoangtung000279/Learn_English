import 'package:app_mobile/model/skill_model.dart';
import 'package:flutter/material.dart';

class SkillItem extends StatelessWidget {
  final SkillModel skill;

  const SkillItem({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xfff7f8fc),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // 🔹 ICON
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: skill.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              skill.icon,
              color: skill.color,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          // 🔹 TITLE
          Expanded(
            child: Text(
              skill.title,
              style: const TextStyle(fontSize: 14),
            ),
          ),

          // 🔹 STARS
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < skill.stars ? Icons.star : Icons.star_border,
                color: Colors.orange,
                size: 18,
              );
            }),
          )
        ],
      ),
    );
  }
}