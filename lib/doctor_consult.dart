import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DoctorConsult extends StatefulWidget {
  const DoctorConsult({Key? key}) : super(key: key);

  @override
  State<DoctorConsult> createState() => _DoctorConsultState();
}

class _DoctorConsultState extends State<DoctorConsult> {
  int _selectedIndex = 2; // Consults tab
  String _selectedFilter = 'Pending';
  final Color _primaryColor = const Color(0xFF199A8E);

  // Consultation data
  final List<Map<String, dynamic>> _consultations = [
    {
      'name': 'Sarah Johnson',
      'initials': 'SJ',
      'date': 'Jan 15, 2024',
      'time': '10:30 AM',
      'category': 'General',
      'status': 'Pending',
    },
    {
      'name': 'Raj Patel',
      'initials': 'RP',
      'date': 'Jan 15, 2024',
      'time': '11:30 AM',
      'category': 'Cardiology',
      'status': 'Pending',
    },
    {
      'name': 'Priya Sharma',
      'initials': 'PS',
      'date': 'Jan 15, 2024',
      'time': '2:00 PM',
      'category': 'Dermatology',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
              child: Row(
                children: [
                  // Back Arrow
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  // Center Title
                  Expanded(
                    child: Center(
                      child: Text(
                        'Consultations',
                        style: TextStyle(
                          fontSize: isDesktop ? 28 : 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  // Right spacer to balance center alignment
                  const SizedBox(width: 48),
                ],
              ),
            ),

            Divider(color: Colors.grey[300], height: 1, thickness: 1),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Filter Buttons
                      SizedBox(
                        height: isDesktop ? 50 : 45,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildFilterButton('Pending', 3, isDesktop),
                            const SizedBox(width: 12),
                            _buildFilterButton('Accepted', 5, isDesktop),
                            const SizedBox(width: 12),
                            _buildFilterButton('Completed', 28, isDesktop),
                            const SizedBox(width: 12),
                            _buildFilterButton('Rejected', 2, isDesktop),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Consultations List
                      _buildConsultationsList(isDesktop),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFilterButton(String label, int count, bool isDesktop) {
    final isSelected = _selectedFilter == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 18.0 : 14.0,
          vertical: isDesktop ? 12.0 : 8.0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? _primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: isDesktop ? 15 : 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.3)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: isDesktop ? 13 : 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsultationsList(bool isDesktop) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _consultations.length,
      itemBuilder: (context, index) {
        final consultation = _consultations[index];
        return _buildConsultationCard(consultation, isDesktop);
      },
    );
  }

  Widget _buildConsultationCard(
    Map<String, dynamic> consultation,
    bool isDesktop,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(isDesktop ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: isDesktop ? 60 : 50,
            height: isDesktop ? 60 : 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                consultation['initials'],
                style: TextStyle(
                  fontSize: isDesktop ? 20 : 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Consultation Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  consultation['name'],
                  style: TextStyle(
                    fontSize: isDesktop ? 17 : 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: isDesktop ? 14 : 13,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      consultation['date'],
                      style: TextStyle(
                        fontSize: isDesktop ? 13 : 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '•',
                      style: TextStyle(
                        fontSize: isDesktop ? 13 : 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      consultation['time'],
                      style: TextStyle(
                        fontSize: isDesktop ? 13 : 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    consultation['category'],
                    style: TextStyle(
                      fontSize: isDesktop ? 12 : 11,
                      fontWeight: FontWeight.w500,
                      color: _primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 14 : 12,
              vertical: isDesktop ? 8 : 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8DC), // Light yellow for Pending
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              consultation['status'],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFFD4A025), // Darker yellow for text
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(FontAwesomeIcons.house, 'Home', 0),
          _buildNavItem(FontAwesomeIcons.envelope, 'Messages', 1),
          _buildNavItem(LucideIcons.messageSquare, 'Consults', 2),
          _buildNavItem(FontAwesomeIcons.bell, 'Notifications', 3),
          _buildNavItem(FontAwesomeIcons.user, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected)
            Container(
              width: 28,
              height: 4,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: _primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          Icon(
            icon,
            color: isSelected ? _primaryColor : Colors.grey.shade400,
            size: 26,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? _primaryColor : Colors.grey.shade400,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
