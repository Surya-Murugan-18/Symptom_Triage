import 'package:flutter/material.dart';
import 'package:symtom_checker/doctor_dashboard.dart';


class DocumentsVerification extends StatefulWidget {
  final String? doctorName;
  final VoidCallback? onDashboardTap;

  const DocumentsVerification({
    Key? key,
    this.doctorName = 'Dr. Mitchell',
    this.onDashboardTap,
  }) : super(key: key);

  @override
  State<DocumentsVerification> createState() => _DocumentsVerificationState();
}

class _DocumentsVerificationState extends State<DocumentsVerification>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isMobile ? screenWidth : 600,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 40,
                vertical: isMobile ? 60 : 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Add top spacing
                  SizedBox(height: isMobile ? 40 : 80),

                  // Animated Checkmark Circle
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: isMobile ? 120 : 140,
                      height: isMobile ? 120 : 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF199A8E).withOpacity(0.1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle_outline_rounded,
                          size: isMobile ? 70 : 80,
                          color: const Color(0xFF199A8E),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 48 : 56),

                  // Title
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: Text(
                      'Verification Complete',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 24 : 28),

                  // Subtitle
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: Text(
                      'Welcome to SEV-AI, ${widget.doctorName}. Your account is now active and you can start accepting cases.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                        height: 1.6,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 48 : 56),

                  // Dashboard Button
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            widget.onDashboardTap ??
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDashboard(),
                                ),
                              );
                            },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF199A8E),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 20 : 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          shadowColor: const Color(0xFF199A8E).withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Go to Dashboard ',
                              style: TextStyle(
                                fontSize: isMobile ? 18 : 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Icon(Icons.arrow_forward, size: isMobile ? 18 : 20),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 40 : 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
