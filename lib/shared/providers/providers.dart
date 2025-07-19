/// 🔄 **SHARED PROVIDERS BARREL FILE**
/// 
/// 🎯 **Purpose**: Central export for all shared providers
/// 🏗️ **Architecture**: Shared Layer - Provider exports
/// 🔗 **Dependencies**: All provider files
/// 📝 **Usage**: Import this file to access all shared providers
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

// 🎨 Theme Management
export 'theme_provider.dart';

// 🌍 Localization Management  
export 'locale_provider.dart';

// 💊 Remedy Management
export 'remedy_provider.dart';

/// 📖 **Provider Documentation**
/// 
/// **ThemeProvider**: Manages dark/light theme switching with animations
/// **LocaleProvider**: Handles language selection and locale changes
/// **RemedyProvider**: Manages weather-based remedy suggestions
/// 
/// **Usage Example**:
/// ```dart
/// import 'package:medical/shared/providers/providers.dart';
/// 
/// // In your widget
/// Consumer<ThemeProvider>(
///   builder: (context, themeProvider, child) {
///     return Container(
///       color: themeProvider.backgroundColor,
///       child: child,
///     );
///   },
/// )
/// ```