/// ⚙️ **LUNA APP CONFIGURATION**
/// 
/// 🎯 **Purpose**: Application-wide configuration and constants
/// 🏗️ **Architecture**: App Layer - Configuration management
/// 🔗 **Dependencies**: None (pure configuration)
/// 📝 **Usage**: Import to access app-wide settings and constants
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

/// 🌙 **Luna App Configuration**
/// 
/// Contains all application-wide configuration settings:
/// - 📱 App metadata (name, version, description)
/// - 🌐 API endpoints and timeouts
/// - 🎨 UI constants (sizes, animations)
/// - 🔧 Feature flags and environment settings
class AppConfig {
  // 📱 **App Information**
  static const String appName = 'Luna';
  static const String appFullName = 'Luna - Ayurvedic Health Companion';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Your multilingual AI-powered Ayurvedic health assistant';
  
  // 🌐 **API Configuration**
  static const String baseApiUrl = 'https://b7e4-34-125-152-230.ngrok-free.app';
  static const int apiTimeoutSeconds = 30;
  static const String weatherApiKey = '2da60aa52aed4523dbca6d31deb340c9';
  
  // 🎨 **UI Constants**
  static const double defaultBorderRadius = 16.0;
  static const double cardElevation = 2.0;
  static const double defaultIconSize = 24.0;
  static const double avatarSize = 36.0;
  static const double defaultPadding = 16.0;
  
  // ⏱️ **Animation Durations (in milliseconds)**
  static const int typingAnimationDuration = 1500;
  static const int messageAnimationDuration = 300;
  static const int themeTransitionDuration = 800;
  static const int pageTransitionDuration = 300;
  
  // 🎯 **Feature Flags**
  static const bool enableVoiceInput = true;
  static const bool enableOfflineMode = true;
  static const bool enableAnalytics = false;
  static const bool enableCrashReporting = false;
  
  // 🌍 **Supported Languages**
  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'hi': 'Hindi',
    'gu': 'Gujarati',
    'mr': 'Marathi',
    'ta': 'Tamil',
    'te': 'Telugu',
    'ml': 'Malayalam',
  };
  
  // 🏥 **Emergency Keywords**
  static const List<String> emergencyKeywords = [
    'severe', 'emergency', 'urgent', 'serious', 'immediate', 
    'critical', 'danger', 'help', 'pain', 'bleeding'
  ];
  
  // 📱 **Platform Settings**
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static const String environment = isProduction ? 'production' : 'development';
}