import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'What is Luna?',
      'answer':
          'Luna is an Ayurvedic first-aid guide offering natural remedies for common issues.',
    },
    {
      'question': 'Is this medically certified?',
      'answer':
          'Our content is based on traditional Ayurvedic sources. We recommend consulting a professional for serious cases.',
    },
    {
      'question': 'How do I contact support?',
      'answer':
          'Tap on the "Contact us" button below or reach out via the settings section.',
    },
    {
      'question': 'Can I use it offline?',
      'answer': 'Yes! The basic remedies are available even without internet.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: [
                  const Text(
                    "FAQ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB6F265),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Get quick answers to your questions.\nTo understand more, contact us.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 28),
                  ...faqs.map((faq) => _buildFAQCard(faq)).toList(),
                  const SizedBox(height: 100),
                ],
              ),
            ),

            // Sticky Bottom Buttons
            Container(
              color: const Color(0xFF1E1E1E),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Read all FAQ action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF84CC16),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Read all FAQ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Contact action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9F99D),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Contact us",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQCard(Map<String, String> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF84CC16), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            faq['question']!,
            style: const TextStyle(
              color: Color(0xFFD9F99D),
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            faq['answer']!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
