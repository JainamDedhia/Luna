import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          l10n.profile,
          style: TextStyle(
            color: Color(0xFFB6F265),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: const Color(0xFF262626),
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : null,
              child: _profileImage == null
                  ? const Icon(Icons.camera_alt, size: 40, color: Colors.white54)
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Hailey Jons',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD9F99D),
            ),
          ),
          // const Text(
          //   'Flutter Developer',
          //   style: TextStyle(fontSize: 15, color: Colors.white70),
          // ),
          const SizedBox(height: 30),
          Divider(color: Colors.grey[800], thickness: 1),
          const SizedBox(height: 10),
          _buildInfoTile(Icons.email, l10n.email, 'haileyjons@example.com'),
          _buildInfoTile(Icons.phone, l10n.phone, '+91 98765 43210'),
          _buildInfoTile(Icons.location_on, l10n.location, 'Ronbinsville, New Jersey'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Edit profile
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF84CC16),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.edit),
                    label: Text(l10n.edit),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Logout
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD9F99D),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.logout),
                    label: Text(l10n.logout),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF84CC16)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFD9F99D),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
