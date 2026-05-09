part of '../main.dart';

// ─────────────────────────── ABOUT PAGE ───────────────────────────
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AboutHero(),
            const SizedBox(height: 64),
            _WidgetTree(),
            const SizedBox(height: 64),
            _Timeline(),
            const SizedBox(height: 64),
            _Philosophy(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

void downloadCV() {
  html.AnchorElement(
    href: 'assets/pdf/CV.pdf',
  )
    ..setAttribute('download', 'Afees KA CV.pdf')
    ..click();
}

class _AboutHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final isWide = constraints.maxWidth > 800;
      final imageSection = GlassCard(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Container(
              height: isWide ? null : 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    AppColors.primaryContainer.withOpacity(0.5),
                    AppColors.surfaceContainerHigh,
                  ],
                ),
              ),
              child: const Center(
                child: _AvatarPlaceholder(),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.tertiary,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified, size: 14, color: Colors.black),
                    const SizedBox(width: 6),
                    Text('Flutter Developer',
                        style: AppTextStyles.labelSm.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

      final textSection = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: AppTextStyles.displayLg,
              children: [
                const TextSpan(text: 'Building '),
                const TextSpan(
                    text: 'beautiful, responsive apps',
                    style: TextStyle(color: AppColors.primary)),
                const TextSpan(text: ' that feel great on every device.'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'I create Flutter experiences that are easy to use, polished, and fast. From clean UI layouts to smooth backend integration, I build apps that help people get things done with confidence.',
            style: AppTextStyles.bodyMd,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _PrimaryButton(
                label: 'Download CV',
                icon: const Icon(Icons.download, color: Colors.white, size: 18),
                onTap: downloadCV,
              ),
              const SizedBox(width: 16),
              _GhostButton(
                label: 'View Projects',
                onTap: () {
                  final shell = MainShell.of(context);
                  if (shell != null) {
                    shell.scrollToSection(1);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WorksPage()),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      );

      if (isWide) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 380, height: 400, child: imageSection),
            const SizedBox(width: 48),
            Expanded(child: textSection),
          ],
        );
      }
      return Column(
        children: [
          SizedBox(height: 300, child: imageSection),
          const SizedBox(height: 32),
          textSection
        ],
      );
    });
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.primaryContainer, AppColors.secondary],
        ),
      ),
      child: const Icon(Icons.person, size: 64, color: Colors.white70),
    );
  }
}

class _WidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final skills = [
      (
        'Visual Design',
        Icons.palette_outlined,
        AppColors.primary,
        ['Responsive layouts', 'Modern components', 'Accessible UI']
      ),
      (
        'API & Data',
        Icons.api_outlined,
        AppColors.secondary,
        ['RESTful services', 'Firebase integration', 'Clean data flows']
      ),
      (
        'App State',
        Icons.account_tree_outlined,
        AppColors.tertiary,
        ['BLoC patterns', 'Organized architecture', 'Predictable behavior']
      ),
      (
        'Data & Storage',
        Icons.storage_outlined,
        AppColors.error,
        ['Firestore sync', 'Local caching', 'Real-time updates']
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          label: 'Skills',
          title: 'What I Build',
          subtitle:
              'Flutter strengths focused on clean design, reliable APIs, and smooth app behavior.',
        ),
        const SizedBox(height: 24),
        LayoutBuilder(builder: (ctx, constraints) {
          final cols = constraints.maxWidth > 800
              ? 4
              : constraints.maxWidth > 500
                  ? 2
                  : 1;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 200,
            ),
            itemCount: skills.length,
            itemBuilder: (_, i) {
              final s = skills[i];
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border(
                    top: BorderSide(color: s.$3, width: 2),
                    left: BorderSide(color: Colors.white.withOpacity(0.06)),
                    right: BorderSide(color: Colors.white.withOpacity(0.06)),
                    bottom: BorderSide(color: Colors.white.withOpacity(0.06)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(s.$2, color: s.$3, size: 32),
                    const SizedBox(height: 12),
                    Text(s.$1,
                        style: AppTextStyles.titleLg.copyWith(fontSize: 16)),
                    const SizedBox(height: 12),
                    ...s.$4.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: s.$3, shape: BoxShape.circle)),
                              const SizedBox(width: 8),
                              Text(item,
                                  style: AppTextStyles.bodyMd
                                      .copyWith(fontSize: 12)),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      _TimelineItem(
        '2025 — Present',
        'Flutter Developer @ Kaizen Star Technologies LLC',
        AppColors.primary,
        'Building reliable Flutter apps, improving performance, and working closely with designers and backend teams. Writing clear documentation and sharing best practices across the project.',
      ),
      _TimelineItem(
        '2024',
        'Flutter Developer Intern @ Luminar Technolab',
        AppColors.secondary,
        'Created and tested Flutter apps for real clients, helped fix issues, and supported the release process from concept to launch.',
      ),
      _TimelineItem(
        '2021 — 2024',
        'Bachelor of Science in Computer Science',
        AppColors.outline,
        'KMM College Of Arts And Science, Thrikkakkara | Mahatma Gandhi University',
      ),
    ];

    return LayoutBuilder(builder: (ctx, constraints) {
      final isWide = constraints.maxWidth > 700;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWide) ...[
            SizedBox(
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(
                      label: 'Experience', title: 'My Journey'),
                  const SizedBox(height: 16),
                  Text(
                    'A simple timeline of work, learning, and growth in mobile development.',
                    style: AppTextStyles.bodyMd,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 48),
          ],
          Expanded(
            child: Column(
              children: items.map((item) => _TimelineCard(item)).toList(),
            ),
          ),
        ],
      );
    });
  }
}

class _TimelineItem {
  final String date;
  final String role;
  final Color color;
  final String desc;
  const _TimelineItem(this.date, this.role, this.color, this.desc);
}

class _TimelineCard extends StatelessWidget {
  final _TimelineItem item;
  const _TimelineCard(this.item);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: item.color.withOpacity(0.6), blurRadius: 10)
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: item.color.withOpacity(0.3),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.date.toUpperCase(),
                      style: AppTextStyles.labelSm
                          .copyWith(color: item.color, letterSpacing: 1.5)),
                  const SizedBox(height: 6),
                  Text(item.role, style: AppTextStyles.titleLg),
                  const SizedBox(height: 10),
                  Text(item.desc, style: AppTextStyles.bodyMd),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Philosophy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(40),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(Icons.layers_outlined,
                size: 100, color: Colors.white.withOpacity(0.04)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(label: 'Approach', title: 'How I Work'),
              const SizedBox(height: 20),
              Text(
                'I believe great apps should feel natural on every device while staying easy to build and maintain. I focus on shared Flutter logic, thoughtful UI, and fast, accessible experiences.',
                style: AppTextStyles.bodyMd,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primaryContainer,
                          AppColors.secondary
                        ],
                      ),
                    ),
                    child:
                        const Icon(Icons.code, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('One codebase, many platforms',
                          style: AppTextStyles.titleLg.copyWith(fontSize: 16)),
                      Text('Built for speed, clarity, and ease of use',
                          style: AppTextStyles.bodyMd.copyWith(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
