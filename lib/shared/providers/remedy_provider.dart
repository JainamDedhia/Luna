/// 💊 **REMEDY PROVIDER**
/// 
/// 🎯 **Purpose**: Manage weather-based Ayurvedic remedy suggestions
/// 🏗️ **Architecture**: Shared Layer - Global state management
/// 🔗 **Dependencies**: Flutter ChangeNotifier
/// 📝 **Usage**: Provides weather-based remedy state across the app
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

import 'package:flutter/material.dart';

/// 💊 **Remedy Provider Class**
/// 
/// Manages the current remedy suggestion state:
/// - 🌤️ Weather-based remedy storage
/// - 🔄 Remedy updates and notifications
/// - 📱 UI state management for remedy display
/// 
/// **Usage**:
/// ```dart
/// // Set a new remedy
/// Provider.of<RemedyProvider>(context, listen: false)
///   .setRemedy("Drink warm ginger tea for cold weather");
/// 
/// // Listen to remedy changes
/// Consumer<RemedyProvider>(
///   builder: (context, remedyProvider, child) {
///     return Text(remedyProvider.remedy);
///   },
/// )
/// ```
class RemedyProvider extends ChangeNotifier {
  // 💊 **Private State**
  String _remedy = '';

  // 📖 **Public Getter**
  /// Get the current remedy suggestion
  String get remedy => _remedy;

  // 🔄 **State Management**
  /// Set a new remedy and notify listeners
  /// 
  /// **Parameters**:
  /// - `remedy`: The new remedy text to display
  void setRemedy(String remedy) {
    _remedy = remedy;
    notifyListeners(); // 🔔 Notify all listening widgets
  }

  // 🧹 **Utility Methods**
  /// Clear the current remedy
  void clearRemedy() {
    _remedy = '';
    notifyListeners();
  }

  /// Check if there's an active remedy
  bool get hasRemedy => _remedy.isNotEmpty;
}