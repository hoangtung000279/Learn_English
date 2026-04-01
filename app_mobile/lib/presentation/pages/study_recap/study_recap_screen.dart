import 'package:app_mobile/model/skill_model.dart';
import 'package:app_mobile/presentation/pages/study_recap/widgets/profile_card.dart';
import 'package:app_mobile/presentation/pages/study_recap/widgets/skill_item.dart';
import 'package:app_mobile/presentation/pages/study_recap/widgets/stat_card.dart';
import 'package:app_mobile/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StudyRecapScreen extends StatelessWidget {
  const StudyRecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Chưa có thông tin người dùng'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/create_quiz');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ProfileCard(user: user),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: ListView(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: "Vocabularies",
                            value: "10",
                            subtitle: "Learned",
                            icon: Icons.menu_book,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: "Study Time",
                            value: "120",
                            subtitle: "Minutes",
                            icon: Icons.access_time,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Skills",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...skills.map((e) => SkillItem(skill: e)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Study Recap",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.notifications_none),
        ],
      ),
    );
  }
}