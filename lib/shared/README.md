# 🔄 Shared Components Directory

## 📖 Overview
This directory contains all shared/reusable components used across multiple features in the Luna app.

## 🗂️ Directory Structure

### 🔄 Providers (`providers/`)
**Purpose**: Global state management
- `theme_provider.dart` - Dark/light theme management
- `locale_provider.dart` - Language selection
- `remedy_provider.dart` - Weather-based remedy suggestions
- `providers.dart` - Barrel file for easy imports

### 🎨 Widgets (`widgets/`)
**Purpose**: Reusable UI components organized by type

#### 🔘 Buttons (`widgets/buttons/`)
- `animated_button.dart` - Interactive button with animations
- `auth_button.dart` - Styled authentication button

#### 🃏 Cards (`widgets/cards/`)
- `animated_card.dart` - Card with hover effects and elevation

#### 📝 Inputs (`widgets/inputs/`)
- `auth_input_field.dart` - Styled input field for forms

#### ✨ Animations (`widgets/animations/`)
- `animated_background.dart` - Gradient background with particles
- `typing_text_animation.dart` - Typewriter text effect
- `theme_toggle_button.dart` - Animated theme switcher

#### 💬 Common (`widgets/common/`)
- `message_bubble.dart` - Chat message bubble component

### 📊 Models (`models/`)
**Purpose**: Shared data structures
- `message.dart` - Chat message model used across features

### 🎨 Theme (`theme/`)
**Purpose**: App-wide styling and theming
- Theme configuration and styling constants

## 📝 Usage Guidelines

### 🔄 Using Shared Providers
```dart
import 'package:medical/shared/providers/providers.dart';

// In your widget
Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {
    return Container(
      color: themeProvider.backgroundColor,
      child: child,
    );
  },
)
```

### 🎨 Using Shared Widgets
```dart
import 'package:medical/shared/widgets/widgets.dart';

// Use any shared widget
AnimatedButton(
  text: 'Click Me',
  onPressed: () => print('Pressed!'),
  icon: Icons.star,
)
```

## 🔧 Adding New Shared Components

### When to Add Here:
- Component is used by 2+ features
- Component is generic/reusable
- Component provides global functionality

### When NOT to Add Here:
- Component is feature-specific
- Component has business logic tied to one feature
- Component is a one-off custom widget

### How to Add:
1. Create component in appropriate subdirectory
2. Add comprehensive documentation
3. Update barrel files (`widgets.dart`, `providers.dart`)
4. Add usage examples

## 📖 Component Documentation

Each shared component should include:
- Purpose and use cases
- Props/parameters documentation
- Usage examples
- Dependencies
- Styling guidelines

## 🎯 Best Practices

### 🔄 Providers:
- Keep providers focused on single responsibility
- Use descriptive names
- Provide clear getter/setter methods
- Include proper error handling

### 🎨 Widgets:
- Make widgets highly configurable
- Use consistent naming conventions
- Include proper documentation
- Follow Material Design guidelines
- Support both light and dark themes

### 📊 Models:
- Use immutable data structures when possible
- Include proper serialization methods
- Add validation where appropriate
- Document all properties

## 🔗 Dependencies

Shared components should:
- ✅ Depend on Flutter framework
- ✅ Depend on other shared components
- ❌ NOT depend on specific features
- ❌ NOT include business logic

This keeps shared components truly reusable across the entire app.