# Luna Project Restructuring Plan

## Current Structure Analysis

### Strengths
- Clear separation of screens, services, and widgets
- Good use of localization with l10n
- Proper provider pattern implementation
- Well-organized assets and platform-specific files

### Areas for Improvement
- Mixed concerns in some directories
- Inconsistent naming conventions
- Missing feature-based organization
- No clear separation of business logic layers

## Recommended New Structure

```
medical/
├── lib/
│   ├── app/                           # App-level configuration
│   │   ├── app.dart                   # Main app widget (current main.dart content)
│   │   ├── routes/                    # Navigation and routing
│   │   │   ├── app_routes.dart
│   │   │   ├── route_names.dart
│   │   │   └── route_generator.dart
│   │   └── constants/                 # App-wide constants
│   │       ├── app_constants.dart     # Move from utils/constants.dart
│   │       ├── api_constants.dart
│   │       └── ui_constants.dart
│   │
│   ├── core/                          # Core functionality
│   │   ├── di/                        # Dependency injection
│   │   │   └── injection_container.dart
│   │   ├── error/                     # Error handling
│   │   │   ├── exceptions.dart
│   │   │   └── failures.dart
│   │   ├── network/                   # Network layer
│   │   │   ├── api_client.dart
│   │   │   └── network_info.dart
│   │   ├── utils/                     # Core utilities
│   │   │   ├── helpers.dart           # Move from utils/helpers.dart
│   │   │   ├── validators.dart
│   │   │   └── extensions.dart
│   │   └── platform/                  # Platform-specific code
│   │       ├── platform_info.dart
│   │       └── device_info.dart
│   │
│   ├── shared/                        # Shared components
│   │   ├── widgets/                   # Reusable widgets
│   │   │   ├── buttons/
│   │   │   │   ├── animated_button.dart
│   │   │   │   └── auth_button.dart
│   │   │   ├── cards/
│   │   │   │   └── animated_card.dart
│   │   │   ├── inputs/
│   │   │   │   └── auth_input_field.dart
│   │   │   ├── animations/
│   │   │   │   ├── animated_background.dart
│   │   │   │   ├── typing_text_animation.dart
│   │   │   │   └── theme_toggle_button.dart
│   │   │   └── common/
│   │   │       └── message_bubble.dart
│   │   ├── models/                    # Shared data models
│   │   │   ├── message.dart
│   │   │   ├── user_model.dart
│   │   │   └── hospital_model.dart
│   │   ├── providers/                 # Global state management
│   │   │   ├── theme_provider.dart
│   │   │   ├── locale_provider.dart
│   │   │   └── remedy_provider.dart
│   │   └── theme/                     # Theme configuration
│   │       ├── app_theme.dart         # Move from theme/theme.dart
│   │       ├── app_colors.dart
│   │       └── app_text_styles.dart
│   │
│   ├── features/                      # Feature-based organization
│   │   ├── authentication/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── auth_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── user_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── user_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── sign_in_usecase.dart
│   │   │   │       └── sign_out_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── auth_screen.dart
│   │   │       │   └── signup_screen.dart
│   │   │       ├── widgets/
│   │   │       │   ├── auth_form.dart
│   │   │       │   └── social_login_buttons.dart
│   │   │       └── providers/
│   │   │           └── auth_provider.dart
│   │   │
│   │   ├── chat/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── chat_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── chat_message_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── chat_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── chat_message_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── chat_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       └── send_message_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── chat_screen.dart
│   │   │       ├── widgets/
│   │   │       │   ├── chat_input.dart
│   │   │       │   ├── message_list.dart
│   │   │       │   └── quick_actions.dart
│   │   │       └── providers/
│   │   │           └── chat_provider.dart
│   │   │
│   │   ├── location/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── location_local_datasource.dart
│   │   │   │   │   └── hospital_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── location_model.dart
│   │   │   │   │   └── hospital_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── location_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── location_entity.dart
│   │   │   │   │   └── hospital_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── location_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_current_location_usecase.dart
│   │   │   │       └── find_nearby_hospitals_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── hospital_locator_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── hospital_card.dart
│   │   │       │   ├── location_bar.dart
│   │   │       │   └── map_view.dart
│   │   │       └── providers/
│   │   │           └── location_provider.dart
│   │   │
│   │   ├── education/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── lessons_local_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── lesson_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── education_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── lesson_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── education_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       └── get_lessons_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── educational_lessons_page.dart
│   │   │       ├── widgets/
│   │   │       │   └── lesson_card.dart
│   │   │       └── providers/
│   │   │           └── education_provider.dart
│   │   │
│   │   ├── support/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── support_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── faq_model.dart
│   │   │   │   │   └── feedback_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── support_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── faq_entity.dart
│   │   │   │   │   └── feedback_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── support_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_faqs_usecase.dart
│   │   │   │       └── submit_feedback_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── faq_page.dart
│   │   │       │   ├── help_support_page.dart
│   │   │       │   └── profile_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── faq_card.dart
│   │   │       │   ├── feedback_form.dart
│   │   │       │   └── support_tile.dart
│   │   │       └── providers/
│   │   │           └── support_provider.dart
│   │   │
│   │   ├── home/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── weather_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   └── weather_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── home_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── weather_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── home_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       └── get_weather_remedy_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── home_shell.dart
│   │   │       │   └── main_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── animated_logo.dart
│   │   │       │   ├── location_bar.dart
│   │   │       │   └── remedy_card.dart
│   │   │       └── providers/
│   │   │           └── home_provider.dart
│   │   │
│   │   └── settings/
│   │       ├── data/
│   │       │   ├── datasources/
│   │       │   │   └── settings_local_datasource.dart
│   │       │   ├── models/
│   │       │   │   └── settings_model.dart
│   │       │   └── repositories/
│   │       │       └── settings_repository_impl.dart
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   │   └── settings_entity.dart
│   │       │   ├── repositories/
│   │       │   │   └── settings_repository.dart
│   │       │   └── usecases/
│   │       │       ├── update_theme_usecase.dart
│   │       │       └── update_language_usecase.dart
│   │       └── presentation/
│   │           ├── pages/
│   │           │   ├── settings_page.dart
│   │           │   └── terms_conditions_page.dart
│   │           ├── widgets/
│   │           │   ├── settings_tile.dart
│   │           │   └── language_selector.dart
│   │           └── providers/
│   │               └── settings_provider.dart
│   │
│   ├── l10n/                          # Localization (keep as is)
│   │   ├── app_localizations.dart
│   │   ├── app_localizations_*.dart
│   │   └── *.arb
│   │
│   └── main.dart                      # Entry point (minimal, delegates to app/)
│
├── assets/                            # Static assets
│   ├── images/
│   │   └── Luna.png
│   ├── icons/
│   ├── fonts/
│   └── data/
│       └── remedies.json
│
├── test/                              # Tests
│   ├── unit/
│   │   ├── features/
│   │   │   ├── authentication/
│   │   │   ├── chat/
│   │   │   └── location/
│   │   ├── core/
│   │   └── shared/
│   ├── widget/
│   │   ├── features/
│   │   └── shared/
│   └── integration/
│       └── app_test.dart
│
└── docs/                              # Documentation
    ├── architecture.md
    ├── features.md
    ├── setup.md
    └── api.md
```

## File Movement Plan

### Phase 1: Core Infrastructure
1. Create `lib/app/` directory and move main app configuration
2. Create `lib/core/` directory for utilities and shared infrastructure
3. Create `lib/shared/` directory for reusable components

### Phase 2: Feature Extraction
1. Create feature directories under `lib/features/`
2. Move screens to appropriate feature presentation/pages
3. Move services to appropriate feature data/datasources
4. Move models to appropriate feature data/models

### Phase 3: Widget Organization
1. Group widgets by type in `lib/shared/widgets/`
2. Move feature-specific widgets to feature presentation/widgets
3. Organize by component type (buttons, cards, inputs, etc.)

### Phase 4: Provider Reorganization
1. Move global providers to `lib/shared/providers/`
2. Move feature-specific providers to feature presentation/providers
3. Create provider barrel files for easy imports

## Naming Conventions

### Files and Directories
- **snake_case** for all file and directory names
- **Feature-based** naming for directories
- **Descriptive** names that indicate purpose

### Classes and Widgets
- **PascalCase** for class names
- **Suffix conventions**:
  - `Page` for full-screen pages
  - `Widget` for reusable components
  - `Provider` for state management
  - `Service` for business logic
  - `Model` for data models
  - `Entity` for domain models
  - `Repository` for data access
  - `UseCase` for business operations

### Constants and Enums
- **SCREAMING_SNAKE_CASE** for constants
- **PascalCase** for enums
- **camelCase** for enum values

## Dependency Management

### Import Organization
```dart
// 1. Dart core libraries
import 'dart:async';
import 'dart:convert';

// 2. Flutter framework
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. Third-party packages
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 4. Internal app imports
import 'package:medical/core/utils/helpers.dart';
import 'package:medical/shared/widgets/buttons/animated_button.dart';
import 'package:medical/features/auth/presentation/pages/auth_screen.dart';

// 5. Relative imports (avoid when possible)
import '../widgets/custom_widget.dart';
```

### Barrel Files (index.dart)
Create barrel files for easy imports:
- `lib/shared/widgets/widgets.dart`
- `lib/shared/providers/providers.dart`
- `lib/features/authentication/authentication.dart`

## Architecture Benefits

### Clean Architecture Principles
1. **Separation of Concerns**: Each layer has a single responsibility
2. **Dependency Inversion**: Higher layers don't depend on lower layers
3. **Testability**: Each component can be tested in isolation
4. **Maintainability**: Changes in one layer don't affect others

### Feature-Based Organization
1. **Scalability**: Easy to add new features
2. **Team Collaboration**: Different teams can work on different features
3. **Code Reusability**: Shared components are clearly identified
4. **Debugging**: Issues are easier to locate and fix

### Benefits for Future Development
1. **Onboarding**: New developers can understand the structure quickly
2. **Refactoring**: Changes are localized to specific areas
3. **Testing**: Clear separation makes unit testing easier
4. **Documentation**: Structure is self-documenting

## Implementation Strategy

### Step 1: Create New Directory Structure
Create all the new directories without moving files yet.

### Step 2: Move Files Gradually
Move files in small batches, updating imports as you go.

### Step 3: Update Imports
Use IDE refactoring tools to update import statements.

### Step 4: Create Barrel Files
Add index.dart files to simplify imports.

### Step 5: Add Documentation
Document the new structure and conventions.

## Quality Assurance

### Checklist for Each Feature
- [ ] Data layer (models, datasources, repositories)
- [ ] Domain layer (entities, repositories, usecases)
- [ ] Presentation layer (pages, widgets, providers)
- [ ] Tests for each layer
- [ ] Documentation

### Code Review Guidelines
1. Check that files are in the correct feature directory
2. Verify naming conventions are followed
3. Ensure imports are organized correctly
4. Confirm separation of concerns is maintained

## Migration Timeline

### Week 1: Infrastructure
- Set up core directories
- Move utilities and constants
- Create shared components structure

### Week 2: Authentication Feature
- Extract authentication-related code
- Implement clean architecture layers
- Add tests

### Week 3: Chat Feature
- Extract chat functionality
- Implement clean architecture
- Add tests

### Week 4: Location Feature
- Extract location and hospital functionality
- Implement clean architecture
- Add tests

### Week 5: Remaining Features
- Extract education, support, home, settings
- Implement clean architecture
- Add comprehensive tests

### Week 6: Polish and Documentation
- Create barrel files
- Add documentation
- Final testing and cleanup

This restructuring will make your Luna app more maintainable, scalable, and easier for teams to work on collaboratively.