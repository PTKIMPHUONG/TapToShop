import 'package:flutter/material.dart';

ThemeData buildTheme() {
  return ThemeData(
    primarySwatch: Colors.pink,
    useMaterial3: true, 

    // Định nghĩa màu sắc
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pink,
      primary: Colors.pink,
      secondary: Colors.pinkAccent,
    ),

    // Định nghĩa kiểu chữ
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    ),

    // Định nghĩa kiểu button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.pink, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), 
        ),
      ),
    ),

    // Định nghĩa kiểu app bar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white, 
      elevation: 4.0, 
    ),

    // Định nghĩa kiểu icon
    iconTheme: const IconThemeData(
      color: Colors.pink, 
      size: 24.0,
    ),

    // Định nghĩa kiểu input
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0), 
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.pink),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink[300]!),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
