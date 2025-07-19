/// 🏠 **HOME SHELL - MAIN APP CONTAINER**
/// 
/// 🎯 **Purpose**: Main app container with navigation, drawer, and page management
/// 🏗️ **Architecture**: Home Feature - Presentation Layer
/// 🔗 **Dependencies**: All feature pages, providers, navigation
/// 📝 **Usage**: Main container after authentication
/// 
/// 📅 **Created**: 2025
/// 👤 **Team**: Luna Development Team

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌍 Localization
import '../../../../l10n/app_localizations.dart';

// 🔄 Shared Providers & Widgets
import '../../../../shared/providers/providers.dart';
import '../../../../shared/widgets/widgets.dart';

// 🎯 Feature Pages
import '../../../chat/presentation/pages/chat_screen.dart';
import '../../../location/presentation/pages/hospital_locator_page.dart';
import '../../../support/presentation/pages/help_support_page.dart';
import '../../../support/presentation/pages/faq_page.dart';
import '../../../support/presentation/pages/profile_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../authentication/presentation/pages/auth_screen.dart';
import '../../../support/presentation/pages/educational_lessons_page.dart';
import '../../../support/presentation/pages/terms_conditions_page.dart';
import '../../../support/presentation/pages/ads_popup_page.dart';

// 🔧 Services
import '../../../authentication/data/datasources/auth_service.dart';

// 🏠 Home Components
import '../widgets/main_page.dart';

/// 🏠 **Home Shell Widget**
/// 
/// Main application container that provides:
/// - 📱 Bottom navigation between features
/// - 🎨 Animated background and theme
/// - 🔄 Drawer navigation with settings
/// - 🌍 Language selection
/// - 🔐 Authentication management
/// - 📋 Terms & conditions handling
/// - 📢 Ads popup management
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  // 📱 **Navigation State**
  int _currentPageIndex = 0;

  // 📄 **App Pages**
  static final List<Widget> _pages = <Widget>[
    const MainPage(),           // 🏠 Home
    const ChatScreen(),         // 💬 Chat
    const HospitalLocatorPage(), // 🏥 Hospital Finder
    const HelpAndSupportPage(), // ❓ Help & Support
  ];

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// 🚀 **Initialize App**
  /// 
  /// Handle app initialization sequence:
  /// 1. Check authentication
  /// 2. Show ads popup
  /// 3. Check terms agreement
  Future<void> _initializeApp() async {
    // 🔍 Check if user is authenticated first
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // ⏱️ Small delay to ensure widget tree is built
    await Future.delayed(const Duration(milliseconds: 500));

    // 📢 Check and show ads popup first
    await _checkAndShowAdsPopup();

    // 📋 Then check terms agreement
    await _checkTermsAgreement();
  }

  /// 📢 **Check and Show Ads Popup**
  /// 
  /// Show promotional popup for video consulting feature
  Future<void> _checkAndShowAdsPopup() async {
    if (!mounted) return;

    final shouldShow = await AdsPopupHelper.shouldShowAdsPopup();
    if (shouldShow) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          AdsPopupHelper.showAdsPopup(context);
        }
      });
    }
  }

  /// 📋 **Check Terms Agreement**
  /// 
  /// Ensure user has agreed to terms and conditions
  Future<void> _checkTermsAgreement() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final prefs = await SharedPreferences.getInstance();
    final key = 'agreed_to_terms_${user.uid}';
    final agreed = prefs.getBool(key) ?? false;

    if (!agreed) {
      // ⏱️ Add delay to ensure ads popup is shown first
      await Future.delayed(const Duration(milliseconds: 1000));

      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => TermsConditionsPage(
              onAgree: () async {
                await prefs.setBool(key, true);
                Navigator.of(context).pop();
              },
            ),
          );
        });
      }
    }
  }

  /// 🚪 **Handle Sign Out**
  /// 
  /// Sign out user and return to authentication screen
  void handleSignOut(BuildContext context) async {
    try {
      final authService = AuthService();
      await authService.signOut();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $e')),
      );
    }
  }

  /// 📱 **Handle Navigation Tap**
  /// 
  /// Switch between bottom navigation pages
  void _onNavTap(int newIndex) => setState(() => _currentPageIndex = newIndex);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        
        // 🎨 **App Drawer**
        drawer: _MainDrawer(onSignOut: handleSignOut),
        
        // 📱 **App Bar**
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.menu, color: themeProvider.primaryColor),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
          actions: [
            // 🎨 **Theme Toggle**
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: ThemeToggleButton(),
            ),
            
            // 👤 **Profile Button**
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ProfilePage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          )),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeProvider.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: themeProvider.primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 24,
                    color: themeProvider.backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        
        // 📄 **Page Content**
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _pages[_currentPageIndex],
        ),
        
        // 📱 **Bottom Navigation**
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: themeProvider.surfaceColor,
            border: Border(
              top: BorderSide(
                color: themeProvider.primaryColor.withOpacity(0.2),
                width: 0.5,
              ),
            ),
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            selectedIndex: _currentPageIndex,
            onDestinationSelected: _onNavTap,
            indicatorColor: themeProvider.primaryColor.withOpacity(0.2),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: themeProvider.secondaryTextColor),
                selectedIcon: Icon(Icons.home, color: themeProvider.primaryColor),
                label: l10n.home,
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline, color: themeProvider.secondaryTextColor),
                selectedIcon: Icon(Icons.chat, color: themeProvider.primaryColor),
                label: l10n.chatPage,
              ),
              NavigationDestination(
                icon: Icon(Icons.place_outlined, color: themeProvider.secondaryTextColor),
                selectedIcon: Icon(Icons.place, color: themeProvider.primaryColor),
                label: l10n.mapPage,
              ),
              NavigationDestination(
                icon: Icon(Icons.call_outlined, color: themeProvider.secondaryTextColor),
                selectedIcon: Icon(Icons.call, color: themeProvider.primaryColor),
                label: l10n.helpPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🎨 **Main Drawer Widget**
/// 
/// Side navigation drawer with app features and settings
class _MainDrawer extends StatelessWidget {
  final Function(BuildContext) onSignOut;
  
  const _MainDrawer({required this.onSignOut});

  /// 🌍 **Show Language Selection Dialog**
  /// 
  /// Display language picker with flag icons
  void _showLanguageDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.changeLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LanguageTile(
                title: 'English',
                flag: '🇺🇸',
                locale: const Locale('en'),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              _LanguageTile(
                title: 'हिंदी',
                flag: '🇮🇳',
                locale: const Locale('hi'),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(const Locale('hi'));
                  Navigator.pop(context);
                },
              ),
              _LanguageTile(
                title: 'ગુજરાતી',
                flag: '🇮🇳',
                locale: const Locale('gu'),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(const Locale('gu'));
                  Navigator.pop(context);
                },
              ),
              _LanguageTile(
                title: 'मराठी',
                flag: '🇮🇳',
                locale: const Locale('mr'),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(const Locale('mr'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      backgroundColor: themeProvider.surfaceColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 🎨 **Drawer Header**
          DrawerHeader(
            decoration: BoxDecoration(color: themeProvider.surfaceColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeProvider.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: themeProvider.primaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    color: themeProvider.backgroundColor,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.title, // Luna Menu
                  style: TextStyle(
                    color: themeProvider.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // 🏠 **Home**
          ListTile(
            leading: Icon(Icons.home, color: themeProvider.primaryColor),
            title: Text(
              l10n.home,
              style: TextStyle(color: themeProvider.textColor, fontSize: 16),
            ),
            onTap: () => Navigator.pop(context),
          ),

          // 🎓 **Educational Lessons**
          ListTile(
            leading: Icon(Icons.school, color: themeProvider.primaryColor),
            title: Text(
              l10n.educationalLessons,
              style: TextStyle(color: themeProvider.textColor, fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const EducationalLessonsPage(),
                ),
              );
            },
          ),

          // ❓ **FAQ**
          ListTile(
            leading: Icon(
              Icons.question_answer_outlined,
              color: themeProvider.primaryColor,
            ),
            title: Text(
              l10n.faq,
              style: TextStyle(color: themeProvider.textColor, fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQPage()),
              );
            },
          ),

          // ⚙️ **Settings**
          ListTile(
            leading: Icon(Icons.settings, color: themeProvider.primaryColor),
            title: Text(
              l10n.settings,
              style: TextStyle(color: themeProvider.textColor, fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),

          // 🚪 **Sign Out**
          ListTile(
            leading: Icon(Icons.logout, color: themeProvider.primaryColor),
            title: Text(
              l10n.signOut,
              style: TextStyle(color: themeProvider.textColor, fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              onSignOut(context);
            },
          ),

          // 🌍 **Language Selection**
          ListTile(
            leading: Icon(Icons.language, color: themeProvider.primaryColor),
            title: Text(
              l10n.changeLanguage,
              style: TextStyle(color: themeProvider.textColor, fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 100), () {
                _showLanguageDialog(context);
              });
            },
          ),
        ],
      ),
    );
  }
}

/// 🌍 **Language Selection Tile**
/// 
/// Individual language option in the language picker
class _LanguageTile extends StatelessWidget {
  final String title;
  final String flag;
  final Locale locale;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.title,
    required this.flag,
    required this.locale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Text(flag, style: const TextStyle(fontSize: 20)),
      onTap: onTap,
    );
  }
}