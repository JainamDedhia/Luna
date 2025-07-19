# 🎯 Features Directory

## 📖 Overview
This directory contains all feature-based modules of the Luna app. Each feature is self-contained with its own data, domain, and presentation layers.

## 🏗️ Feature Structure
Each feature follows this architecture:
```
feature_name/
├── data/                    # 💾 Data Layer
│   ├── datasources/        # API calls, local storage
│   ├── models/             # Data models
│   └── repositories/       # Repository implementations
├── domain/                 # 🏛️ Business Logic Layer  
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/          # Business use cases
└── presentation/           # 🎨 UI Layer
    ├── pages/             # Full-screen pages
    ├── widgets/           # Feature-specific widgets
    └── providers/         # Feature state management
```

## 🎯 Available Features

### 🔐 Authentication (`authentication/`)
**Purpose**: User login, signup, and session management
- Google Sign-In integration
- Email/password authentication
- User session handling

### 💬 Chat (`chat/`)  
**Purpose**: AI-powered Ayurvedic health chat
- Multilingual chat interface
- Speech-to-text input
- AI response processing
- Translation services

### 📍 Location (`location/`)
**Purpose**: Hospital finder and location services
- GPS location detection
- Hospital database and search
- Interactive maps
- Directions and contact info

### ❓ Support (`support/`)
**Purpose**: Help, FAQ, and user support
- FAQ system
- Help documentation
- User profile management
- Educational content
- Feedback system

### 🏠 Home (`home/`)
**Purpose**: Main dashboard and app shell
- Weather-based remedies
- Location display
- App navigation
- Main user interface

### ⚙️ Settings (`settings/`)
**Purpose**: App configuration and preferences
- Theme management
- Language selection
- User preferences
- App settings

## 📝 Adding New Features

1. Create feature directory: `lib/features/new_feature/`
2. Add the three layers: `data/`, `domain/`, `presentation/`
3. Follow existing patterns for file organization
4. Update this README with your feature description

## 🔗 Dependencies Between Features

- **Authentication** → Used by all other features for user state
- **Home** → Contains navigation to all features
- **Chat** → May use Location for context
- **Support** → Standalone, used by other features for help

## 📖 Documentation
Each feature should have its own README.md explaining:
- Purpose and scope
- Key components
- API integrations
- Usage examples