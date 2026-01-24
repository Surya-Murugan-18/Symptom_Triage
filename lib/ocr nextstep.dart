import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/chatscreen.dart';
import 'package:symtom_checker/finddoctor.dart';
import 'package:symtom_checker/ocr%20done.dart';

class NextStepsScreen extends StatelessWidget {
  const NextStepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final padding = isMobile ? 20.0 : 40.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: isMobile ? 120.0 : 120.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                const Text(
                  'Next Steps',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                // Subtitle
                Text(
                  'Would you like help deciding your next step of\ncare?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 48),
                // Start Symptom Check Card
                _buildNextStepCard(
  context: context,
  icon: FontAwesomeIcons.heartPulse,
  title: 'Start Symptom Check',
  subtitle: 'Check if you need urgent care',
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(),
      ),
    );
  },
  isMobile: isMobile,
),


                const SizedBox(height: 20),
                // Find Doctor / Clinic Card
                _buildNextStepCard(
                  context: context,
                  icon: FontAwesomeIcons.stethoscope,
                  title: 'Find Doctor / Clinic',
                  subtitle: 'Book an appointment nearby',
                  onPressed: () {
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FindDoctorsPage(),
                              ),
                            );
                    // Handle Find Doctor / Clinic
                  },
                  isMobile: isMobile,
                ),
                const SizedBox(height: 40),
                // Skip for now Button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>OcrDonePage(),
                              ),
                            );
                    
                    // Handle Skip for now
                  },
                  child: const Text(
                    'Skip for now',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextStepCard({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onPressed,
  required bool isMobile,
}) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      onTap: onPressed, // ← Material button behavior
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF199A8E).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FaIcon(
                icon,
                color: const Color(0xFF199A8E),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            IconButton(
  onPressed: onPressed, // 👈 uses the same navigation callback
  icon: Icon(
    Icons.arrow_forward_ios,
    color: Colors.grey[400],
    size: 18,
  ),
),

          ],
        ),
      ),
    ),
  );
}

}