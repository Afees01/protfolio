part of '../main.dart';

// ─────────────────────────── HOME PAGE ───────────────────────────
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroSection(),
            const SizedBox(height: 64),
            _TechStackSection(),
            const SizedBox(height: 64),
            _FeaturedProjectSection(),
            const SizedBox(height: 64),
            _ExpertiseSection(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;

    return isWide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _HeroText()),
              const SizedBox(width: 48),
              const SizedBox(
                width: 400,
                height: 480,
                child: _DevicesMockup(),
              ),
            ],
          )
        : Column(
            children: [
              _HeroText(),
              const SizedBox(height: 40),
              const SizedBox(height: 380, child: _DevicesMockup()),
            ],
          );
  }
}

class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassCard(
          borderRadius: BorderRadius.circular(999),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulsingDot(color: AppColors.secondaryContainer),
              const SizedBox(width: 8),
              Text(
                'READY TO BUILD TOGETHER',
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.secondaryContainer,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            style: AppTextStyles.displayLg,
            children: [
              const TextSpan(text: 'Hey, I\'m '),
              WidgetSpan(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondaryContainer,
                      AppColors.tertiary,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'AFEES K A',
                    style: AppTextStyles.displayLg,
                  ),
                ),
              ),
              const TextSpan(text: '.\nFlutter Developer'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'I build clean, reliable Flutter apps for Android and iOS, with a focus on friendly UI, efficient backends, and maintainable BLoC architecture.',
          style: AppTextStyles.bodyMd,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            _PrimaryButton(
              label: 'Explore Portfolio',
              icon: const Icon(Icons.arrow_forward,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(width: 16),
            const _GhostButton(label: 'Read Blog'),
          ],
        ),
      ],
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.5 + 0.5 * _ctrl.value),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _DevicesMockup extends StatelessWidget {
  const _DevicesMockup();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Desktop mockup (back)
        Positioned(
          right: -16,
          top: 40,
          child: Transform.rotate(
            angle: 0.05,
            child: GlassCard(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 320,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryContainer.withOpacity(0.4),
                      AppColors.surfaceContainerHigh,
                    ],
                  ),
                ),
                child: _MockDashboard(),
              ),
            ),
          ),
        ),
        // Mobile mockup (front)
        Positioned(
          bottom: 16,
          right: 80,
          child: GlassCard(
            borderRadius: BorderRadius.circular(36),
            child: Container(
              width: 120,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                border: Border.all(color: const Color(0xFF334155), width: 4),
                color: AppColors.surfaceContainerLowest,
              ),
              child: _MockMobileApp(),
            ),
          ),
        ),
        // Glow blob
        Positioned(
          top: 80,
          left: 60,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryContainer.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MockDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  width: 40,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(3),
                  )),
              const SizedBox(width: 8),
              Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(3),
                  )),
            ],
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    )),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                  children: [
                    _MockChartBar(),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _MockStatCard(AppColors.primary)),
                        const SizedBox(width: 8),
                        Expanded(child: _MockStatCard(AppColors.secondary)),
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MockChartBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heights = [0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 1.0, 0.7];
    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: heights.map((h) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                height: 60 * h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [AppColors.primaryContainer, AppColors.secondary],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MockStatCard extends StatelessWidget {
  final Color color;
  const _MockStatCard(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
    );
  }
}

class _MockMobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 6,
              width: 40,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryContainer.withOpacity(0.4),
                    AppColors.secondaryContainer.withOpacity(0.2)
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8),
                      ))),
              const SizedBox(width: 6),
              Expanded(
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ))),
            ]),
            const SizedBox(height: 8),
            Container(
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(3),
                )),
            const SizedBox(height: 6),
            Container(
                height: 6,
                width: 60,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(3),
                )),
          ],
        ),
      ),
    );
  }
}

class _TechStackSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cards = [
      _TechCard(
          'Flutter SDK',
          Icons.widgets_outlined,
          AppColors.primary,
          'Consistent UI across iOS, Android, Web & Desktop at 60FPS.',
          ['Custom Painters', 'Method Channels']),
      _TechCard(
          'Firebase',
          Icons.local_fire_department_outlined,
          AppColors.tertiary,
          'Real-time database, authentication, and cloud functions.',
          ['Firestore', 'Cloud Messaging']),
      _TechCard(
          'Riverpod',
          Icons.account_tree_outlined,
          AppColors.secondary,
          'Compile-time safe, highly testable state management.',
          ['Providers', 'StateNotifier']),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          label: 'Technology',
          title: 'Current Tech Stack',
          subtitle:
              'Precision-selected tools for scalable, reactive enterprise apps.',
        ),
        const SizedBox(height: 24),
        LayoutBuilder(builder: (ctx, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              children: cards
                  .map((c) => Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: c)))
                  .toList(),
            );
          }
          return Column(
            children: cards
                .map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 16), child: c))
                .toList(),
          );
        }),
      ],
    );
  }
}

class _TechCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String desc;
  final List<String> tags;
  const _TechCard(this.title, this.icon, this.color, this.desc, this.tags);
  @override
  State<_TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<_TechCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GlassCard(
          borderRadius: BorderRadius.circular(24),
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(_hovered ? 0.25 : 0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: widget.color.withOpacity(0.3)),
                ),
                child: Icon(widget.icon, color: widget.color, size: 28),
              ),
              const SizedBox(height: 20),
              Text(widget.title, style: AppTextStyles.titleLg),
              const SizedBox(height: 8),
              Text(widget.desc, style: AppTextStyles.bodyMd),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.tags
                    .map((t) => _Chip(label: t, color: widget.color))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedProjectSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: BorderRadius.circular(32),
      child: LayoutBuilder(builder: (ctx, constraints) {
        final isWide = constraints.maxWidth > 700;
        final content = _FeaturedProjectContent();
        final image = Container(
          height: isWide ? null : 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryContainer.withOpacity(0.5),
                AppColors.surfaceContainerHigh,
              ],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _MockDashboard(),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin:
                        isWide ? Alignment.centerRight : Alignment.bottomCenter,
                    end: isWide ? Alignment.centerLeft : Alignment.topCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.surfaceContainerLowest.withOpacity(0.8)
                    ],
                  ),
                ),
              ),
              const Positioned(
                bottom: 24,
                left: 24,
                child: _FeaturedBadge(),
              ),
            ],
          ),
        );

        if (isWide) {
          return IntrinsicHeight(
            child: Row(
              children: [
                Expanded(flex: 3, child: image),
                Expanded(flex: 2, child: content),
              ],
            ),
          );
        }
        return Column(children: [image, content]);
      }),
    );
  }
}

class _FeaturedBadge extends StatelessWidget {
  const _FeaturedBadge();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'FEATURED PROJECT',
        style: AppTextStyles.labelSm
            .copyWith(color: AppColors.onPrimary, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _FeaturedProjectContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Zenith Fintech Suite', style: AppTextStyles.headlineMd),
          const SizedBox(height: 12),
          Text(
            'A comprehensive wealth management platform built from the ground up using Flutter. Features complex real-time charting, biometric security, and multi-currency support.',
            style: AppTextStyles.bodyMd,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Chip(label: 'Dart 3.0', color: AppColors.secondary),
              _Chip(label: 'Isolates', color: AppColors.secondary),
              _Chip(label: 'gRPC', color: AppColors.secondary),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _PrimaryButton(
                  label: 'GitHub',
                  icon: const Icon(Icons.code, color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _GhostButton(label: 'Web Demo'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExpertiseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      (
        'UI/UX Precision',
        'Pixel-perfect implementation with smooth 60fps animations.'
      ),
      (
        'Performance',
        'Optimization for large datasets and heavy computations.'
      ),
      ('Maintainability', 'Clean architecture and comprehensive test suites.'),
      (
        'Multi-OS Ready',
        'Adaptive layouts for iOS, Android, macOS, Windows, Web.'
      ),
    ];

    return LayoutBuilder(builder: (ctx, constraints) {
      final isWide = constraints.maxWidth > 700;
      if (isWide) {
        return Row(
          children: items
              .map((i) => Expanded(child: _ExpertiseCard(i.$1, i.$2)))
              .toList(),
        );
      }
      return Column(
        children: items.map((i) => _ExpertiseCard(i.$1, i.$2)).toList(),
      );
    });
  }
}

class _ExpertiseCard extends StatelessWidget {
  final String title;
  final String desc;
  const _ExpertiseCard(this.title, this.desc);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0x4D02539A), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.titleLg),
          const SizedBox(height: 8),
          Text(desc, style: AppTextStyles.bodyMd.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
