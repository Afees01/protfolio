import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

part 'theme.dart';
part 'main_shell.dart';
part 'shared_components.dart';
part 'screens/home_page.dart';
part 'screens/works_page.dart';
part 'screens/case_study_page.dart';
part 'screens/about_page.dart';
part 'screens/contact_page.dart';


void main() {
  runApp(const FlutterArchitectApp());
}

// ─────────────────────────── APP ROOT ───────────────────────────
class FlutterArchitectApp extends StatelessWidget {
  const FlutterArchitectApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: 'Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          background: AppColors.background,
          surface: AppColors.surface,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}

