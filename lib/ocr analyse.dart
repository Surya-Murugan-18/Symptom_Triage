import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'ocr summary.dart';

class OcrAnalysePage extends StatefulWidget {
  const OcrAnalysePage({Key? key}) : super(key: key);

  @override
  State<OcrAnalysePage> createState() => _OcrAnalysePageState();
}

class _OcrAnalysePageState extends State<OcrAnalysePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Navigate to OCRSummaryScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OCRSummaryScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 600 : double.infinity,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 40 : 24,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Animated Shield Icon
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer rotating circle
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animationController.value * 2 * math.pi,
                          child: Container(
                            width: isDesktop ? 140 : 120,
                            height: isDesktop ? 140 : 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                startAngle: 0,
                                endAngle: 2 * math.pi,
                                colors: const [
                                  Color(0xFF199A8E),
                                  Color(0xFF199A8E),
                                  Color(0xFF199A8E),
                                  Color(0xFF199A8E),
                                  Color.fromARGB(255, 201, 241, 237),
                                ],
                                stops: const [0.0, 0.55, 0.65, 0.7, 1.0],
                              ),
                            ),
                            foregroundDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF199A8E).withOpacity(0.15),
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Inner circle with shield
                    Container(
                      width: isDesktop ? 120 : 100,
                      height: isDesktop ? 120 : 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE8F5F3),
                        border: Border.all(
                          color: const Color(0xFFD4EBE8),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            /// Shield icon
                            Icon(
                              Icons.shield_outlined,
                              size: isDesktop ? 50 : 40,
                              color: const Color(0xFF199A8E),
                            ),

                            /// Tick inside shield
                            Icon(
                              Icons.check,
                              size: isDesktop ? 26 : 22,
                              color: const Color(0xFF199A8E),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isDesktop ? 60 : 50),
                // Title
                Text(
                  'Analyzing your report...',
                  style: TextStyle(
                    fontSize: isDesktop ? 26 : 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isDesktop ? 20 : 16),
                // Subtitle
                Text(
                  'Extracting text and understanding medical\nterms.',
                  style: TextStyle(
                    fontSize: isDesktop ? 16 : 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF677294),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                // Security Notice
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 24 : 20,
                    vertical: isDesktop ? 16 : 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(52),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: isDesktop ? 22 : 18,
                        height: isDesktop ? 22 : 18,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.shield_outlined,
                              size: isDesktop ? 22 : 18,
                              color: const Color(0xFF9CA3AF),
                            ),
                            Icon(
                              Icons.check,
                              size: isDesktop ? 12 : 10,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: isDesktop ? 14 : 12),
                      Expanded(
                        child: Text(
                          'Your report is processed securely and not\nstored.',
                          style: TextStyle(
                            fontSize: isDesktop ? 13 : 11,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF9CA3AF),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isDesktop ? 40 : 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}