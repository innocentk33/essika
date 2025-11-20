import 'package:flutter/material.dart';

class AppTheme {
  // Palette principale
  static const Color primary = Color(0xFF713EFE); // #713efe
  static const Color backgroundLight = Color(0xFFf6f5f8); // #C5C5C5
  static const Color textBlack = Colors.black87;
  static final Color textGray = Colors.grey.shade700;

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      centerTitle: false,
    ),
    textTheme: _buildTextTheme(Brightness.light),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey.shade700,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primary),
      ),
      labelStyle: TextStyle(color: textGray),
      hintStyle: TextStyle(
        color: Color.fromRGBO(textGray.red, textGray.green, textGray.blue, 0.8),
      ),
    ),
    dividerColor: Colors.grey.shade300,
  );

  // Dark theme (variante cohérente)
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    ),
    // primary légèrement atténué (alpha 95%) — utiliser fromARGB pour éviter les méthodes dépréciées
    primaryColor: Color.fromARGB(242, primary.red, primary.green, primary.blue),
    // fond sombre demandé par l'utilisateur
    scaffoldBackgroundColor: const Color(0xFF140F23),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF121217),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white70),
      titleTextStyle: const TextStyle(
        color: Colors.white70,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      centerTitle: false,
    ),
    textTheme: _buildTextTheme(Brightness.dark),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(
          242,
          primary.red,
          primary.green,
          primary.blue,
        ),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF121217),
      selectedItemColor: Color.fromARGB(
        242,
        primary.red,
        primary.green,
        primary.blue,
      ),
      unselectedItemColor: Colors.grey.shade500,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E22),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF17171A),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade800),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Color.fromARGB(242, primary.red, primary.green, primary.blue),
        ),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade400),
      hintStyle: TextStyle(
        color: Color.fromARGB(
          229,
          Colors.grey.shade400.red,
          Colors.grey.shade400.green,
          Colors.grey.shade400.blue,
        ),
      ),
    ),
    dividerColor: Colors.grey.shade800,
  );

  // Private helper to build a consistent TextTheme
  static TextTheme _buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.light
        ? Typography.blackMountainView
        : Typography.whiteMountainView;
    final color = brightness == Brightness.light
        ? Colors.black87
        : Colors.white;

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(color: color),
      displayMedium: base.displayMedium?.copyWith(color: color),
      displaySmall: base.displaySmall?.copyWith(color: color),
      headlineMedium: base.headlineMedium?.copyWith(color: color),
      headlineSmall: base.headlineSmall?.copyWith(color: color),
      titleLarge: base.titleLarge?.copyWith(color: color),
      titleMedium: base.titleMedium?.copyWith(color: color),
      titleSmall: base.titleSmall?.copyWith(color: color),
      bodyLarge: base.bodyLarge?.copyWith(color: color),
      bodyMedium: base.bodyMedium?.copyWith(color: color),
      bodySmall: base.bodySmall?.copyWith(color: color),
      labelLarge: base.labelLarge?.copyWith(color: color),
      labelSmall: base.labelSmall?.copyWith(color: color),
    );
  }
}
