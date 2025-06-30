import 'package:flutter/material.dart';

// Theme constants
const Color backgroundDark = Color(0xFF0A0A0A);
const Color backgroundMid = Color(0xFF1A1A1A);
const Color neonGreen = Color(0xFF9AFF00);
const Color subtitleGray = Color(0xFF888888);

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        backgroundColor: backgroundMid,
        title: const Text(
          'Settings',
          style: TextStyle(color: neonGreen),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: neonGreen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            // Notifications Section
            _sectionLabel('Notifications'),
            _switchTile('Enable reminders'),
            _switchTile('Daily health tips'),
            const SizedBox(height: 30),

            // Appearance Section
            _sectionLabel('Appearance'),
            _switchTile('Dark theme', initialValue: true),
            _fakeDropDownTile('Accent Color', 'Neon Green'),
            const SizedBox(height: 30),

            // Account Section
            _sectionLabel('Account'),
            _standardTile('Privacy Settings'),
            _standardTile('Delete Account'),
            const SizedBox(height: 30),

            // App Info Section
            _sectionLabel('About App'),
            _standardTile('Terms of Service'),
            _standardTile('Privacy Policy'),
            _standardTile('Version 1.0.0'),
          ],
        ),
      ),
    );
  }

  // Section label
  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: subtitleGray,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Standard tappable tile
  Widget _standardTile(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: backgroundMid,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: neonGreen),
        onTap: () {
          // You can add routing or snackbars here
        },
      ),
    );
  }

  // Switch tile
  Widget _switchTile(String title, {bool initialValue = false}) {
    return SwitchListTile(
      activeColor: neonGreen,
      inactiveTrackColor: subtitleGray.withOpacity(0.3),
      value: initialValue,
      onChanged: (_) {},
      title: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }

  // Fake dropdown tile for demo (non-functional)
  Widget _fakeDropDownTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: backgroundMid,
        border: Border.all(color: neonGreen.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          value,
          style: const TextStyle(color: neonGreen),
        ),
        subtitle: Text(
          title,
          style: const TextStyle(color: subtitleGray, fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_drop_down, color: neonGreen),
        onTap: () {
          ScaffoldMessenger.of(titleKey.currentContext!).showSnackBar(
            const SnackBar(
              content: Text('This is a demo. Options are not changeable yet.'),
              backgroundColor: Colors.black87,
            ),
          );
        },
      ),
    );
  }
}

// For SnackBar demo — add this in your main file or MaterialApp:
final GlobalKey<ScaffoldMessengerState> titleKey = GlobalKey<ScaffoldMessengerState>();
