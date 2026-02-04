import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:symtom_checker/health%20monitotring%203.dart';
import 'package:symtom_checker/health%20monitotring%206.dart';
import 'package:symtom_checker/health%20monitotring%207.dart';
import 'package:symtom_checker/health%20monitotring%208.dart';

class HealthVitalsPage extends StatefulWidget {
  const HealthVitalsPage({Key? key}) : super(key: key);

  @override
  State<HealthVitalsPage> createState() => _HealthVitalsPageState();
}

class _HealthVitalsPageState extends State<HealthVitalsPage> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : 32.0,
              vertical: isMobile ? 16.0 : 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Title and Settings Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Health Vitals',
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: Color(0xFF2D5F5D),
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ConnectedDevicesPage()),
                            );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 8 : 12),

                // Last Updated Text
                Text(
                  'Last updated: Just now',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 14,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // Health Metrics Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = isMobile ? 2 : 4;
                    double spacing = isMobile ? 12 : 16;

                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: isMobile ? 1.3 : 0.9,
                      children: [
                        _HealthMetricCard(
                          icon: Icons.favorite,
                          label: 'Heart Rate',
                          value: '72',
                          unit: 'bpm',
                          status: 'Normal',
                          showStatus: true,
                          isMobile: isMobile,
                          onPressed: () {
  
  },
                        ),
                        _HealthMetricCard(
                          icon: Icons.water_drop_outlined,
                          label: 'SpO₂',
                          value: '98',
                          unit: '%',
                          status: '',
                          showStatus: false,
                          isMobile: isMobile,
                          onPressed: () {
  
  },
                        ),
                        _HealthMetricCard(
                          icon: Icons.thermostat_outlined,
                          label: 'Temperature',
                          value: '36.7',
                          unit: '°C',
                          status: '',
                          showStatus: false,
                          isMobile: isMobile,
                          onPressed: () {
  
  },
                        ),
                        _HealthMetricCard(
                          icon: Icons.favorite_border,
                          label: 'Blood Pressure',
                          value: '120/80',
                          unit: 'mmHg',
                          status: '',
                          showStatus: false,
                          isMobile: isMobile,
                          onPressed: () {
  
  },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // Disclaimer
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 12 : 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF4F3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Values shown are for awareness only and not for medical diagnosis.',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 14,
                      color: const Color(0xFF5B6F6D),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // View Trends Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HealthMonitoring7Page()),
                            );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2D7A78),
                      side: const BorderSide(
                        color: Color(0xFF2D7A78),
                        width: 2,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 20 : 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16), // ✅ left space
                        Text(
                          'View Trends',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2D7A78),
                          ),
                        ),
                        const Spacer(), // ✅ pushes icon to right
                        const FaIcon(
                          FontAwesomeIcons.arrowTrendUp,
                          color: Color(0xFF2D7A78),
                          size: 24,
                        ),

                        const SizedBox(width: 18), // ✅ right space
                      ],
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 28),

                // Check Symptoms Section
                InkWell(
  onTap: () {
      Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HealthMonitoring8Page()),
                            );
    // TODO: navigate or open symptom checker
  },
  borderRadius: BorderRadius.circular(12),
  child: Container(
    width: double.infinity,
    padding: EdgeInsets.all(isMobile ? 16 : 20),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5F3),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color(0xFFC9E4E0),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Check Symptoms',
          style: TextStyle(
            fontSize: isMobile ? 15 : 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2D7A78),
          ),
        ),
        const FaIcon(
          FontAwesomeIcons.stethoscope,
          color: Color(0xFF2D7A78),
          size: 24,
        ),
      ],
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
}

class _HealthMetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final String status;
  final bool showStatus;
  final bool isMobile;
  final VoidCallback? onPressed; // ✅ added

  const _HealthMetricCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.status,
    required this.showStatus,
    required this.isMobile,
    this.onPressed, // ✅ added
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // ✅ card clickable
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: const Color(0xFF2D7A78),
              width: isMobile ? 5 : 8,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(isMobile ? 14 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon + Normal Status (Right Side)
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F9F8),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(isMobile ? 8 : 10),
                  child: Icon(
                    icon,
                    color: const Color(0xFF2D7A78),
                    size: 24,
                  ),
                ),

                const Spacer(),

                // ✅ Normal status on right side
                if (showStatus && status == 'Normal')
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5F3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8 : 10,
                      vertical: isMobile ? 3 : 4,
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 12,
                        color: const Color(0xFF2D7A78),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: isMobile ? 8 : 10),

            // Label
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: isMobile ? 4 : 6),

            // Value and Unit
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  TextSpan(
                    text: ' $unit',
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 12,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),

            // ❌ Normal badge NOT shown at bottom
            // ✅ Other statuses stay at bottom
            if (showStatus && status != 'Normal')
              Padding(
                padding: EdgeInsets.only(top: isMobile ? 6 : 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5F3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 10,
                    vertical: isMobile ? 3 : 4,
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: isMobile ? 11 : 12,
                      color: const Color(0xFF2D7A78),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

