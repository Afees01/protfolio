part of '../main.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  int _projectType = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: LayoutBuilder(builder: (ctx, constraints) {
          final isWide = constraints.maxWidth > 900;
          final form = _ConsoleForm(
              projectType: _projectType,
              onProjectType: (i) => setState(() => _projectType = i));
          final sidebar = _ContactSidebar();

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: form),
                const SizedBox(width: 24),
                SizedBox(width: 300, child: sidebar),
              ],
            );
          }
          return Column(children: [form, const SizedBox(height: 24), sidebar]);
        }),
      ),
    );
  }
}

class _ConsoleForm extends StatefulWidget {
  final int projectType;
  final ValueChanged<int> onProjectType;
  const _ConsoleForm({required this.projectType, required this.onProjectType});

  @override
  State<_ConsoleForm> createState() => _ConsoleFormState();
}

class _ConsoleFormState extends State<_ConsoleForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  bool _isSuccess = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _dispatchSignal() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _messageController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.surfaceContainerHigh,
          title: const Text('Error', style: TextStyle(color: AppColors.error)),
          content: const Text(
              'Missing required parameters in payload. Please fill all fields.',
              style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('ACKNOWLEDGE',
                  style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
      _isSuccess = false;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isSubmitting = false;
        _isSuccess = true;
      });
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
      widget.onProjectType(-1);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.surfaceContainerHigh,
          title: const Text('Success',
              style: TextStyle(color: AppColors.secondary)),
          content: const Text(
              'Signal transmitted successfully. Stand by for response.',
              style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('CLOSE',
                  style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
      );

      // Reset success status after a few seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() => _isSuccess = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Connect With Developer',
            style: AppTextStyles.displayLg.copyWith(fontSize: 36)),
        const SizedBox(height: 12),
        Row(
          children: [
            _PulsingDot(
                color: _isSuccess ? AppColors.secondary : AppColors.tertiary),
            const SizedBox(width: 8),
            Text(
                _isSuccess
                    ? 'STATUS: TRANSMISSION SUCCESSFUL'
                    : (_isSubmitting
                        ? 'STATUS: TRANSMITTING SIGNAL...'
                        : 'STATUS: AWAITING SIGNAL TRANSMISSION'),
                style: AppTextStyles.labelSm.copyWith(
                    color:
                        _isSuccess ? AppColors.secondary : AppColors.tertiary)),
          ],
        ),
        const SizedBox(height: 32),
        GlassCard(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              // Terminal header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  border: Border(bottom: BorderSide(color: Color(0x0DFFFFFF))),
                ),
                child: Row(
                  children: [
                    _TrafficDot(AppColors.error.withValues(alpha: 0.7)),
                    _TrafficDot(AppColors.tertiary.withValues(alpha: 0.7)),
                    _TrafficDot(AppColors.secondary.withValues(alpha: 0.7)),
                    const Spacer(),
                    const Icon(Icons.terminal,
                        size: 14, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: 6),
                    Text('flutter_contact_controller.dart',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                            fontFamily: GoogleFonts.inter().fontFamily)),
                    const Spacer(),
                  ],
                ),
              ),
              // Form fields
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(builder: (ctx, constraints) {
                      final isWide = constraints.maxWidth > 500;
                      final nameField = _ConsoleField(
                          label: 'String clientName',
                          hint: 'Your Name',
                          controller: _nameController);
                      final emailField = _ConsoleField(
                          label: 'String clientEmail',
                          hint: 'dev@universe.io',
                          controller: _emailController);
                      if (isWide) {
                        return Row(
                          children: [
                            Expanded(child: nameField),
                            const SizedBox(width: 24),
                            Expanded(child: emailField),
                          ],
                        );
                      }
                      return Column(children: [
                        nameField,
                        const SizedBox(height: 20),
                        emailField
                      ]);
                    }),
                    const SizedBox(height: 28),
                    const _ConsoleLabel('ProjectType selection = ProjectType.'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _ProjectTypeOption(
                            0,
                            widget.projectType,
                            'App from Scratch',
                            Icons.rocket_launch_outlined,
                            AppColors.primary,
                            widget.onProjectType),
                        const SizedBox(width: 12),
                        _ProjectTypeOption(
                            1,
                            widget.projectType,
                            'UI Refactor',
                            Icons.auto_fix_high_outlined,
                            AppColors.secondary,
                            widget.onProjectType),
                        const SizedBox(width: 12),
                        _ProjectTypeOption(
                            2,
                            widget.projectType,
                            'Consultation',
                            Icons.forum_outlined,
                            AppColors.tertiary,
                            widget.onProjectType),
                      ],
                    ),
                    const SizedBox(height: 28),
                    const _ConsoleLabel('Future<void> projectBrief() {'),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryContainer,
                            AppColors.cyan,
                            AppColors.tertiary
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(1.5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: TextField(
                          controller: _messageController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: 'Describe your architectural vision...',
                            hintStyle: TextStyle(
                                color: Color(0x66C2C6D2),
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                          style: TextStyle(
                              color: AppColors.onSurface,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('}',
                        style: TextStyle(
                            color: AppColors.onSurfaceVariant,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontSize: 14)),
                    const SizedBox(height: 28),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _PrimaryButton(
                        label: _isSubmitting
                            ? 'Transmitting...'
                            : 'Dispatch Signal',
                        icon: _isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : const Icon(Icons.send,
                                color: Colors.white, size: 18),
                        onTap: _isSubmitting ? null : _dispatchSignal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrafficDot extends StatelessWidget {
  final Color color;
  const _TrafficDot(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _ConsoleLabel extends StatelessWidget {
  final String text;
  const _ConsoleLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style:
            TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 13),
        children: [
          TextSpan(
            text: text.contains(' ') ? text.split(' ').first + ' ' : text,
            style: const TextStyle(color: AppColors.tertiary),
          ),
          if (text.contains(' '))
            TextSpan(
              text: text.substring(text.indexOf(' ') + 1),
              style: const TextStyle(color: AppColors.primary),
            ),
        ],
      ),
    );
  }
}

class _ConsoleField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  const _ConsoleField(
      {required this.label, required this.hint, this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ConsoleLabel(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                color: Color(0x66C2C6D2),
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 14),
            filled: true,
            fillColor: AppColors.surfaceContainerLowest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          style: TextStyle(
              color: AppColors.onSurface,
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 14),
        ),
      ],
    );
  }
}

class _ProjectTypeOption extends StatelessWidget {
  final int index;
  final int selected;
  final String label;
  final IconData icon;
  final Color color;
  final ValueChanged<int> onTap;
  const _ProjectTypeOption(
      this.index, this.selected, this.label, this.icon, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    final active = index == selected;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: active
                ? color.withOpacity(0.1)
                : AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: active ? color : AppColors.outlineVariant,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelSm.copyWith(
                    color: active ? color : AppColors.onSurfaceVariant,
                    fontSize: 10,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile card
        GlassCard(
          borderRadius: BorderRadius.circular(16),
          borderColor: AppColors.secondary.withOpacity(0.3),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.secondary, width: 2),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primaryContainer,
                          AppColors.secondary
                        ],
                      ),
                    ),
                    child:
                        const Icon(Icons.person, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alex Rivero', style: AppTextStyles.titleLg),
                      Text('Lead Flutter Architect',
                          style: AppTextStyles.labelSm.copyWith(
                              color: AppColors.secondary, letterSpacing: 0.5)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...[
                ('GitHub', Icons.code_outlined),
                ('LinkedIn', Icons.hub_outlined),
                ('Twitter', Icons.chat_bubble_outline),
              ].map((item) => _SocialLink(item.$1, item.$2)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Coffee card
        GlassCard(
          borderRadius: BorderRadius.circular(16),
          borderColor: AppColors.tertiary.withOpacity(0.3),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Support the SDK',
                  style: AppTextStyles.titleLg
                      .copyWith(color: AppColors.tertiary)),
              const SizedBox(height: 8),
              Text(
                  'Fuel maintenance of open-source Flutter packages and community tooling.',
                  style: AppTextStyles.bodyMd),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.tertiary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.favorite, color: Colors.black, size: 18),
                      const SizedBox(width: 8),
                      Text('Buy me a Coffee',
                          style: AppTextStyles.titleLg.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Platforms card
        GlassCard(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DEPLOYMENT TARGETS',
                  style: AppTextStyles.labelSm.copyWith(letterSpacing: 2)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _Chip(label: 'iOS / Android', color: AppColors.primary),
                  _Chip(label: 'Web (WASM)', color: AppColors.secondary),
                  _Chip(label: 'Desktop (Linux)', color: AppColors.tertiary),
                  _Chip(label: 'Embedded', color: AppColors.onSurfaceVariant),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class _SocialLink extends StatelessWidget {
  final String label;
  final IconData icon;
  const _SocialLink(this.label, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0x0DFFFFFF)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.onSurfaceVariant),
          const SizedBox(width: 12),
          Text(label.toUpperCase(),
              style:
                  AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
          const Spacer(),
          const Icon(Icons.north_east,
              size: 16, color: AppColors.onSurfaceVariant),
        ],
      ),
    );
  }
}
