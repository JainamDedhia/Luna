# 🌙 Luna – Your Ayurvedic Health Companion

> **✨ RESTRUCTURED FOR EXCELLENCE** - This project has been completely reorganized for better maintainability, scalability, and developer experience.

Luna is a multilingual, AI-powered mobile chatbot that delivers personalized Ayurvedic health guidance — instantly and in your local language. Designed for rural and underserved communities, Luna provides quick remedies, wellness tips, and access to nearby healthcare resources, even in low-connectivity environments.

## 🚀 Quick Start

### 📁 New Project Structure
```
medical/
├── lib/
│   ├── app/                    # 🚀 App configuration
│   ├── core/                   # ⚙️ Core infrastructure  
│   ├── shared/                 # 🔄 Shared components
│   ├── features/               # 🎯 Feature modules
│   ├── l10n/                   # 🌍 Localization
│   └── main.dart               # 🏁 Entry point
├── docs/                       # 📚 Documentation
└── assets/                     # 📦 Static assets
```

### 🔍 Finding Your Files
| **Looking for** | **Check here** |
|----------------|----------------|
| 🔐 Login screens | `lib/features/authentication/presentation/pages/` |
| 💬 Chat interface | `lib/features/chat/presentation/pages/` |
| 🏥 Hospital finder | `lib/features/location/presentation/pages/` |
| 🎨 Reusable widgets | `lib/shared/widgets/` |
| 🔧 Utilities | `lib/core/utils/` |

## ✨ Features

- 🤖 **AI Chatbot** – Get instant Ayurvedic remedies by typing or speaking symptoms
- 🌐 **Multilingual Interface** – Support for regional Indian languages
- 🌦️ **Weather-Based Tips** – Health advice based on local weather
- 🏥 **Nearby Hospitals** – Find nearby medical centers using geolocation
- 📚 **Educational Lessons** – Learn simple Ayurvedic practices
- ❓ **FAQ & Help Page** – User guidance and troubleshooting support
- 🔐 **Google Sign-In** – Quick and secure authentication

## 🛠️ Built With

- **Frontend**: Flutter, Dart
- **Backend**: Firebase, Firestore  
- **AI/ML**: Python, LangChain
- **Authentication**: Google Sign-In, Firebase Auth
- **APIs**: Geolocation, Weather API, Custom Ayurvedic Dataset
- **Localization**: Flutter Intl

## 📚 Documentation

### 🎯 For Developers
- 📖 **[Complete Documentation](docs/README.md)** - Full project guide
- 🔄 **[Migration Guide](docs/MIGRATION_GUIDE.md)** - File location changes
- 🏗️ **[Architecture Guide](docs/ARCHITECTURE.md)** - Project structure
- 🎨 **[Widget Library](docs/WIDGETS.md)** - Reusable components

### 🚀 Quick Links
- **New to the project?** Start with [docs/README.md](docs/README.md)
- **Can't find a file?** Check [docs/MIGRATION_GUIDE.md](docs/MIGRATION_GUIDE.md)
- **Want to add features?** See [lib/features/README.md](lib/features/README.md)

## 🏗️ Architecture Highlights

### 🎯 Feature-Based Organization
Each feature is self-contained:
```
features/authentication/
├── data/           # 💾 API calls, models
├── domain/         # 🏛️ Business logic  
└── presentation/   # 🎨 UI components
```

### 🔄 Clean Separation
- **Shared**: Reusable across features
- **Core**: Infrastructure and utilities
- **Features**: Business functionality
- **App**: Configuration and setup

## 💡 Inspiration

Millions in rural India lack access to timely, reliable healthcare. At the same time, Ayurveda offers a natural and culturally trusted healing system — but it's often inaccessible or unstructured. Luna bridges that gap by delivering personalized Ayurvedic guidance right to the user's phone — in their own language.

## ⚙️ How It Works

1. User signs up via Google or email
2. Selects preferred language
3. Types or speaks a symptom
4. Luna responds with verified Ayurvedic remedies
5. Additional tools like hospital finder, lessons, and FAQs enhance the experience

## 🚧 Development

### 🔧 Setup
```bash
flutter pub get
flutter run
```

### 🎯 Adding Features
1. Create feature directory in `lib/features/`
2. Follow the data/domain/presentation structure
3. Add to navigation in `home_shell.dart`
4. Update documentation

### 🧪 Testing
```bash
flutter test
```

## 🚀 Future Plans

- Add more regional languages and dialects
- Enable voice output for full hands-free experience
- Integrate live chat with certified Ayurvedic doctors
- Improve offline caching and local data support

## 👨‍💻 Team Luna

- Jainam  
- Tirth  
- Yagnik  
- Mit  

## 📄 License

[MIT License](LICENSE)

---

## 🌟 Project Restructuring Benefits

✅ **Better Organization** - Files grouped by feature and purpose
✅ **Easier Navigation** - Clear structure with comprehensive documentation  
✅ **Improved Maintainability** - Changes isolated to specific areas
✅ **Enhanced Scalability** - Easy to add new features
✅ **Team Collaboration** - Multiple developers can work simultaneously
✅ **Self-Documenting** - Structure explains itself

**Need help finding something?** Check our [comprehensive documentation](docs/README.md)! 📚