import 'package:flutter/material.dart';
import 'package:symtom_checker/medical_quality.dart';
import 'package:symtom_checker/privacy_policy.dart';
import 'package:symtom_checker/terms_and_conditions.dart';


class AboutSevAIPage extends StatefulWidget {
  const AboutSevAIPage({Key? key}) : super(key: key);

  @override
  State<AboutSevAIPage> createState() => _AboutSevAIPageState();
}

class _AboutSevAIPageState extends State<AboutSevAIPage> {
  final Color appColor = const Color(0xFF199A8E);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final horizontalPadding = isMobile ? 16.0 : 40.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'About SEV-AI',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth > 800 ? 800 : constraints.maxWidth;

          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SEV-AI Description Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is SEV-AI?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: appColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: appColor.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
  '                SEV-AI is an AI-powered symptom triage and care navigation platform designed to help users make safe and informed healthcare decisions. It analyzes symptoms using trusted medical guidelines and classifies urgency into self-care, telehealth, clinic visit, or emergency care.\n\n'
  'The system follows a safety-first approach with red-flag detection and emergency escalation. With multilingual and voice-based access, SEV-AI improves healthcare reach for rural and underserved populations while ensuring privacy-first, responsible, explainable and accessible digital healthcare support.',
  style: TextStyle(
    fontSize: 15,
    color: const Color(0xFF333333),
    height: 1.6,
    fontWeight: FontWeight.w500,
  ),
),

                          ),
                        ],
                      ),
                    ),

                    // Legal Documents Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Legal & Quality',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Terms & Conditions Button
                          _buildLegalButton(
                            context,
                            title: 'Terms & Conditions',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TermsAndConditionsPage(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Privacy Policy Button
                          _buildLegalButton(
                            context,
                            title: 'Privacy Policy',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyPolicyPage(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Medical Quality Button
                          _buildLegalButton(
                            context,
                            title: 'Medical Quality',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MedicalQualityPage(),
                              ),
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
        },
      ),
    );
  }

  Widget _buildLegalButton(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
