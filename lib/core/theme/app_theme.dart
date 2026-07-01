import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme =

      ThemeData(

    brightness: Brightness.light,

    scaffoldBackgroundColor:
        const Color(0xFFF7F8FC),

    primaryColor:
        const Color(0xFF6C63FF),

    colorScheme: ColorScheme.light(

      primary:
          const Color(0xFF6C63FF),

      secondary:
          const Color(0xFF8B80FF),
    ),

    appBarTheme: const AppBarTheme(

      backgroundColor: Colors.transparent,

      elevation: 0,

      centerTitle: true,

      foregroundColor: Colors.black,
    ),

    textTheme: const TextTheme(

      headlineMedium: TextStyle(

        fontSize: 28,

        fontWeight: FontWeight.bold,

        color: Colors.black,
      ),

      bodyLarge: TextStyle(

        fontSize: 16,

        color: Colors.black87,
      ),
    ),

    inputDecorationTheme:

        InputDecorationTheme(

      filled: true,

      fillColor: Colors.white,

      contentPadding:
          const EdgeInsets.symmetric(

        horizontal: 20,
        vertical: 18,
      ),

      border: OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(18),

        borderSide: BorderSide(

          color: Colors.grey.shade200,
        ),
      ),

      focusedBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(18),

        borderSide: const BorderSide(

          color: Color(0xFF6C63FF),

          width: 2,
        ),
      ),
    ),

    elevatedButtonTheme:

        ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor:
            const Color(0xFF6C63FF),

        foregroundColor: Colors.white,

        elevation: 0,

        minimumSize:
            const Size(double.infinity, 58),

        shape: RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(18),
        ),
      ),
    ),
  );

  // DARK THEME

  static ThemeData darkTheme =

      ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor:
        const Color(0xFF121212),

    primaryColor:
        const Color(0xFF8B80FF),

    colorScheme: const ColorScheme.dark(

      primary:
          Color(0xFF8B80FF),

      secondary:
          Color(0xFF6C63FF),
    ),

    appBarTheme: const AppBarTheme(

      backgroundColor: Colors.transparent,

      elevation: 0,
    ),

    inputDecorationTheme:

        InputDecorationTheme(

      filled: true,

      fillColor:
          const Color(0xFF1E1E1E),

      contentPadding:
          const EdgeInsets.symmetric(

        horizontal: 20,
        vertical: 18,
      ),

      border: OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),
    ),

    elevatedButtonTheme:

        ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor:
            const Color(0xFF8B80FF),

        foregroundColor: Colors.white,

        minimumSize:
            const Size(double.infinity, 58),

        shape: RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(18),
        ),
      ),
    ),
  );
}