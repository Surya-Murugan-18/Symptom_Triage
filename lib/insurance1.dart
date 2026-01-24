import 'package:flutter/material.dart';
import 'package:symtom_checker/homepage.dart';
import 'package:symtom_checker/insurance2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Insurance1Page extends StatelessWidget {
  const Insurance1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 600;
            final isMobile = !isDesktop;
            final maxWidth = isDesktop ? 400.0 : constraints.maxWidth;

            return Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 40.0 : 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Shield Icon
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF199A8E,
                              ).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: const [
                                  /// Shield
                                  Icon(
                                    Icons.shield_outlined,
                                    size: 50,
                                    color: Color(0xFF199A8E),
                                  ),

                                  /// Tick inside shield
                                  Icon(
                                    Icons.check,
                                    size: 26,
                                    color: Color(0xFF199A8E),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Title
                          const Text(
                            'Insurance Assistance',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),

                          // Description
                          const Text(
                            'Get general insurance guidance\nrelated to your recommended care.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),

                          // Info Box
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 246, 255),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: Color.fromARGB(255, 23, 92, 187),
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'This feature does not provide policy purchase or verification. It is for informational purposes only.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue[800],
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom Section
                    Column(
                      children: [
                        // Continue Button
                        SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InsuranceAssistancePage(),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF199A8E),
      padding: const EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
        FaIcon(
          FontAwesomeIcons.arrowRight,
          color: Colors.white,
          size: 22,
        ),
        SizedBox(width: 12),
        Text(
          'Continue',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),
),

                        const SizedBox(height: 16),

                        SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HealthcareHomePage(),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF199A8E),
      padding: const EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
        FaIcon(
          FontAwesomeIcons.house,
          color: Colors.white,
          size: 22,
        ),
        SizedBox(width: 12),
        Text(
          'Back to Home',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),
),


                        const SizedBox(height: 18),
                        // Footer Text
                        const Text(
                          'Secure & Confidential • No Personal Data Stored',
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
