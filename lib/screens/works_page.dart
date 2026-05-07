part of '../main.dart';

// ─────────────────────────── WORKS PAGE ───────────────────────────
class WorksPage extends StatefulWidget {
  const WorksPage({super.key});
  @override
  State<WorksPage> createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage> {
  int _filterIndex = 0;
  final _filters = ['All', 'Mobile', 'Web', 'Desktop', 'Open Source'];

  final _projects = [
    _ProjectData(
        'Event Management App',
        'Full-stack Flutter application with Node.js backend, MySQL database. Role-based system for admin and users with RESTful APIs, token-based authentication, and image upload functionality.',
        96,
        ['Mobile'],
        [Icons.smartphone_outlined]),
    _ProjectData(
        'Todo App',
        'Full-stack mobile Todo application using Flutter with BLoC state management. Firebase Authentication and Supabase integration for real-time CRUD operations and task management.',
        94,
        ['Mobile'],
        [Icons.smartphone_outlined]),
    _ProjectData(
        'Appointment Viewer',
        'Flutter membership app with subscription management and therapist appointment booking. Custom checkout flow for digital product purchases and membership upgrades.',
        92,
        ['Mobile'],
        [Icons.smartphone_outlined]),
    _ProjectData(
        'Consent Form Application',
        'Flutter tablet app for patient document signing and digital declarations. Integrated signature capture, secure data handling, and responsive tablet design for hospital use.',
        93,
        ['Mobile'],
        [Icons.tablet_outlined]),
    _ProjectData(
        'Call Patient App',
        'Hospital communication app integrated with hospital management software. One-click call feature that fetches patient numbers with FCM token integration for secure data retrieval.',
        91,
        ['Mobile'],
        [Icons.smartphone_outlined]),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filterIndex == 0
        ? _projects
        : _projects
            .where((p) => p.tags.contains(_filters[_filterIndex]))
            .toList();

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: AppTextStyles.displayLg,
                children: [
                  const TextSpan(text: 'Multi-Platform '),
                  WidgetSpan(
                    child: ShaderMask(
                      shaderCallback: (b) => const LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ).createShader(b),
                      child: Text('Portfolio', style: AppTextStyles.displayLg),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Showcasing high-performance applications built with Flutter — from complex custom canvas animations to real-time distributed systems.',
              style: AppTextStyles.bodyMd,
            ),
            const SizedBox(height: 32),
            // Filter chips
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(_filters.length, (i) {
                final active = i == _filterIndex;
                return GestureDetector(
                  onTap: () => setState(() => _filterIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.primaryContainer
                          : AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: active
                            ? AppColors.primary.withOpacity(0.3)
                            : AppColors.outlineVariant,
                      ),
                    ),
                    child: Text(
                      _filters[i],
                      style: AppTextStyles.labelSm.copyWith(
                        color:
                            active ? Colors.white : AppColors.onSurfaceVariant,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            _ProjectGrid(projects: filtered),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _ProjectData {
  final String title;
  final String desc;
  final int score;
  final List<String> tags;
  final List<IconData> platforms;
  const _ProjectData(
      this.title, this.desc, this.score, this.tags, this.platforms);
}

class _ProjectGrid extends StatelessWidget {
  final List<_ProjectData> projects;
  const _ProjectGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final cols = constraints.maxWidth > 900
          ? 3
          : constraints.maxWidth > 600
              ? 2
              : 1;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.85,
        ),
        itemCount: projects.length,
        itemBuilder: (_, i) => _ProjectCard(project: projects[i]),
      );
    });
  }
}

class _ProjectCard extends StatefulWidget {
  final _ProjectData project;
  const _ProjectCard({required this.project});
  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        child: GlassCard(
          borderRadius: BorderRadius.circular(16),
          borderColor: _hovered ? AppColors.primary.withOpacity(0.4) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Preview
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryContainer.withOpacity(0.35),
                            AppColors.surfaceContainerHigh,
                          ],
                        ),
                      ),
                      child: _MockDashboard(),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GlassCard(
                        borderRadius: BorderRadius.circular(999),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${p.score}',
                              style: TextStyle(
                                fontFamily: GoogleFonts.lexend().fontFamily,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.tertiary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text('PUB SCORE',
                                style: AppTextStyles.labelSm.copyWith(
                                  color: Colors.white54,
                                  fontSize: 9,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(p.title, style: AppTextStyles.titleLg),
                          ),
                          Row(
                            children: p.platforms
                                .map((ic) => Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Icon(ic,
                                          size: 16,
                                          color: AppColors.onSurfaceVariant),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(p.desc,
                            style: AppTextStyles.bodyMd.copyWith(fontSize: 13),
                            overflow: TextOverflow.fade),
                      ),
                      const Divider(color: Color(0x0DFFFFFF)),
                      Row(
                        children: [
                          Wrap(
                            spacing: 6,
                            children: p.tags
                                .map((t) =>
                                    _Chip(label: t, color: AppColors.secondary))
                                .toList(),
                          ),
                          const Spacer(),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: Matrix4.translationValues(
                                _hovered ? 4 : 0, 0, 0),
                            child: const Icon(Icons.arrow_forward,
                                color: AppColors.primary, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
