import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {

  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: hover
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),
        child: Card(
          elevation: hover ? 10 : 3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(widget.title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(widget.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}