part of '../main.dart';

// ─────────────────────────── CASE STUDY PAGE ───────────────────────────
class CaseStudyPage extends StatelessWidget {
  const CaseStudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CaseStudyHero(),
            const SizedBox(height: 64),
            _MultiPlatformChallenge(),
            const SizedBox(height: 64),
            _MetricsBento(),
            const SizedBox(height: 64),
            // _VisualGallery(),
            // const SizedBox(height: 64),
            _CTASection(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _CaseStudyHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CASE STUDY: TECHNICAL DEEP DIVE',
            style: AppTextStyles.labelSm
                .copyWith(color: AppColors.secondary, letterSpacing: 2),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: AppTextStyles.displayLg,
              children: [
                const TextSpan(text: 'QuantumPay: The '),
                const TextSpan(
                  text: 'Multi-Platform',
                  style: TextStyle(color: AppColors.primary),
                ),
                const TextSpan(text: '\nFinancial Engine'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'A Flutter app that brings powerful financial tools to both mobile and desktop users, with smooth, consistent experiences everywhere.',
            style: AppTextStyles.bodyMd,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _Chip(label: '⚡ High Performance', color: AppColors.primary),
              _Chip(
                  label: '🏗 Scalable Architecture',
                  color: AppColors.secondary),
            ],
          ),
        ],
      );
    });
  }
}

class _MultiPlatformChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: BorderRadius.circular(28),
      padding: const EdgeInsets.all(40),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(Icons.layers_outlined,
                size: 140, color: Colors.white.withOpacity(0.04)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('The Multi-Platform Challenge',
                  style: AppTextStyles.headlineMd),
              const SizedBox(height: 16),
              Text(
                'The primary goal was to achieve 100% pixel-perfect UI parity across diverse form factors while maintaining platform-specific behaviors. By leveraging Flutter\'s rendering engine, we bypassed limitations of platform-native views.',
                style: AppTextStyles.bodyMd,
              ),
              const SizedBox(height: 32),
              LayoutBuilder(builder: (ctx, constraints) {
                final cols = constraints.maxWidth > 600 ? 3 : 1;
                final features = [
                  (
                    'Adaptive Layouts',
                    Icons.aspect_ratio_outlined,
                    AppColors.primary,
                    'Complex breakpoint logic for fluid transitions from mobile rails to desktop drawers.'
                  ),
                  (
                    'Unified Inputs',
                    Icons.touch_app_outlined,
                    AppColors.secondary,
                    'Seamless handling of touch, mouse, and keyboard across all platforms.'
                  ),
                  (
                    'Skia Rendering',
                    Icons.speed_outlined,
                    AppColors.tertiary,
                    'Direct-to-GPU rendering for smooth 60fps animations regardless of OS.'
                  ),
                ];
                if (cols == 3) {
                  return Row(
                    children: features
                        .map((f) => Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: _FeatureBlock(f.$1, f.$2, f.$3, f.$4),
                              ),
                            ))
                        .toList(),
                  );
                }
                return Column(
                  children: features
                      .map((f) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _FeatureBlock(f.$1, f.$2, f.$3, f.$4),
                          ))
                      .toList(),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String desc;
  const _FeatureBlock(this.title, this.icon, this.color, this.desc);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyles.titleLg.copyWith(fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc, style: AppTextStyles.bodyMd.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}

class _MetricsBento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
            label: 'Engineering', title: 'System Engineering & Metrics'),
        const SizedBox(height: 24),
        LayoutBuilder(builder: (ctx, constraints) {
          final isWide = constraints.maxWidth > 700;
          return Column(
            children: [
              if (isWide)
                Row(children: [
                  Expanded(flex: 2, child: _ArchitectureCard()),
                  const SizedBox(width: 20),
                  Expanded(child: _PerformanceCard()),
                ])
              else
                Column(children: [
                  _ArchitectureCard(),
                  const SizedBox(height: 20),
                  _PerformanceCard()
                ]),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                    child: _MetricCard('94.8%', 'Test Coverage',
                        Icons.check_circle_outline, AppColors.primary)),
                const SizedBox(width: 20),
                Expanded(
                    child: _MetricCard('A+ Grade', 'Code Complexity',
                        Icons.analytics_outlined, AppColors.tertiary)),
                const SizedBox(width: 20),
                Expanded(
                    child: _MetricCard('GitHub Actions', 'CI/CD Pipeline',
                        Icons.check_circle, AppColors.secondary)),
              ]),
            ],
          );
        }),
      ],
    );
  }
}

class _ArchitectureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tags = [
      'Dart 3.x',
      'Flutter SDK',
      'Riverpod',
      'Google Maps SDK',
      'SQLite',
      'Firebase Auth'
    ];
    return GlassCard(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.account_tree_outlined,
                    color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Text('Clean Architecture & BLoC', style: AppTextStyles.titleLg),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Strictly decoupled architecture separating Business Logic from UI through the BLoC pattern, enabling 90%+ unit test coverage and easy feature integration.',
            style: AppTextStyles.bodyMd,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((t) => _Chip(label: t)).toList(),
          ),
        ],
      ),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final metrics = [
      ('Frame Rate', '60 FPS', 1.0),
      ('Memory Usage', '128 MB Avg.', 0.45),
      ('Bundle Size', '8.2 MB', 0.3),
    ];
    return GlassCard(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(28),
      borderColor: AppColors.secondary.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Performance', style: AppTextStyles.titleLg),
          const SizedBox(height: 24),
          ...metrics.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(m.$1,
                            style: const TextStyle(
                                fontSize: 13, color: AppColors.onSurface)),
                        Text(m.$2,
                            style: const TextStyle(
                                fontSize: 13, color: AppColors.secondary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _AnimatedBar(value: m.$3, color: AppColors.secondary),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _AnimatedBar extends StatefulWidget {
  final double value;
  final Color color;
  const _AnimatedBar({required this.value, required this.color});
  @override
  State<_AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<_AnimatedBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: _anim.value * widget.value,
          minHeight: 6,
          backgroundColor: AppColors.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation(widget.color),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  const _MetricCard(this.value, this.label, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(),
                    style: AppTextStyles.labelSm.copyWith(fontSize: 9)),
                const SizedBox(height: 4),
                Text(value,
                    style: AppTextStyles.titleLg.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    )),
              ],
            ),
          ),
          Icon(icon, color: color, size: 32),
        ],
      ),
    );
  }
}

// class _VisualGallery extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final colors = [
//       [AppColors.primaryContainer, AppColors.secondary],
//       [AppColors.tertiaryContainer, AppColors.tertiary],
//       [AppColors.primaryContainer, AppColors.primary],
//       [const Color(0xFF1A2B44), AppColors.secondaryContainer],
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             const Expanded(
//               child: _SectionHeader(
//                 label: 'Gallery',
//                 title: 'Visual Architecture',
//                 subtitle: 'Exploring interface logic across different screens',
//               ),
//             ),
//             GlassCard(
//               borderRadius: BorderRadius.circular(8),
//               padding: const EdgeInsets.all(4),
//               child: Row(
//                 children: ['Mobile', 'Tablet', 'Web'].map((t) {
//                   final active = t == 'Mobile';
//                   return Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                     decoration: active
//                         ? BoxDecoration(
//                             color: AppColors.primaryContainer,
//                             borderRadius: BorderRadius.circular(6),
//                           )
//                         : null,
//                     child: Text(t,
//                         style: AppTextStyles.labelSm.copyWith(
//                           color: active
//                               ? Colors.white
//                               : AppColors.onSurfaceVariant,
//                           fontWeight:
//                               active ? FontWeight.w700 : FontWeight.w500,
//                         )),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//         SizedBox(
//           height: 300,
//           child: Row(
//             children: List.generate(4, (i) {
//               return Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: i == 0 ? 0 : 8,
//                     top: i.isOdd ? 24 : 0,
//                   ),
//                   child: GlassCard(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors:
//                               colors[i].map((c) => c.withOpacity(0.4)).toList(),
//                         ),
//                       ),
//                       child: _MockMobileApp(),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _CTASection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.08),
              AppColors.secondary.withOpacity(0.08),
            ],
          ),
        ),
        child: Column(
          children: [
            Text('Built for Scalability.',
                style: AppTextStyles.headlineMd.copyWith(fontSize: 36)),
            const SizedBox(height: 16),
            Text(
              'The entire codebase is structured for rapid iteration and production-ready performance.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMd,
            ),
            const SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                _PrimaryButton(
                  onTap: () {
                    launchURL("https://github.com/Afees01");
                  },
                  label: 'Explore Codebase',
                  icon: const Icon(
                    Icons.terminal,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                _GhostButton(
                  label: 'Documentation',
                  onTap: () {
                    launchURL("https://docs.flutter.dev");
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
