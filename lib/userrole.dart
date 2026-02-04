import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/doctorsignin.dart';

void main() {
  runApp(const SevAIApp());
}

class SevAIApp extends StatelessWidget {
  const SevAIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SEV-AI',
      theme: ThemeData(
        primaryColor: const Color(0xFF199A8E),
        fontFamily: 'Roboto',
      ),
      home: const UserRolePage(),
    );
  }
}

/* ================= USER ROLE PAGE ================= */

class UserRolePage extends StatefulWidget {
  const UserRolePage({Key? key}) : super(key: key);

  @override
  State<UserRolePage> createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  String selectedRole = 'doctor';

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          constraints: BoxConstraints(minHeight: screenHeight),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24.0 : 48.0,
            vertical: isMobile ? 32.0 : 48.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: isMobile ? 24 : 48),

              // Logo - Centered
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: isMobile ? 80 : 100,
                  height: isMobile ? 80 : 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF199A8E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.stethoscope,
                      size: isMobile ? 48 : 60,
                      color: const Color(0xFF199A8E),
                    ),
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 32 : 48),

              // Title - Centered
              Align(
                alignment: Alignment.center,
                child: Text(
                  'SEV-AI',
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 8 : 12),

              // Subtitle - Centered
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Symptom Triage & Care Navigation',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: isMobile ? 48 : 64),

              // Continue as - Left Aligned
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Continue as',
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 24 : 32),

              // Role Cards - Full Width
              Column(
                children: [
                  _buildRoleCard(
                    icon: FontAwesomeIcons.user,
                    title: 'Patient',
                    subtitle: 'Get symptom guidance',
                    isSelected: selectedRole == 'patient',
                    onTap: () {
                      setState(() => selectedRole = 'patient');
                      // Add your onPressed logic for Patient here
                    },
                    isMobile: isMobile,
                  ),

                  SizedBox(height: isMobile ? 16 : 20),

                  _buildRoleCard(
                    icon: FontAwesomeIcons.userDoctor,
                    title: 'Doctor',
                    subtitle: 'Review cases & advise',
                    isSelected: selectedRole == 'doctor',
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorSignIn(),
                              ),
                            );
                    },
                    isMobile: isMobile,
                  ),

                  SizedBox(height: isMobile ? 16 : 20),

                  _buildRoleCard(
                    icon: Icons.business,
                    title: 'Organization',
                    subtitle: 'Manage clinics',
                    isSelected: selectedRole == 'organization',
                    onTap: () {
                      setState(() => selectedRole = 'organization');
                      // Add your onPressed logic for Organization here
                    },
                    isMobile: isMobile,
                  ),
                ],
              ),

              SizedBox(height: isMobile ? 48 : 64),

              // Footer - Centered
              Align(
                alignment: Alignment.center,
                child: Text(
                  'By continuing, you agree to our Terms & Privacy Policy',
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 13,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    bool isPrimary = false,
    String? badge,
    required bool isMobile,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: isPrimary || isSelected
                  ? const Color(0xFF199A8E)
                  : Colors.grey[300]!,
              width: isPrimary || isSelected ? 2.5 : 1.5,
            ),
            borderRadius: BorderRadius.circular(16),
            color: isPrimary || isSelected
                ? const Color(0xFF199A8E).withOpacity(0.05)
                : Colors.white,
          ),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon on the left
                  Container(
                    width: isMobile ? 48 : 56,
                    height: isMobile ? 48 : 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF199A8E).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: isMobile ? 28 : 32,
                      color: const Color(0xFF199A8E),
                    ),
                  ),
                  SizedBox(width: isMobile ? 16 : 20),
                  // Text content on the right
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: isMobile ? 4 : 6),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: isMobile ? 13 : 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              if (badge != null)
                Positioned(
                  top: isMobile ? 12 : 16,
                  right: isMobile ? 12 : 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8 : 10,
                      vertical: isMobile ? 4 : 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF199A8E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        fontSize: isMobile ? 11 : 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

