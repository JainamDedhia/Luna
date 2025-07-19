/// 🌙 **LUNA - AYURVEDIC HEALTH COMPANION**
/// 
/// 🎯 **Purpose**: Application entry point and provider setup
/// 🏗️ **Architecture**: App Entry Point
/// 🔗 **Dependencies**: Firebase, Providers, App Configuration
/// 📝 **Usage**: Main entry point - sets up the entire application
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team
/// 
/// 🌟 **About Luna**:
/// Luna is a multilingual, AI-powered mobile chatbot that delivers 
/// personalized Ayurvedic health guidance instantly and in your local language.

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// 🚀 App Configuration
import 'app/app.dart';

// 🔄 Shared Providers
import 'shared/providers/providers.dart';

/// 🚀 **Main Function**
/// 
/// Application entry point that:
/// 1. 🔥 Initializes Firebase
/// 2. 🔄 Sets up global providers
/// 3. 🌙 Launches Luna app
/// 
/// **Provider Setup**:
/// - 🌍 LocaleProvider: Language management
/// - 🎨 ThemeProvider: Dark/light theme
/// - 💊 RemedyProvider: Weather-based remedies
void main() async {
  // 🔧 **Flutter Initialization**
  WidgetsFlutterBinding.ensureInitialized();
  
  // 🔥 **Firebase Initialization**
  await Firebase.initializeApp();
  
  // 🚀 **Launch App with Providers**
  runApp(
    MultiProvider(
      providers: [
        // 🌍 **Localization Provider**
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        
        // 🎨 **Theme Provider**
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        
        // 💊 **Remedy Provider**
        ChangeNotifierProvider(create: (_) => RemedyProvider()),
      ],
      child: const LunaApp(),
    ),
  );
}