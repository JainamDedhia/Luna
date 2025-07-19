/// 🚀 **LUNA APP CONFIGURATION**
/// 
/// 🎯 **Purpose**: Main application widget and configuration
/// 🏗️ **Architecture**: App Layer - Entry point and global setup
/// 🔗 **Dependencies**: Providers, Theme, Localization, Firebase
/// 📝 **Usage**: Called from main.dart to initialize the entire app
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// 🔄 Shared Providers - Global state management
import '../shared/providers/locale_provider.dart';
import '../shared/providers/theme_provider.dart';
import '../shared/providers/remedy_provider.dart';

// 🌍 Localization - Multi-language support
import '../l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// 🎯 Features - Authentication entry point
import '../features/authentication/presentation/pages/auth_screen.dart';

/// 🌙 **Luna App Widget**
/// 
/// Main application widget that sets up:
/// - 🎨 Theme management (dark/light mode)
/// - 🌍 Localization (multiple languages)
/// - 🔄 Global state providers
/// - 🔥 Firebase integration
/// - 🎯 Initial routing
class LunaApp extends StatefulWidget {
  const LunaApp({super.key});

  @override
  State<LunaApp> createState() => _LunaAppState();
}

class _LunaAppState extends State<LunaApp> with TickerProviderStateMixin {
  late AnimationController _themeAnimationController;

  @override
  void initState() {
    super.initState();
    
    // 🎨 Initialize theme animation controller
    _themeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // 🎯 Setup theme provider after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      themeProvider.setAnimationController(_themeAnimationController);
      themeProvider.loadTheme();
    });
  }

  @override
  void dispose() {
    _themeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocaleProvider, ThemeProvider>(
      builder: (context, localeProvider, themeProvider, child) {
        return AnimatedBuilder(
          animation: _themeAnimationController,
          builder: (context, child) {
            return MaterialApp(
              // 📱 App Configuration
              title: 'Luna - Ayurvedic Health Companion',
              theme: themeProvider.themeData,
              debugShowCheckedModeBanner: false,
              
              // 🌍 Localization Setup
              locale: localeProvider.locale,
              supportedLocales: const [
                Locale('en'), // English
                Locale('hi'), // Hindi
                Locale('gu'), // Gujarati
                Locale('mr'), // Marathi
                Locale('ta'), // Tamil
                Locale('te'), // Telugu
                Locale('ml'), // Malayalam
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              
              // 🎯 Initial Route - Authentication Screen
              home: const AuthScreen(),
            );
          },
        );
      },
    );
  }
}