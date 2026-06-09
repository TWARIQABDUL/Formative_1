import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'layout/app_layout.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formative App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryAccent,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: AppColors.background,
        // Using a standard font to match the clean design
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ).apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
        useMaterial3: true,
      ),
      home: const AppLayout(),
    );
  }
}
