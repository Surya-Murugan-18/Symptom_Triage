import 'package:flutter/material.dart';
import 'package:symtom_checker/homepage.dart';
import 'package:symtom_checker/ocr%20analyse.dart';

class CaptureReportScreen extends StatefulWidget {
  const CaptureReportScreen({Key? key}) : super(key: key);

  @override
  State<CaptureReportScreen> createState() => _CaptureReportScreenState();
}

class _CaptureReportScreenState extends State<CaptureReportScreen> {
  static const Color appColor = Color(0xFF199A8E);
  static const Color textColor = Colors.black;
  static const Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Capture Report',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40,
            vertical: 20,
          ),
          child: Column(
            children: [
              // Document Frame
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: isMobile ? 400 : 500,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: appColor,
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    // Corner brackets
                    Positioned(
                      top: 20,
                      left: 20,
                      child: _buildCornerBracket(isTopLeft: true),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: _buildCornerBracket(isTopLeft: false, isTop: true),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: _buildCornerBracket(isTopLeft: true, isTop: false),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: _buildCornerBracket(isTopLeft: false),
                    ),
                    // Center text
                    Center(
                      child: Text(
                        'Align document within frame',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: isMobile ? 14 : 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 30 : 40),

              // Checklist Items
              Column(
                children: [
                  _buildChecklistItem('Ensure good lighting'),
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildChecklistItem('Keep text clearly visible'),
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildChecklistItem('Avoid blurred images'),
                ],
              ),
              SizedBox(height: isMobile ? 40 : 60),

              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gallery Button
                  Container(
                    width: isMobile ? 60 : 80,
                    height: isMobile ? 60 : 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          
                          // Handle gallery selection
                         
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.grey[200],
                              size: isMobile ? 28 : 36,
                            ),
                            SizedBox(height: isMobile ? 4 : 8),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: isMobile ? 11 : 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 30 : 50),

                  // Camera Button
                  Container(
                    width: isMobile ? 80 : 100,
                    height: isMobile ? 80 : 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: appColor,
                        width: 3,
                      ),
                    ),
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OcrAnalysePage(), // Corrected class name
                                ),
                              );
                          // Handle camera capture
                          
                        },
                        customBorder: const CircleBorder(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: appColor,
                              width: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCornerBracket({
    required bool isTopLeft,
    bool isTop = true,
  }) {
    final size = 20.0;
    final rotation = isTopLeft
        ? (isTop ? 0.0 : 180.0)
        : (isTop ? 90.0 : 270.0);

    return Transform.rotate(
      angle: rotation * 3.14159 / 180,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: appColor, width: 2),
            left: BorderSide(color: appColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistItem(String text) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: appColor, width: 2),
          ),
         child: const Center(
  child: Icon(
    Icons.check,
    size: 16,
    color: appColor,
    fontWeight: FontWeight.bold, // or appColor if needed
  ),
),

        ),
        SizedBox(width: MediaQuery.of(context).size.width < 600 ? 12 : 16),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: MediaQuery.of(context).size.width < 600 ? 14 : 16,
          ),
        ),
      ],
    );
  }
}