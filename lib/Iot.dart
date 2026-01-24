import 'package:flutter/material.dart';

const Color appColor = Color(0xFF199A8E);
const Color titleColor = Colors.black;
const Color backgroundColor = Colors.white;
const Color textGrey = Color(0xFF888888);
const Color lightGrey = Color(0xFFF5F5F5);

class Iot extends StatefulWidget {
  const Iot({Key? key}) : super(key: key);

  @override
  State<Iot> createState() => _IotState();
}

class _IotState extends State<Iot> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet =
        MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 32.0,
            vertical: isMobile ? 16.0 : 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: isMobile ? 16 : 24),
              // Profile Section
              _buildProfileSection(isMobile),
              SizedBox(height: isMobile ? 24 : 32),

              // Connected Status and Sync Button
              _buildConnectedStatusBar(isMobile),
              SizedBox(height: isMobile ? 24 : 32),

              // Health Metrics Grid
              _buildHealthMetricsGrid(isMobile, isTablet),
              SizedBox(height: isMobile ? 32 : 48),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileSection(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: isMobile ? 32 : 40,
                    backgroundColor: lightGrey,
                    child: Icon(
                      Icons.person,
                      size: isMobile ? 32 : 40,
                      color: appColor,
                    ),
                  ),
                  SizedBox(width: isMobile ? 12 : 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Robert Cary',
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 22,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                      ),
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 15,
                          color: textGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Icon(
          Icons.notifications_none,
          size: isMobile ? 24 : 28,
          color: titleColor,
        ),
      ],
    );
  }

  Widget _buildConnectedStatusBar(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: appColor,
              size: isMobile ? 18 : 22,
            ),
            SizedBox(width: isMobile ? 8 : 12),
            Text(
              'Connected',
              style: TextStyle(
                fontSize: isMobile ? 13 : 15,
                color: textGrey,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 8 : 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.sync,
                size: isMobile ? 16 : 18,
                color: Colors.white,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                'Sync Now',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthMetricsGrid(bool isMobile, bool isTablet) {
    List<HealthMetric> metrics = [
      HealthMetric(
        title: 'Heart Rate',
        value: '88',
        unit: 's',
        percentage: 85,
        icon: Icons.favorite,
        details: 'Update: 1s ago',
      ),
      HealthMetric(
        title: 'Respiratory Rate',
        value: '18',
        unit: 'bpm',
        percentage: 85,
        icon: Icons.air,
        details: 'Update: 1s ago',
      ),
      HealthMetric(
        title: 'Temperature',
        value: '98.60',
        unit: '°F',
        percentage: null,
        icon: Icons.thermostat,
        details: 'Normal',
      ),
      HealthMetric(
        title: 'Blood Pressure',
        value: '120/80',
        unit: 'mmHg',
        percentage: null,
        icon: Icons.favorite_border,
        details: 'Update: 1s ago',
      ),
      HealthMetric(
        title: 'Stress Level',
        value: '35',
        unit: 'Low',
        percentage: 35,
        icon: Icons.trending_down,
        details: 'Update: 1s ago',
      ),
      HealthMetric(
        title: 'Sleep',
        value: '85',
        unit: '%',
        percentage: 85,
        icon: Icons.bedtime,
        details: 'Update: 1s ago',
      ),
      HealthMetric(
        title: 'Steps Count',
        value: '3,500',
        unit: 'steps',
        percentage: 70,
        icon: Icons.directions_walk,
        details: 'Update: 1s ago',
      ),
      HealthMetric(
        title: 'Fatigue',
        value: '3',
        unit: '/10',
        percentage: 30,
        icon: Icons.battery_alert,
        details: 'Update: 1s ago',
      ),
    ];

    int gridColumns = isMobile ? 2 : (isTablet ? 3 : 4);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridColumns,
        crossAxisSpacing: isMobile ? 12 : 16,
        mainAxisSpacing: isMobile ? 12 : 16,
        childAspectRatio: isMobile ? 1.1 : 1.2,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        return _buildMetricCard(metrics[index], isMobile);
      },
    );
  }

  Widget _buildMetricCard(HealthMetric metric, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: lightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with icon and title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  metric.title,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 13,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                metric.icon,
                size: isMobile ? 18 : 20,
                color: appColor,
              ),
            ],
          ),
          SizedBox(height: isMobile ? 15 : 18),
          
          // Value and Percentage Section
          if (metric.percentage != null) ...[
            // For metrics with percentage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metric.value,
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      metric.unit,
                      style: TextStyle(
                        fontSize: isMobile ? 10 : 11,
                        color: textGrey,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 10,
                    vertical: isMobile ? 4 : 6,
                  ),
                  decoration: BoxDecoration(
                    color: appColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${metric.percentage}%',
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.bold,
                      color: appColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 10 : 12),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (metric.percentage! / 100).clamp(0.0, 1.0),
                minHeight: isMobile ? 5 : 6,
                backgroundColor: lightGrey,
                valueColor: AlwaysStoppedAnimation<Color>(appColor),
              ),
            ),
            SizedBox(height: isMobile ? 10 : 12),
            Text(
              metric.details,
              style: TextStyle(
                fontSize: isMobile ? 10 : 11,
                color: textGrey,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 10),
            GestureDetector(
              onTap: () {},
              child: Text(
                'View Details →',
                style: TextStyle(
                  fontSize: isMobile ? 10 : 11,
                  color: appColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ] else ...[
            // For metrics without percentage (static values)
            Text(
              metric.value,
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              metric.unit,
              style: TextStyle(
                fontSize: isMobile ? 10 : 11,
                color: textGrey,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 10),
            Text(
              metric.details,
              style: TextStyle(
                fontSize: isMobile ? 10 : 11,
                color: textGrey,
              ),
            ),
            SizedBox(height: isMobile ? 8 : 10),
            GestureDetector(
              onTap: () {},
              child: Text(
                'View Details →',
                style: TextStyle(
                  fontSize: isMobile ? 10 : 11,
                  color: appColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: appColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.medical_services_outlined, 1),
              _buildNavItem(Icons.local_hospital_outlined, 2),
              _buildNavItem(Icons.settings, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Icon(
        icon,
        size: 28,
        color: _selectedIndex == index ? Colors.white : Colors.white70,
      ),
    );
  }
}

class HealthMetric {
  final String title;
  final String value;
  final String unit;
  final int? percentage;
  final IconData icon;
  final String details;

  HealthMetric({
    required this.title,
    required this.value,
    required this.unit,
    required this.percentage,
    required this.icon,
    required this.details,
  });
}
