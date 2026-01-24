import 'package:flutter/material.dart';
import 'package:symtom_checker/ocr%20nextstep.dart';

class ImportantNotesScreen extends StatelessWidget {
  const ImportantNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;
    final maxWidth = isDesktop ? 600.0 : screenWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: maxWidth,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : 20,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shield Icon
              Container(
  width: 48,
  height: 48,
  decoration: BoxDecoration(
    color: const Color(0xFFFFF9E6),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        /// Shield icon
        Icon(
          Icons.shield_outlined,
          color: const Color(0xFFFFB800),
          size: 32,
        ),

        /// Exclamation symbol inside shield
        Text(
          '!',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFB800),
          ),
        ),
      ],
    ),
  ),
),

              const SizedBox(height: 24),

              // Title
              const Text(
                'Important Notes',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle
              const Text(
                'Please keep these safety guidelines in mind regarding your report.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Take as prescribed
              _buildNoteItem(
                icon: Icons.check_circle_outline,
                iconColor: const Color(0xFF199A8E),
                title: 'Take as prescribed',
                description:
                    'Follow the exact dosage and timing written by your doctor.',
              ),
              const SizedBox(height: 24),

              // Do not self-medicate
              _buildNoteItem(
                icon: Icons.check_circle_outline,
                iconColor: const Color(0xFF199A8E),
                title: 'Do not self-medicate',
                description:
                    'Never start or stop medicines without consulting a professional.',
              ),
              const SizedBox(height: 24),

              // Complete the course
              _buildNoteItem(
                icon: Icons.check_circle_outline,
                iconColor: const Color(0xFF199A8E),
                title: 'Complete the course',
                description:
                    'Finish the full course of antibiotics even if you feel better.',
              ),
              const SizedBox(height: 32),

              // Warning Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(12),
                   border: Border.all(
      color: const Color.fromARGB(255, 247, 184, 184), // 🔴 outline color
      width: 1,
    ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xFFDC2626),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Warning',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFDC2626),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'If your symptoms worsen or you experience side effects, consult a doctor immediately or visit the nearest hospital.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFDC2626),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // I Understand Button
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {

                    // Handle button press
Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NextStepsScreen(),
                              ),
                            );                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF199A8E),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'I Understand',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: isDesktop ? 40 : 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}