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
            _OpenSource(),
            const SizedBox(height: 64),
            _Philosophy(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
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
                    Text('Dart Expert',
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
                const TextSpan(text: 'Architecting seamless '),
                const TextSpan(
                    text: 'Cross-Platform',
                    style: TextStyle(color: AppColors.primary)),
                const TextSpan(text: ' experiences.'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Senior Flutter Engineer specialized in building high-performance, scalable applications that feel native on every screen. From intricate animations to robust architecture, I bridge the gap between complex logic and beautiful UI.',
            style: AppTextStyles.bodyMd,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _PrimaryButton(
                label: 'Download CV',
                icon: const Icon(Icons.download, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 16),
              const _GhostButton(label: 'View Projects'),
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
        'Flutter Core',
        Icons.layers_outlined,
        AppColors.primary,
        ['Custom Painting', 'Render Objects', 'Micro-interactions']
      ),
      (
        'State Management',
        Icons.account_tree_outlined,
        AppColors.secondary,
        ['BLoC / RxDart', 'Riverpod', 'Clean Architecture']
      ),
      (
        'Platform Channels',
        Icons.terminal_outlined,
        AppColors.tertiary,
        ['Method Channels', 'Swift/Kotlin Interop', 'FFI Integration']
      ),
      (
        'CI/CD',
        Icons.bolt_outlined,
        AppColors.error,
        ['Codemagic / GH Actions', 'Fastlane Automation', 'Automated Testing']
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          label: 'Skills',
          title: 'The Widget Tree',
          subtitle:
              'Technical proficiency mapped across the Flutter ecosystem.',
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
          '2022 — Present',
          'Lead Flutter Architect @ TechFlow',
          AppColors.primary,
          'Leading 12 engineers migrating a monolithic app to Flutter, serving 2M+ active users. Implementing modular design systems and custom rendering engines.'),
      _TimelineItem(
          '2020 — 2022',
          'Senior Mobile Developer @ InnovateHQ',
          AppColors.secondary,
          'Architected fintech applications with high-security standards and real-time data visualization using custom-painter charts.'),
      _TimelineItem(
          '2018 — 2020',
          'Full Stack Engineer @ StartupLabs',
          AppColors.outline,
          'Early Flutter Beta adopter. Shipped 3 MVP products to both iOS and Android within aggressive 3-month timelines.'),
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
                  const _SectionHeader(label: 'History', title: 'Career.dart'),
                  const SizedBox(height: 16),
                  Text(
                    'A sequence of architectural milestones in the mobile engineering space.',
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

class _OpenSource extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projects = [
      (
        'flutter_glass_kit',
        Icons.terminal_outlined,
        '1.2k',
        'High-performance glassmorphism toolkit with dynamic blurring and real-time light simulation.',
        ['Flutter', 'Dart', 'UI Library']
      ),
      (
        'bloc_persistence_layer',
        Icons.account_tree_outlined,
        '850',
        'Lightweight abstraction for automated local caching and hydration for BLoC state patterns.',
        ['State Mgmt', 'Architecture', 'Core']
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(label: 'OSS', title: 'Open Source Contributions'),
        const SizedBox(height: 24),
        LayoutBuilder(builder: (ctx, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: projects
                  .map((p) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _OSSCard(p.$1, p.$2, p.$3, p.$4, p.$5),
                        ),
                      ))
                  .toList(),
            );
          }
          return Column(
            children: projects
                .map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _OSSCard(p.$1, p.$2, p.$3, p.$4, p.$5),
                    ))
                .toList(),
          );
        }),
      ],
    );
  }
}

class _OSSCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String stars;
  final String desc;
  final List<String> tags;
  const _OSSCard(this.name, this.icon, this.stars, this.desc, this.tags);
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 32),
              const Spacer(),
              const Icon(Icons.star_rounded,
                  color: AppColors.tertiary, size: 16),
              const SizedBox(width: 4),
              Text(stars,
                  style: AppTextStyles.titleLg
                      .copyWith(fontSize: 14, color: AppColors.tertiary)),
            ],
          ),
          const SizedBox(height: 16),
          Text(name, style: AppTextStyles.titleLg),
          const SizedBox(height: 8),
          Text(desc, style: AppTextStyles.bodyMd),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags
                .map((t) => _Chip(label: t, color: AppColors.primary))
                .toList(),
          ),
        ],
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
              const _SectionHeader(
                  label: 'Vision', title: 'Cross-Platform Philosophy'),
              const SizedBox(height: 20),
              Text(
                '"Code should be written once and deployed everywhere, but it should never feel generic. True cross-platform excellence lies in respecting the platform\'s specific design language while maintaining a unified brand core. My approach focuses on shared logic, unique expression."',
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
                      Text('Unified UI/UX Engine',
                          style: AppTextStyles.titleLg.copyWith(fontSize: 16)),
                      Text('Driven by Performance & Accessibility',
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
