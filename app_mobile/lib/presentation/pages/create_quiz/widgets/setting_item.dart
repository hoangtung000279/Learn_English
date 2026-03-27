import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final String value;

  const SettingItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(color: Colors.blue),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.blue),
            ],
          )
        ],
      ),
    );
  }
}