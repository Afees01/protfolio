import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {

    final skills = [
      "Flutter",
      "Dart",
      "Firebase",
      "REST API",
      "BLoC",
      ".NET",
      "Git"
    ];

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Wrap(
        spacing: 10,
        children: skills.map((e) => Chip(label: Text(e))).toList(),
      ),
    );
  }
}