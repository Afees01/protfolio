import 'package:flutter/material.dart';
import 'skeleton_box.dart';

class ProjectSkeleton extends StatelessWidget {
  const ProjectSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => const Padding(
          padding: EdgeInsets.all(10),
          child: SkeletonBox(height: 80, width: double.infinity),
        ),
      ),
    );
  }
}