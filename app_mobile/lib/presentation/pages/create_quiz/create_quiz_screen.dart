import 'package:app_mobile/presentation/pages/create_quiz/widgets/setting_item.dart';
import 'package:app_mobile/presentation/pages/create_quiz/widgets/switch_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateQuizScreen extends StatelessWidget {
  const CreateQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0c1b22),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          )
        ),
        title: const Text("Create a quz", style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SettingItem(
                title: "Number of questions",
                value: "10",
              ),

              const SettingItem(
                title: "Time limit",
                value: "5 min",
              ),

              const SizedBox(height: 10),

              const SwitchItem(
                title: "Show answers immediately",
                value: true,
              ),

              const SizedBox(height: 20),

              const Text(
                "Question format",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 10),

              const SwitchItem(title: "Multiple choice", value: true),
              const SwitchItem(title: "Matching", value: false),
              const SwitchItem(title: "True or False", value: true),
              const SwitchItem(title: "Fill in the blank", value: false),
              const SwitchItem(title: "Sentence Ordering", value: false),

              const Spacer(),

              _buildButtons()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Preview Test",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}