import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/medication%202.dart';

class MedicationReminderScreen extends StatelessWidget {
  const MedicationReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pill Icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF199A8E).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.pills,
                        color: Color(0xFF199A8E),
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Title
                  const Text(
                    'Medication Reminders',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  const Text(
                    'Set reminders to take medicines on time as\nprescribed by your doctor.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  
                  // Features List
                 Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 249, 250, 250), // grey background
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFD1D5DB), // grey outline
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildFeatureItem(
                        icon: FontAwesomeIcons.bell,
                        text: 'Never miss a dose',
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureItem(
                        icon: FontAwesomeIcons.circleCheck,
                        text: 'Simple alerts',
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureItem(
                        icon: FontAwesomeIcons.capsules,
                        text: 'Easy to manage',
                      ),
                    ],
                  ),
                ),
                  const SizedBox(height: 60),
                  
                  // Add Reminder Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicationReminders(),
                              ),
                            );
                        // Add your button action here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199A8E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Lets Begin',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Disclaimer
                  const Text(
                    'This app does not provide medical advice.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
  required IconData icon,
  required String text,
}) {
  return Row(
    children: [
        const SizedBox(width: 20),
      /// Icon circle
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white, // white icon background
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFD1D5DB), // grey outline
            width: 1,
          ),
        ),
        child: Center(
          child: FaIcon(
            icon,
            color: const Color(0xFF199A8E),
            size: 20,
          ),
        ),
      ),

      const SizedBox(width: 16),

      /// Text
      Expanded(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

}