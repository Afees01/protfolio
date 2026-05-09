part of 'main.dart';

// ─────────────────────────── MAIN SHELL ───────────────────────────
abstract class MainShellNavigator {
  Future<void> scrollToSection(int index);
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  static MainShellNavigator? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainShellState>();

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> implements MainShellNavigator {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = List.generate(5, (_) => GlobalKey());
  bool _isScrolling = false;

  final List<_NavItem> _navItems = const [
    _NavItem('Home', Icons.home_outlined),
    _NavItem('Works', Icons.grid_view_outlined),
    _NavItem('Stack', Icons.layers_outlined),
    _NavItem('About', Icons.person_outlined),
    _NavItem('Contact', Icons.send_outlined),
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Container(key: _keys[0], child: const HomePage()),
      Container(key: _keys[1], child: const WorksPage()),
      Container(key: _keys[2], child: const CaseStudyPage()),
      Container(key: _keys[3], child: const AboutPage()),
      Container(key: _keys[4], child: const ContactPage()),
    ];
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isScrolling) return;
    for (int i = _keys.length - 1; i >= 0; i--) {
      final key = _keys[i];
      if (key.currentContext != null) {
        final box = key.currentContext!.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;
        if (position <= 200) {
          if (_currentIndex != i) {
            setState(() => _currentIndex = i);
          }
          break;
        }
      }
    }
  }

  @override
  Future<void> scrollToSection(int index) async {
    setState(() => _currentIndex = index);
    final context = _keys[index].currentContext;
    if (context != null) {
      _isScrolling = true;
      final box = context.findRenderObject() as RenderBox;
      double offset =
          _scrollController.offset + box.localToGlobal(Offset.zero).dy - 72;

      // Prevent scrolling beyond max extent
      offset = math.min(offset, _scrollController.position.maxScrollExtent);
      // Prevent scrolling before 0
      offset = math.max(offset, 0.0);

      await _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      _isScrolling = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Grid background
          const _GridBackground(),
          // Page content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 72),
                ..._pages,
              ],
            ),
          ),
          // Top Nav
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _TopNavBar(
              currentIndex: _currentIndex,
              navItems: _navItems,
              onTap: scrollToSection,
            ),
          ),
          // FAB
          Positioned(
            bottom: 28,
            right: 28,
            child: _FloatingActionBtn(
              onTap: () => scrollToSection(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  const _NavItem(this.label, this.icon);
}

// ─────────────────────────── TOP NAV ───────────────────────────
class _TopNavBar extends StatelessWidget {
  final int currentIndex;
  final List<_NavItem> navItems;
  final ValueChanged<int> onTap;

  const _TopNavBar({
    required this.currentIndex,
    required this.navItems,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF0A0B0F).withOpacity(0.75),
            border: const Border(
              bottom: BorderSide(color: Color(0x1AFFFFFF), width: 1),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryContainer.withOpacity(0.15),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                // Logo
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.primaryContainer, AppColors.cyan],
                  ).createShader(bounds),
                  child: Text(
                    'FlutterArchitect',
                    style: TextStyle(
                      fontFamily: GoogleFonts.lexend().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                // Nav links - only on larger screens
                if (MediaQuery.of(context).size.width > 700)
                  ...List.generate(navItems.length, (i) {
                    final active = currentIndex == i;
                    return GestureDetector(
                      onTap: () => onTap(i),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.only(bottom: 2),
                        decoration: active
                            ? const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.primaryContainer,
                                    width: 2,
                                  ),
                                ),
                              )
                            : null,
                        child: Text(
                          navItems[i].label,
                          style: TextStyle(
                            fontFamily: GoogleFonts.lexend().fontFamily,
                            fontSize: 14,
                            fontWeight:
                                active ? FontWeight.w700 : FontWeight.w500,
                            color:
                                active ? Colors.white : const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    );
                  }),
                const SizedBox(width: 16),
                // Platform icons
                Row(
                  children: [
                    _PlatformIcon(Icons.smartphone_outlined),
                    _PlatformIcon(Icons.laptop_outlined),
                    _PlatformIcon(Icons.desktop_windows_outlined),
                  ],
                ),
                const SizedBox(width: 16),
                // Hire Me Button
                _PrimaryButton(
                  label: 'Hire Me',
                  onTap: () => onTap(4),
                  compact: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlatformIcon extends StatelessWidget {
  final IconData icon;
  const _PlatformIcon(this.icon);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(icon, size: 20, color: const Color(0xFF94A3B8)),
    );
  }
}
