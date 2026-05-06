part of 'main.dart';

// ─────────────────────────── DESIGN TOKENS ───────────────────────────
class AppColors {
  static const background = Color(0xFF131315);
  static const surface = Color(0xFF131315);
  static const surfaceContainer = Color(0xFF201F21);
  static const surfaceContainerHigh = Color(0xFF2A2A2C);
  static const surfaceContainerHighest = Color(0xFF353437);
  static const surfaceContainerLow = Color(0xFF1B1B1D);
  static const surfaceContainerLowest = Color(0xFF0E0E10);
  static const onSurface = Color(0xFFE5E1E4);
  static const onSurfaceVariant = Color(0xFFC2C6D2);
  static const primary = Color(0xFFA6C8FF);
  static const primaryContainer = Color(0xFF02539A);
  static const onPrimary = Color(0xFF00315F);
  static const secondary = Color(0xFF81CFFF);
  static const secondaryContainer = Color(0xFF00B4F7);
  static const tertiary = Color(0xFFFABD00);
  static const tertiaryContainer = Color(0xFF6A4E00);
  static const outline = Color(0xFF8C919C);
  static const outlineVariant = Color(0xFF424751);
  static const error = Color(0xFFFFB4AB);
  static const cyan = Color(0xFF00B4F7);
}

class AppTextStyles {
  static final displayLg = GoogleFonts.lexend(
    fontSize: 52,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.04,
    height: 1.1,
    color: AppColors.onSurface,
  );
  static final headlineMd = GoogleFonts.lexend(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.28,
    height: 1.2,
    color: AppColors.onSurface,
  );
  static final titleLg = GoogleFonts.lexend(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.onSurface,
  );
  static final bodyMd = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurfaceVariant,
  );
  static final labelSm = GoogleFonts.spaceGrotesk(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: AppColors.onSurfaceVariant,
  );
}
