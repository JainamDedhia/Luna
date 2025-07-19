/// ⚙️ **CORE APP CONSTANTS**
/// 
/// 🎯 **Purpose**: Core application constants and configuration values
/// 🏗️ **Architecture**: Core Layer - Constants and configuration
/// 🔗 **Dependencies**: None (pure constants)
/// 📝 **Usage**: Import to access app-wide constants and settings
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

/// 🔧 **Core Application Constants**
/// 
/// Contains essential constants used throughout the app:
/// - 📝 Text constants and messages
/// - 🎨 UI measurements and spacing
/// - ⚠️ Error messages and alerts
/// - 🏥 Health-related constants
class AppConstants {
  // 📝 **Default Messages**
  static const String welcomeMessage = 
      '🙏 Namaste! I\'m your Ayurvedic First-Aid assistant. How can I help you today?';
  
  static const String errorMessage = 
      '⚠️ Sorry, I encountered an error. Please try again or consult a healthcare professional if it\'s urgent.';
  
  static const String networkErrorMessage = 
      '🌐 Network error. Please check your connection and try again.';
  
  static const String inputHint = 'Describe your health concern...';
  static const String typingIndicator = 'Analyzing your query...';
  
  // 🎨 **UI Constants**
  static const double borderRadius = 16.0;
  static const double cardElevation = 2.0;
  static const double iconSize = 24.0;
  static const double avatarSize = 36.0;
  static const double defaultSpacing = 16.0;
  static const double smallSpacing = 8.0;
  static const double largeSpacing = 24.0;
  
  // ⏱️ **Animation Durations**
  static const int typingAnimationDuration = 1500;
  static const int messageAnimationDuration = 300;
  static const int loadingDelay = 1500;
  static const int splashDuration = 2000;
  
  // 🏥 **Health & Emergency**
  static const List<String> emergencyKeywords = [
    'severe', 'emergency', 'urgent', 'serious', 'immediate',
    'critical', 'danger', 'help', 'pain', 'bleeding', 'unconscious'
  ];
  
  // 🌡️ **Weather-Based Remedy Categories**
  static const List<String> weatherConditions = [
    'clear', 'clouds', 'rain', 'mist', 'thunderstorm', 
    'snow', 'drizzle', 'fog', 'dust', 'smoke', 'haze'
  ];
  
  // 📱 **App Limits**
  static const int maxMessageLength = 500;
  static const int maxRetryAttempts = 3;
  static const int sessionTimeoutMinutes = 30;
  
  // 🔐 **Security**
  static const int passwordMinLength = 6;
  static const int otpLength = 6;
  static const int maxLoginAttempts = 5;
  
  // 📊 **Performance**
  static const int maxCachedMessages = 100;
  static const int imageCompressionQuality = 80;
  static const double maxImageSizeMB = 5.0;
}

/// 🎨 **UI Text Styles Constants**
class TextStyleConstants {
  static const double headingFontSize = 24.0;
  static const double titleFontSize = 20.0;
  static const double bodyFontSize = 16.0;
  static const double captionFontSize = 14.0;
  static const double smallFontSize = 12.0;
  
  static const double headingLineHeight = 1.2;
  static const double bodyLineHeight = 1.4;
  static const double captionLineHeight = 1.3;
}

/// 🌐 **API Constants**
class ApiConstants {
  static const String chatEndpoint = '/chatbot';
  static const String weatherEndpoint = '/weather';
  static const String translationEndpoint = '/translate';
  
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  static const int connectTimeoutSeconds = 10;
  static const int receiveTimeoutSeconds = 30;
}