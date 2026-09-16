import 'package:flutter/material.dart';
import 'screens/screens.dart';

class AppColors {
  static const green = Color(0xFF1F7A4D);
  static const darkGreen = Color(0xFF135238);
  static const mint = Color(0xFFEAF7EF);
  static const pale = Color(0xFFF7FAF8);
  static const ink = Color(0xFF1D2B24);
  static const muted = Color(0xFF6B7A72);
  static const orange = Color(0xFFF08A3C);
}

class SuperShopApp extends StatelessWidget {
  const SuperShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makkah Superstore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
        fontFamily: 'Arial',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 52, fontWeight: FontWeight.w800, color: AppColors.ink, height: 1.05),
          displayMedium: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, color: AppColors.ink),
          headlineSmall: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.ink),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.ink),
          bodyLarge: TextStyle(fontSize: 16, height: 1.55, color: AppColors.muted),
          bodyMedium: TextStyle(fontSize: 14, height: 1.45, color: AppColors.muted),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.pale,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.green,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE06C5A),
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE06C5A),
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 13,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.green,
            side: const BorderSide(color: Color(0xFFB9D6C4)),
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/categories': (_) => const CategoriesScreen(),
        '/products': (_) => const ProductsScreen(),
        '/about': (_) => const AboutScreen(),
        '/contact': (_) => const ContactScreen(),
      },
    );
  }
}