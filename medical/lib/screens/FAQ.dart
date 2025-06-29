import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});


  @override
  Widget build(BuildContext context) {
    final l10n=AppLocalizations.of(context)!;
  final faqs = [
  {'question': l10n.faqQ1, 'answer': l10n.faqA1},
  {'question': l10n.faqQ2, 'answer': l10n.faqA2},
  {'question': l10n.faqQ3, 'answer': l10n.faqA3},
  {'question': l10n.faqQ4, 'answer': l10n.faqA4},
  ];
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
                  Text(
                    l10n.faqTitle,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB6F265),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.faqSubtitle,
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
                      child: Text(
                        l10n.readAllFAQ,
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
                      child: Text(
                        l10n.contactUs,
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
