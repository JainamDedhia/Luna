/// 🎨 **SHARED WIDGETS BARREL FILE**
/// 
/// 🎯 **Purpose**: Central export for all shared/reusable widgets
/// 🏗️ **Architecture**: Shared Layer - Widget exports
/// 🔗 **Dependencies**: All widget files
/// 📝 **Usage**: Import this file to access all shared widgets
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

// 🔘 Buttons
export 'buttons/animated_button.dart';
export 'buttons/auth_button.dart';

// 🃏 Cards
export 'cards/animated_card.dart';

// 📝 Input Fields
export 'inputs/auth_input_field.dart';

// ✨ Animations
export 'animations/animated_background.dart';
export 'animations/typing_text_animation.dart';
export 'animations/theme_toggle_button.dart';

// 💬 Common Components
export 'common/message_bubble.dart';

/// 📖 **Widget Documentation**
/// 
/// **Buttons**:
/// - `AnimatedButton`: Interactive button with hover/press animations
/// - `AuthButton`: Styled button for authentication screens
/// 
/// **Cards**:
/// - `AnimatedCard`: Card with hover effects and elevation animations
/// 
/// **Inputs**:
/// - `AuthInputField`: Styled input field for authentication forms
/// 
/// **Animations**:
/// - `AnimatedBackground`: Animated gradient background with particles
/// - `TypingTextAnimation`: Typewriter effect for text
/// - `ThemeToggleButton`: Animated theme switcher button
/// 
/// **Common**:
/// - `MessageBubble`: Chat message bubble with user/bot styling
/// 
/// **Usage Example**:
/// ```dart
/// import 'package:medical/shared/widgets/widgets.dart';
/// 
/// AnimatedButton(
///   text: 'Click Me',
///   onPressed: () => print('Pressed!'),
///   icon: Icons.star,
/// )
/// ```