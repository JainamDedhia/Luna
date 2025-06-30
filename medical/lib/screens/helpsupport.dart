import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// Import your theme constants
const Color backgroundDark = Color(0xFF0A0A0A);
const Color backgroundMid = Color(0xFF1A1A1A);
const Color neonGreen = Color(0xFF9AFF00);
const Color subtitleGray = Color(0xFF888888);
const Color cardBackground = Color(0xFF252525);

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.info,
              color: isSuccess ? neonGreen : Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundMid,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: neonGreen.withOpacity(0.3)),
        ),
      ),
    );
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, '$label copied to clipboard!', isSuccess: true);
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@yourapp.com',
      queryParameters: {
        'subject': 'Support Request - YourApp',
        'body': 'Hi,\n\nI need help with:\n\n',
      },
    );
    
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _copyToClipboard('support@yourapp.com', 'Email address');
      }
    } catch (e) {
      _copyToClipboard('support@yourapp.com', 'Email address');
    }
  }

  void _showFeedbackDialog() {
    final TextEditingController feedbackController = TextEditingController();
    int selectedRating = 5;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: backgroundMid,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: neonGreen.withOpacity(0.3)),
              ),
              title: const Text(
                'Send Feedback',
                style: TextStyle(color: neonGreen, fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rate your experience:',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRating = index + 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(
                              Icons.star,
                              color: index < selectedRating ? neonGreen : subtitleGray,
                              size: 32,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tell us more:',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: feedbackController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Share your thoughts, suggestions, or issues...',
                        hintStyle: TextStyle(color: subtitleGray),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: subtitleGray),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: neonGreen),
                        ),
                        filled: true,
                        fillColor: backgroundDark,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: subtitleGray),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showSnackBar(
                      context,
                      'Thank you for your ${selectedRating}-star feedback!',
                      isSuccess: true,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neonGreen,
                    foregroundColor: backgroundDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showBugReportDialog() {
    final TextEditingController bugController = TextEditingController();
    String selectedSeverity = 'Medium';
    String selectedCategory = 'UI/UX';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: backgroundMid,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: neonGreen.withOpacity(0.3)),
              ),
              title: const Text(
                'Report a Bug',
                style: TextStyle(color: neonGreen, fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Severity:', style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 4),
                              DropdownButtonFormField<String>(
                                value: selectedSeverity,
                                dropdownColor: backgroundMid,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: subtitleGray),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                items: ['Low', 'Medium', 'High', 'Critical']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSeverity = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Category:', style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 4),
                              DropdownButtonFormField<String>(
                                value: selectedCategory,
                                dropdownColor: backgroundMid,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: subtitleGray),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                items: ['UI/UX', 'Performance', 'Functionality', 'Crash', 'Other']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCategory = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Describe the issue:', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: bugController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'What happened? Steps to reproduce?',
                        hintStyle: TextStyle(color: subtitleGray),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: subtitleGray),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: neonGreen),
                        ),
                        filled: true,
                        fillColor: backgroundDark,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel', style: TextStyle(color: subtitleGray)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showSnackBar(
                      context,
                      'Bug report submitted! Ticket #${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                      isSuccess: true,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neonGreen,
                    foregroundColor: backgroundDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Submit Report', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        backgroundColor: backgroundMid,
        title: const Text('Help & Support', style: TextStyle(color: neonGreen, fontWeight: FontWeight.bold)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: neonGreen),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Welcome Section
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      neonGreen.withOpacity(0.1),
                      neonGreen.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: neonGreen.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.support_agent, color: neonGreen, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'We\'re here to help!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Get quick answers to your questions or reach out to our support team.',
                      style: TextStyle(color: subtitleGray, fontSize: 16),
                    ),
                  ],
                ),
              ),

              // Quick Actions Section
              _sectionLabel('Quick Actions'),
              Row(
                children: [
                  Expanded(
                    child: _quickActionCard(
                      icon: Icons.chat_bubble_outline,
                      label: 'Live Chat',
                      onTap: () => _showSnackBar(context, 'Live chat coming soon!'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _quickActionCard(
                      icon: Icons.call,
                      label: 'Call Us',
                      onTap: () => _copyToClipboard('+1-800-SUPPORT', 'Phone number'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Support Options Section
              _sectionLabel('Support Options'),
              _supportTile(
                context,
                icon: Icons.help_outline,
                title: 'FAQ & Troubleshooting',
                subtitle: 'Find answers to common questions',
                badge: 'Popular',
                onTap: () => _showSnackBar(context, 'FAQ section opening...'),
              ),
              _supportTile(
                context,
                icon: Icons.email_outlined,
                title: 'Contact Support',
                subtitle: 'Get personalized help via email',
                onTap: _launchEmail,
              ),
              _supportTile(
                context,
                icon: Icons.feedback_outlined,
                title: 'Send Feedback',
                subtitle: 'Help us improve your experience',
                onTap: _showFeedbackDialog,
              ),
              _supportTile(
                context,
                icon: Icons.bug_report_outlined,
                title: 'Report a Bug',
                subtitle: 'Something not working correctly?',
                onTap: _showBugReportDialog,
              ),

              const SizedBox(height: 24),

              // Resources Section
              _sectionLabel('Resources'),
              _supportTile(
                context,
                icon: Icons.book_outlined,
                title: 'User Guide',
                subtitle: 'Complete documentation and tutorials',
                onTap: () => _showSnackBar(context, 'User guide opening...'),
              ),
              _supportTile(
                context,
                icon: Icons.video_library_outlined,
                title: 'Video Tutorials',
                subtitle: 'Step-by-step video guides',
                onTap: () => _showSnackBar(context, 'Video tutorials opening...'),
              ),
              _supportTile(
                context,
                icon: Icons.people_outline,
                title: 'Community Forum',
                subtitle: 'Connect with other users',
                badge: 'New',
                onTap: () => _showSnackBar(context, 'Community forum opening...'),
              ),

              const SizedBox(height: 32),

              // Contact Info Footer
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: neonGreen.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Need immediate assistance?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Average response time: 2-4 hours',
                      style: TextStyle(color: subtitleGray, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time, color: neonGreen, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Support Hours: 9 AM - 6 PM EST',
                          style: TextStyle(color: subtitleGray, fontSize: 12),
                        ),
                      ],
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

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: neonGreen,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _quickActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: neonGreen.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: neonGreen, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _supportTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    String? badge,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: backgroundMid,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: neonGreen.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: neonGreen.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: neonGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: neonGreen, size: 24),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: neonGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: backgroundDark,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: subtitleGray, fontSize: 14),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: neonGreen.withOpacity(0.7),
          size: 24,
        ),
        onTap: onTap,
      ),
    );
  }
}