import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_state.dart';
import '../widgets/project_card.dart';
import '../widgets/project_skeleton.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {

        if (state is PortfolioLoading) {
          return const ProjectSkeleton();
        }

        if (state is PortfolioLoaded) {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const Text("Projects",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ...state.projects.map(
                  (p) => ProjectCard(
                    title: p.title,
                    description: p.description,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}