/// 🛠️ **CORE APP HELPERS**
/// 
/// 🎯 **Purpose**: Core utility functions and helper methods
/// 🏗️ **Architecture**: Core Layer - Utilities and helpers
/// 🔗 **Dependencies**: Flutter framework, app constants
/// 📝 **Usage**: Import to access utility functions throughout the app
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// 🔧 **Application Helper Functions**
/// 
/// Contains utility functions used throughout the app:
/// - ⏰ Time and date formatting
/// - 🔍 Text processing and validation
/// - 🎨 UI helpers and utilities
/// - 📱 Device and platform helpers
class AppHelpers {
  
  // ⏰ **Time & Date Helpers**
  
  /// Format timestamp for chat messages (e.g., "2h ago", "Just now")
  static String formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
  
  /// Get formatted time (HH:MM) for message timestamps
  static String getFormattedTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
  
  // 🔍 **Text Processing Helpers**
  
  /// Check if message contains emergency keywords
  static bool isEmergencyMessage(String message) {
    final lowerMessage = message.toLowerCase();
    return AppConstants.emergencyKeywords.any(
      (keyword) => lowerMessage.contains(keyword)
    );
  }
  
  /// Extract step-by-step instructions from response text
  static List<String> extractSteps(String text) {
    final lines = text.split('\n');
    List<String> steps = [];
    
    for (String line in lines) {
      String trimmed = line.trim();
      // Look for numbered steps (1. 2. 3. etc.)
      if (RegExp(r'^\d+\.').hasMatch(trimmed)) {
        steps.add(trimmed);
      }
    }
    
    return steps;
  }
  
  /// Clean response text from AI service tokens
  static String cleanResponseText(String text) {
    return text
        .replaceAll(RegExp(r'<\|.*?\|>'), '') // Remove special tokens
        .replaceAll(RegExp(r'\[INST\]|\[/INST\]'), '') // Remove instruction markers
        .replaceAll(RegExp(r'<s>|</s>'), '') // Remove sentence markers
        .trim();
  }
  
  // ✅ **Validation Helpers**
  
  /// Validate user input for chat messages
  static String? validateUserInput(String input) {
    if (input.trim().isEmpty) {
      return 'Please enter your health concern';
    }
    if (input.trim().length < 3) {
      return 'Please provide more details';
    }
    if (input.length > AppConstants.maxMessageLength) {
      return 'Message is too long. Please keep it under ${AppConstants.maxMessageLength} characters';
    }
    return null; // Valid input
  }
  
  /// Validate email format
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  /// Validate password strength
  static String? validatePassword(String password) {
    if (password.length < AppConstants.passwordMinLength) {
      return 'Password must be at least ${AppConstants.passwordMinLength} characters';
    }
    return null;
  }
  
  // 🎨 **UI Helpers**
  
  /// Show custom snackbar with styling
  static void showCustomSnackBar(
    BuildContext context, 
    String message, {
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.red[600] : Colors.green[600],
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
  
  /// Get appropriate icon for health issues
  static IconData getIconForHealthIssue(String message) {
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('head') || lowerMessage.contains('migraine')) {
      return Icons.psychology;
    } else if (lowerMessage.contains('burn') || lowerMessage.contains('fire')) {
      return Icons.local_fire_department;
    } else if (lowerMessage.contains('stomach') || lowerMessage.contains('digest')) {
      return Icons.dining;
    } else if (lowerMessage.contains('cold') || lowerMessage.contains('cough')) {
      return Icons.sick;
    } else if (lowerMessage.contains('skin') || lowerMessage.contains('rash')) {
      return Icons.face;
    } else if (lowerMessage.contains('bite') || lowerMessage.contains('insect')) {
      return Icons.pest_control;
    } else {
      return Icons.healing;
    }
  }
  
  // 🔢 **Number & Format Helpers**
  
  /// Format large numbers (1000 → 1K, 1000000 → 1M)
  static String formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
  
  /// Generate unique message ID
  static String generateMessageId(String prefix) {
    return '${prefix}_${DateTime.now().millisecondsSinceEpoch}';
  }
  
  // 📱 **Device Helpers**
  
  /// Check if device is in dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  
  /// Get screen size category
  static String getScreenSizeCategory(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 'mobile';
    if (width < 1200) return 'tablet';
    return 'desktop';
  }
}

/// 🎯 **Debug Helpers**
/// 
/// Utilities for debugging and development
class DebugHelpers {
  /// Print formatted debug message
  static void debugPrint(String message, {String? tag}) {
    if (!AppConstants.isProduction) {
      final timestamp = DateTime.now().toIso8601String();
      final tagPrefix = tag != null ? '[$tag] ' : '';
      print('🐛 $timestamp $tagPrefix$message');
    }
  }
  
  /// Log user actions for debugging
  static void logUserAction(String action, {Map<String, dynamic>? data}) {
    if (!AppConstants.isProduction) {
      debugPrint('User Action: $action', tag: 'USER');
      if (data != null) {
        debugPrint('Data: $data', tag: 'USER');
      }
    }
  }
}