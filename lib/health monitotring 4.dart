import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:symtom_checker/health%20monitotring%205.dart';

class DeviceConnectedPage extends StatefulWidget {
  final String deviceName;
  final String deviceType;
  final IconData deviceIcon;

  const DeviceConnectedPage({
    Key? key,
    required this.deviceName,
    required this.deviceType,
    required this.deviceIcon,
  }) : super(key: key);

  @override
  State<DeviceConnectedPage> createState() => _DeviceConnectedPageState();
}

class _DeviceConnectedPageState extends State<DeviceConnectedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 600;
    final maxWidth = isDesktop ? 500.0 : screenWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: maxWidth,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 40 : 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Success Icon with Animation
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: isDesktop ? 120 : 100,
                    height: isDesktop ? 120 : 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF199A8E).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: isDesktop ? 90 : 75,
                        height: isDesktop ? 90 : 75,
                        decoration: BoxDecoration(
                          color: const Color(0xFF199A8E).withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: isDesktop ? 50 : 42,
                            color: const Color(0xFF199A8E),
                            weight: 3.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isDesktop ? 40 : 32),

                // Title with Fade Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Device Connected!',
                    style: TextStyle(
                      fontSize: isDesktop ? 32 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: isDesktop ? 16 : 12),

                // Description with Fade Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 20 : 16,
                    ),
                    child: Text(
                      'Your device has been successfully paired and is ready to stream vitals.',
                      style: TextStyle(
                        fontSize: isDesktop ? 16 : 15,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                SizedBox(height: isDesktop ? 50 : 40),

                // Device Info Card
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isDesktop ? 24 : 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    
                    child: Column(
                      children: [
                        // Device Name and Status
                        Row(
                          children: [
                            // Device Icon
                            Container(
                              width: isDesktop ? 56 : 48,
                              height: isDesktop ? 56 : 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF199A8E).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                widget.deviceIcon,
                                color: const Color(0xFF199A8E),
                                size: isDesktop ? 30 : 26,
                              ),
                            ),
                            SizedBox(width: isDesktop ? 16 : 14),

                            // Device Name and Status
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.deviceName,
                                    style: TextStyle(
                                      fontSize: isDesktop ? 18 : 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Active & Monitoring',
                                    style: TextStyle(
                                      fontSize: isDesktop ? 14 : 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                         SizedBox(height: isDesktop ? 24 : 20),
Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey.shade300,
                            ),
                        SizedBox(height: isDesktop ? 24 : 20),

                        // Battery and Last Sync
                        Row(
                          children: [
                            // Battery Section
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.battery_std,
                                    color: Colors.grey[400],
                                    size: isDesktop ? 24 : 22,
                                  ),
                                  SizedBox(width: isDesktop ? 12 : 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Battery',
                                        style: TextStyle(
                                          fontSize: isDesktop ? 13 : 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '84%',
                                        style: TextStyle(
                                          fontSize: isDesktop ? 17 : 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Vertical Divider
                            Container(
                              width: 1,
                              height: isDesktop ? 45 : 40,
                              color: Colors.grey[200],
                            ),

                            SizedBox(width: isDesktop ? 16 : 12),

                            // Last Sync Section
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey[400],
                                    size: isDesktop ? 24 : 22,
                                  ),
                                  SizedBox(width: isDesktop ? 12 : 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Last Sync',
                                        style: TextStyle(
                                          fontSize: isDesktop ? 13 : 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Just now',
                                        style: TextStyle(
                                          fontSize: isDesktop ? 17 : 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 3),

                // View Vitals Button
                SizedBox(
                  width: double.infinity,
                  height: isDesktop ? 60 : 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HealthVitalsPage()),
                            );
                      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF199A8E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'View Vitals',
                      style: TextStyle(
                        fontSize: isDesktop ? 18 : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isDesktop ? 30 : 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
