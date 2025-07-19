# ⚙️ Core Infrastructure Directory

## 📖 Overview
This directory contains core infrastructure, utilities, and foundational code that supports the entire Luna application.

## 🗂️ Directory Structure

### 🔧 Constants (`constants/`)
**Purpose**: Application-wide constants and configuration
- `app_constants.dart` - Core app constants, UI values, text constants

### 🛠️ Utils (`utils/`)
**Purpose**: Utility functions and helper methods
- `app_helpers.dart` - Common utility functions, formatters, validators

### 🌐 Network (`network/`)
**Purpose**: Network configuration and API setup
- HTTP client configuration
- API endpoint definitions
- Network error handling

## 📝 Usage Guidelines

### 🔧 Constants
```dart
import 'package:medical/core/constants/app_constants.dart';

// Use app constants
Text(
  AppConstants.welcomeMessage,
  style: TextStyle(fontSize: TextStyleConstants.bodyFontSize),
)
```

### 🛠️ Helpers
```dart
import 'package:medical/core/utils/app_helpers.dart';

// Use utility functions
String timeAgo = AppHelpers.formatMessageTime(DateTime.now());
bool isEmergency = AppHelpers.isEmergencyMessage(userInput);
```

## 🎯 What Belongs Here

### ✅ Should be in Core:
- Utility functions used across features
- App-wide constants
- Network configuration
- Error handling utilities
- Validation functions
- Formatting helpers
- Debug utilities

### ❌ Should NOT be in Core:
- Feature-specific logic
- UI components
- Business entities
- Feature constants
- API response models

## 🔧 Adding New Core Components

### Constants:
- Add to existing files or create new constant classes
- Use descriptive names and group related constants
- Include documentation for each constant group

### Utils:
- Create focused utility classes
- Use static methods for stateless functions
- Include comprehensive error handling
- Add unit tests for complex utilities

### Network:
- Configure HTTP clients
- Define base URLs and endpoints
- Handle authentication headers
- Implement retry logic

## 📖 Documentation Standards

Each core component should include:
- Clear purpose statement
- Usage examples
- Parameter documentation
- Return value descriptions
- Error handling information

## 🎯 Best Practices

### 🔧 Constants:
- Group related constants together
- Use meaningful names
- Avoid magic numbers/strings
- Include units in names (e.g., `timeoutSeconds`)

### 🛠️ Utils:
- Keep functions pure when possible
- Handle edge cases gracefully
- Use descriptive parameter names
- Return meaningful error messages

### 🌐 Network:
- Implement proper timeout handling
- Use consistent error responses
- Include retry mechanisms
- Log network activities for debugging

## 🔗 Dependencies

Core components should:
- ✅ Have minimal dependencies
- ✅ Be framework-agnostic when possible
- ✅ Focus on pure functions
- ❌ NOT depend on UI frameworks
- ❌ NOT include business logic
- ❌ NOT depend on specific features

This ensures core components remain stable and reusable across the entire application.