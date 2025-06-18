import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:medical/screens/FAQ.dart';
import 'package:medical/screens/educational_lessons_app.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static final _pages = <Widget>[
    const MainPage(),
    const ChatPage(),
    const MapPage(),
    const HelpPage(),
  ];

  void _onNavTap(int newIdx) => setState(() => _index = newIdx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _MainDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: CircleAvatar(
              radius: 18,
              child: Icon(Icons.account_circle_outlined, size: 30),
            ),
          ),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onNavTap,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.place_outlined), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.call_outlined), label: 'Help'),
        ],
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'Luna Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Educational Lessons'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EducationalLessonsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer_outlined),
            title: const Text('FAQ'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            LocationBar(),
            SizedBox(height: 24),
            Text(
              'Welcome to Luna!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            // Add more homepage widgets here if needed
          ],
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
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _busy ? null : _refreshLocation,
            icon: _busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _text,
                  style: const TextStyle(fontSize: 15),
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
  Widget build(BuildContext context) => const Center(child: Text('Chat page'));
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Map / Nearby'));
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Help & Support'));
}
