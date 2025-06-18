import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:medical/screens/FAQ.dart';
import 'package:medical/screens/TermsConditions.dart';
import 'package:medical/screens/auth_screen.dart';
import 'package:medical/screens/chat_screen.dart';
import 'package:medical/screens/educational_lessons_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
// Missing
import 'package:medical/screens/chat_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static final _pages = <Widget>[
    const MainPage(),
    ChatScreen(),
    const MapPage(),
    const HelpPage(),
  ];
  @override
void initState() {
  super.initState();
  _checkTermsAgreement();
}

Future<void> _checkTermsAgreement() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // User is not signed in yet; skip checking
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  final key = 'agreed_to_terms_${user.uid}';
  final agreed = prefs.getBool(key) ?? false;

  if (!agreed) {
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
  
  void _onNavTap(int newIdx) => setState(() => _index = newIdx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      drawer: const _MainDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0A0A0A),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF9AFF00)),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF9AFF00),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9AFF00).withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.account_circle_outlined, 
                size: 24,
                color: Color(0xFF0A0A0A),
              ),
            ),
          ),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          border: Border(
            top: BorderSide(
              color: const Color(0xFF9AFF00).withOpacity(0.2),
              width: 0.5,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: const Color(0xFF0A0A0A),
          selectedIndex: _index,
          onDestinationSelected: _onNavTap,
          indicatorColor: const Color(0xFF9AFF00).withOpacity(0.2),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Color(0xFF666666)),
              selectedIcon: Icon(Icons.home, color: Color(0xFF9AFF00)),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline, color: Color(0xFF666666)),
              selectedIcon: Icon(Icons.chat_bubble, color: Color(0xFF9AFF00)),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.place_outlined, color: Color(0xFF666666)),
              selectedIcon: Icon(Icons.place, color: Color(0xFF9AFF00)),
              label: 'Map',
            ),
            NavigationDestination(
              icon: Icon(Icons.call_outlined, color: Color(0xFF666666)),
              selectedIcon: Icon(Icons.call, color: Color(0xFF9AFF00)),
              label: 'Help',
            ),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────
/// Drawer with both screens
/// ─────────────────────────
class _MainDrawer extends StatelessWidget {
  const _MainDrawer();

  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<_HomeShellState>();

    return Drawer(
      backgroundColor: const Color(0xFF0A0A0A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF0A0A0A),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF9AFF00),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF9AFF00).withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF0A0A0A),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Luna Menu',
                  style: TextStyle(
                    color: Color(0xFF9AFF00), 
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', () => Navigator.pop(context)),
          _buildDrawerItem(Icons.school, 'Educational Lessons', () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const EducationalLessonsPage()),
            );
          }),
          _buildDrawerItem(Icons.question_answer_outlined, 'FAQ', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FAQPage()),
            );
          }),
          _buildDrawerItem(Icons.settings, 'Settings', () => Navigator.pop(context)),
          _buildDrawerItem(Icons.logout, 'Sign Out', () {
            Navigator.pop(context);
            parentState?.handleSignOut(context);
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF9AFF00)),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
      hoverColor: const Color(0xFF9AFF00).withOpacity(0.1),
    );
  }
}

/// ─────────────────────────
/// Page 1 – Home
/// ─────────────────────────
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [
            Color(0xFF1A1A1A),
            Color(0xFF0A0A0A),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const LocationBar(),
              const SizedBox(height: 60),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Luna Logo/Title with glow effect
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          // Animated glow circle
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(0xFF9AFF00).withOpacity(0.3),
                                  const Color(0xFF9AFF00).withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF9AFF00),
                                    width: 2,
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/Luna.png',
                                  height: 64,
                                  width: 64,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Luna',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF9AFF00),
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Subtitle
                    const Text(
                      'Feeling Unwell or Just Curious',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF888888),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Search Bar
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: const Color(0xFF9AFF00).withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF9AFF00).withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: const Color(0xFF9AFF00).withOpacity(0.7),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'What are your Concerns',
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Location Bar Widget
class LocationBar extends StatefulWidget {
  const LocationBar({super.key});

  @override
  State<LocationBar> createState() => _LocationBarState();
}

class _LocationBarState extends State<LocationBar> {
  String _text = 'Fetching location…';
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _refreshLocation();
  }

  Future<void> _refreshLocation() async {
    setState(() => _busy = true);

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.denied || perm == LocationPermission.deniedForever) {
      setState(() {
        _text = 'Location permission denied';
        _busy = false;
      });
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      final placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);

      String? address;
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        address = [
          if (p.street?.isNotEmpty ?? false) p.street,
          if (p.subLocality?.isNotEmpty ?? false) p.subLocality,
          if (p.locality?.isNotEmpty ?? false) p.locality,
          if (p.administrativeArea?.isNotEmpty ?? false) p.administrativeArea,
          if (p.postalCode?.isNotEmpty ?? false) p.postalCode,
        ].where((s) => s != null && s!.trim().isNotEmpty).join(', ');
      }

      setState(() {
        _text = address?.isNotEmpty == true
            ? address!
            : 'Lat: ${pos.latitude.toStringAsFixed(6)}, Lon: ${pos.longitude.toStringAsFixed(6)}';
      });
    } catch (_) {
      setState(() => _text = 'Location unavailable');
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(
          color: const Color(0xFF9AFF00).withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9AFF00).withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _busy ? null : _refreshLocation,
            icon: _busy
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFF9AFF00),
                      ),
                    ),
                  )
                : const Icon(
                    Icons.refresh,
                    color: Color(0xFF9AFF00),
                  ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _text,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────
/// Page stubs for the other tabs
/// ─────────────────────────
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFF0A0A0A),
    child: const Center(
      child: Text(
        'Chat page',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});
  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFF0A0A0A),
    child: const Center(
      child: Text(
        'Map / Nearby',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFF0A0A0A),
    child: const Center(
      child: Text(
        'Help & Support',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
