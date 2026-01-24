import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/Ocr%20intoduction.dart';
import 'package:symtom_checker/homepage.dart';

class OcrDonePage extends StatelessWidget {
  const OcrDonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final padding = isMobile ? 20.0 : 40.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: isMobile ? 80 : 80),
              // Success Checkmark Circle
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5F0),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.check_circle,
                    size: 80,
                    color: const Color(0xFF199A8E),
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 30 : 50),
              // All Done Title
              Text(
                'All Done!',
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 20 : 30),
              // Description Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 40),
                child: Text(
                  'This explanation is for understanding only.\nAlways follow your doctor\'s advice for treatment.',
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 15,
                    color: const Color(0xFF666666),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: isMobile ? 40 : 60),
              // Back to Home Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
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
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 20 : 20, // slightly taller
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const FaIcon(
                    FontAwesomeIcons.house, // 🏠 Font Awesome Home
                    color: Colors.white,
                    size: 22, // ⬆ increased icon size
                  ),
                  label: Text(
                    'Back to Home',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 16 : 20),
              // Scan Another Report Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OcrIntroductionScreen(),
                      ),
                    );
                 
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCCCCCC), width: 1),
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 20 : 22, // ⬆ increased height
                      horizontal: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Scan icon (frame + line)
                      Container(
                        padding: const EdgeInsets.all(0),

                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.expand,
                                color: const Color(0xFF666666),
                                size: 22,
                              ),
                              Positioned(
                                top: 11,
                                child: Container(
                                  width: 16,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF666666),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      /// Label
                      Text(
                        'Scan Another Report',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          color: const Color(0xFF666666),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 40 : 60),
              // Privacy Notice
              Text(
                'Your health data privacy is our priority. No images were stored\nduring this session.',
                style: TextStyle(
                  fontSize: isMobile ? 11 : 13,
                  color: const Color(0xFFBBBBBB),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 40 : 80),
            ],
          ),
        ),
      ),
    );
  }
}
