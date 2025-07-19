# 📚 Luna Project Documentation

## 🌙 Welcome to Luna - Ayurvedic Health Companion

Your Flutter project has been completely restructured for better organization, maintainability, and scalability. This documentation will help you navigate the new structure.

## 🗂️ New Project Structure

```
medical/
├── lib/
│   ├── app/                           # 🚀 App Configuration
│   │   ├── app.dart                   # Main app widget
│   │   └── app_config.dart            # App-wide configuration
│   │
│   ├── core/                          # ⚙️ Core Infrastructure
│   │   ├── constants/                 # App constants
│   │   ├── utils/                     # Utility functions
│   │   └── network/                   # Network configuration
│   │
│   ├── shared/                        # 🔄 Shared Components
│   │   ├── providers/                 # Global state management
│   │   ├── widgets/                   # Reusable UI components
│   │   ├── models/                    # Shared data models
│   │   └── theme/                     # Theme configuration
│   │
│   ├── features/                      # 🎯 Feature Modules
│   │   ├── authentication/            # 🔐 Login & signup
│   │   ├── chat/                      # 💬 AI chat interface
│   │   ├── location/                  # 📍 Hospital finder
│   │   ├── support/                   # ❓ Help & FAQ
│   │   ├── home/                      # 🏠 Main dashboard
│   │   └── settings/                  # ⚙️ App settings
│   │
│   ├── l10n/                          # 🌍 Localization (unchanged)
│   └── main.dart                      # 🏁 App entry point
│
├── assets/                            # 📦 Static assets
├── docs/                              # 📚 Documentation
└── test/                              # 🧪 Tests
```

## 🔍 Quick File Finder

### 🎯 Looking for specific functionality?

| **What you need** | **Where to find it** |
|-------------------|----------------------|
| 🔐 Login/Signup screens | `lib/features/authentication/presentation/pages/` |
| 💬 Chat interface | `lib/features/chat/presentation/pages/chat_screen.dart` |
| 🏥 Hospital finder | `lib/features/location/presentation/pages/hospital_locator_page.dart` |
| ❓ Help & FAQ | `lib/features/support/presentation/pages/` |
| ⚙️ Settings | `lib/features/settings/presentation/pages/settings_page.dart` |
| 🎨 Reusable buttons | `lib/shared/widgets/buttons/` |
| 🃏 Reusable cards | `lib/shared/widgets/cards/` |
| 🎨 Theme management | `lib/shared/providers/theme_provider.dart` |
| 🌍 Language settings | `lib/shared/providers/locale_provider.dart` |
| 🔧 Utility functions | `lib/core/utils/app_helpers.dart` |

## 📖 Feature Documentation

### 🔐 Authentication Feature
**Location**: `lib/features/authentication/`
- **Pages**: Login, signup screens
- **Services**: Google Sign-In, Firebase Auth
- **Widgets**: Auth forms, social login buttons

### 💬 Chat Feature  
**Location**: `lib/features/chat/`
- **Pages**: AI chat interface
- **Services**: Chat API, translation service
- **Widgets**: Message bubbles, input fields, voice controls

### 📍 Location Feature
**Location**: `lib/features/location/`
- **Pages**: Hospital finder with maps
- **Services**: Geolocation, hospital database
- **Widgets**: Map view, hospital cards, location bar

### ❓ Support Feature
**Location**: `lib/features/support/`
- **Pages**: Help, FAQ, profile, educational lessons
- **Services**: Feedback submission, support tickets
- **Widgets**: FAQ cards, support tiles, feedback forms

### 🏠 Home Feature
**Location**: `lib/features/home/`
- **Pages**: Main dashboard, home shell
- **Services**: Weather API, remedy suggestions
- **Widgets**: Animated logo, location bar, remedy cards

### ⚙️ Settings Feature
**Location**: `lib/features/settings/`
- **Pages**: App settings, preferences
- **Services**: Theme persistence, language settings
- **Widgets**: Settings tiles, toggles, selectors

## 🎨 Shared Components

### 🔘 Buttons (`lib/shared/widgets/buttons/`)
- `AnimatedButton`: Interactive button with animations
- `AuthButton`: Styled authentication button

### 🃏 Cards (`lib/shared/widgets/cards/`)
- `AnimatedCard`: Card with hover effects and elevation

### 📝 Inputs (`lib/shared/widgets/inputs/`)
- `AuthInputField`: Styled input for authentication

### ✨ Animations (`lib/shared/widgets/animations/`)
- `AnimatedBackground`: Gradient background with particles
- `TypingTextAnimation`: Typewriter text effect
- `ThemeToggleButton`: Animated theme switcher

## 🔄 State Management

### 🎨 Theme Provider
**File**: `lib/shared/providers/theme_provider.dart`
- Manages dark/light theme switching
- Provides theme colors and styles
- Handles theme animations

### 🌍 Locale Provider  
**File**: `lib/shared/providers/locale_provider.dart`
- Manages language selection
- Handles locale changes
- Supports multiple Indian languages

### 💊 Remedy Provider
**File**: `lib/shared/providers/remedy_provider.dart`
- Manages weather-based remedy suggestions
- Updates remedy based on location weather
- Provides remedy state to UI

## 🚀 Getting Started After Restructure

### 1. **Understanding the New Structure**
- Each feature is self-contained in `lib/features/[feature_name]/`
- Shared components are in `lib/shared/`
- Core utilities are in `lib/core/`

### 2. **Finding Your Files**
- Use the Quick File Finder table above
- Look for feature name first, then file type
- Check shared components for reusable widgets

### 3. **Adding New Features**
- Create new directory under `lib/features/`
- Follow the existing structure pattern
- Add documentation for your feature

### 4. **Modifying Existing Code**
- Locate the feature directory
- Find the appropriate layer (data/domain/presentation)
- Make changes within that specific area

## 📝 Development Guidelines

### 🏗️ Architecture Layers
Each feature follows this structure:
```
feature_name/
├── data/                    # 💾 Data sources, APIs, models
├── domain/                  # 🏛️ Business logic, entities
└── presentation/            # 🎨 UI pages, widgets, providers
```

### 📁 File Organization
- **Pages**: Full-screen UI components
- **Widgets**: Reusable UI components  
- **Providers**: State management
- **Services**: API calls and business logic
- **Models**: Data structures

### 🏷️ Naming Conventions
- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables**: `camelCase`
- **Constants**: `SCREAMING_SNAKE_CASE`

## 🆘 Need Help?

### 🔍 Can't Find a File?
1. Check the feature it belongs to in `lib/features/`
2. Identify if it's UI (presentation), API (data), or logic (domain)
3. Look in shared components if it's reusable
4. Use your IDE's search functionality

### 🐛 Something Broken?
1. Check import statements - they may need updating
2. Look for the file in its new location
3. Update imports to match new structure

### 📞 Quick Reference
- **Main app setup**: `lib/app/app.dart`
- **Entry point**: `lib/main.dart`
- **Global providers**: `lib/shared/providers/`
- **Reusable widgets**: `lib/shared/widgets/`
- **Constants**: `lib/core/constants/`
- **Utilities**: `lib/core/utils/`

## 🌟 Benefits of New Structure

✅ **Better Organization**: Files are logically grouped by feature
✅ **Easier Maintenance**: Changes are isolated to specific areas  
✅ **Improved Scalability**: Easy to add new features
✅ **Team Collaboration**: Multiple developers can work on different features
✅ **Clear Dependencies**: Understand what depends on what
✅ **Better Testing**: Each layer can be tested independently

Your Luna app is now much more organized and ready for future development! 🚀