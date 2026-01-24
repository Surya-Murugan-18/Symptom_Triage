import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/pill%20remainder.dart';
import 'package:symtom_checker/Ocr scan.dart';

class OcrIntroductionScreen extends StatelessWidget {
  const OcrIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final horizontalPadding = isMobile ? 20.0 : 40.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isMobile ? 30.0 : 50.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scan Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5F2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// Scan frame
                      const FaIcon(
                        FontAwesomeIcons.expand,
                        color: Color(0xFF199A8E),
                        size: 28,
                      ),

                      /// Horizontal scan line
                      Positioned(
                        top: 13,
                        child: Container(
                          width: 20,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Color(0xFF199A8E),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Title with decorative circle
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Scan Your Report',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 28 : 36,
                          ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 12 : 20),
                  
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                'Upload or scan your medical report or prescription. We will explain it in simple terms.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: isMobile ? 14 : 16,
                  height: 1.5,
                ),
              ),
           

              // Pink divider line
              
              const SizedBox(height: 28),

              // Supported Documents Section
              Text(
                'Supported Documents',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 18 : 18,
                ),
              ),
              const SizedBox(height: 16),

              // Document Items
              _buildDocumentItem(
                context,
                icon: Icons.description,
                title: 'Prescriptions',
              ),
              const SizedBox(height: 12),
              _buildDocumentItem(
                context,
                icon: Icons.description,
                title: 'Lab Reports',
              ),
              const SizedBox(height: 12),
              _buildDocumentItem(
                context,
                icon: Icons.description,
                title: 'Discharge Summaries',
              ),
              const SizedBox(height: 24),

              // Safety Disclaimer Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: const Color(0xFFFF9800),
                      size: isMobile ? 20 : 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Safety Disclaimer',
                            style: TextStyle(
                              color: const Color(0xFFD32F2F),
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 14 : 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'This feature does not provide medical diagnosis or treatment advice. It is for explanation purposes only.',
                            style: TextStyle(
                              color: const Color(0xFFD32F2F),
                              fontSize: isMobile ? 12 : 14,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                   
                  ],
                ),
              ),
           

              // Pink divider line
              
              const SizedBox(height: 28),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                height: isMobile ? 50 : 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CaptureReportScreen(), // Corrected class name
                                ),
                              );
                    // Add your scan functionality here
                  },
                  icon: SizedBox(
                    width: 22,
                    height: 22,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        /// Scan frame
                        const FaIcon(FontAwesomeIcons.expand, size: 20),

                        /// Horizontal scan line
                        Positioned(
                          top: 10,
                          child: Container(
                            width: 14,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  label: const Text('Scan Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF199A8E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: isMobile ? 50 : 56,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Add your gallery upload functionality here
                  },
                  icon: const FaIcon(FontAwesomeIcons.upload, size: 18),
                  label: const Text('Upload from Gallery'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFF199A8E),
                      width: 1.5,
                    ),
                    foregroundColor: const Color.fromARGB(255, 62, 62, 62),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 30 : 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentItem(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF199A8E), size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
