@@ .. @@
 import 'package:flutter/material.dart';
 import 'package:shared_preferences/shared_preferences.dart';
+import '../theme/app_theme.dart';

 class ThemeProvider extends ChangeNotifier {
   bool _isDarkMode = true;
@@ .. @@
   Future<void> toggleTheme() async {
     _isDarkMode = !_isDarkMode;
     final prefs = await SharedPreferences.getInstance();
     await prefs.setBool('isDarkMode', _isDarkMode);
     
     // Trigger theme transition animation
     _themeAnimationController.forward().then((_) {
       _themeAnimationController.reverse();
     });
     
     notifyListeners();
   }

-  // Dark theme colors
-  static const Color darkPrimary = Color(0xFF9AFF00);
-  static const Color darkBackground = Color(0xFF0A0A0A);
-  static const Color darkSurface = Color(0xFF1A1A1A);
-  static const Color darkCard = Color(0xFF252525);
-  static const Color darkText = Colors.white;
-  static const Color darkSecondaryText = Color(0xFF888888);
-
-  // Light theme colors
-  static const Color lightPrimary = Color(0xFF7CB342);
-  static const Color lightBackground = Color(0xFFFAFAFA);
-  static const Color lightSurface = Color(0xFFFFFFFF);
-  static const Color lightCard = Color(0xFFF5F5F5);
-  static const Color lightText = Color(0xFF1A1A1A);
-  static const Color lightSecondaryText = Color(0xFF666666);
-
-  // Current theme colors
-  Color get primaryColor => _isDarkMode ? darkPrimary : lightPrimary;
-  Color get backgroundColor => _isDarkMode ? darkBackground : lightBackground;
-  Color get surfaceColor => _isDarkMode ? darkSurface : lightSurface;
-  Color get cardColor => _isDarkMode ? darkCard : lightCard;
-  Color get textColor => _isDarkMode ? darkText : lightText;
-  Color get secondaryTextColor => _isDarkMode ? darkSecondaryText : lightSecondaryText;
+  // Get current theme colors from centralized theme
+  LunaColors get colors => _isDarkMode ? LunaColors.dark : LunaColors.light;
+  
+  // Convenient getters for commonly used colors
+  Color get primaryColor => colors.primary;
+  Color get backgroundColor => colors.background;
+  Color get surfaceColor => colors.surface;
+  Color get cardColor => colors.card;
+  Color get textColor => colors.textPrimary;
+  Color get secondaryTextColor => colors.textSecondary;

   ThemeData get themeData {
-    return ThemeData(
-      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
-      primaryColor: primaryColor,
-      scaffoldBackgroundColor: backgroundColor,
-      cardColor: cardColor,
-      textTheme: TextTheme(
-        bodyLarge: TextStyle(color: textColor),
-        bodyMedium: TextStyle(color: textColor),
-        titleLarge: TextStyle(color: textColor),
-        titleMedium: TextStyle(color: textColor),
-      ),
-      appBarTheme: AppBarTheme(
-        backgroundColor: surfaceColor,
-        foregroundColor: textColor,
-        elevation: 0,
-      ),
-      elevatedButtonTheme: ElevatedButtonThemeData(
-        style: ElevatedButton.styleFrom(
-          backgroundColor: primaryColor,
-          foregroundColor: _isDarkMode ? darkBackground : lightBackground,
-        ),
-      ),
-    );
+    return _isDarkMode ? LunaAppTheme.darkTheme : LunaAppTheme.lightTheme;
   }
 }