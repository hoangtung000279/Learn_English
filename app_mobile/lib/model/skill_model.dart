import 'package:flutter/material.dart';

class SkillModel {
  final String title;
  final int stars;
  final IconData icon;
  final Color color;

  const SkillModel({
    required this.title,
    required this.stars,
    required this.icon,
    required this.color,
  });
}
const List<SkillModel> skills = [
  SkillModel(
    title: "Listening",
    stars: 4,
    icon: Icons.headphones,
    color: Colors.blue,
  ),
  SkillModel(
    title: "Reading",
    stars: 4,
    icon: Icons.menu_book,
    color: Colors.green,
  ),
  SkillModel(
    title: "Speaking",
    stars: 3,
    icon: Icons.mic,
    color: Colors.pink,
  ),
  SkillModel(
    title: "Writing",
    stars: 3,
    icon: Icons.edit,
    color: Colors.orange,
  ),
];