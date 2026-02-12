import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:symtom_checker/doctor-Profile.dart';
import 'package:symtom_checker/doctor_consult.dart';
import 'package:symtom_checker/doctor_dashboard.dart';
import 'package:symtom_checker/doctor_messages_list.dart';

class DoctorNotifications extends StatefulWidget {
  const DoctorNotifications({Key? key}) : super(key: key);

  @override
  State<DoctorNotifications> createState() => _DoctorNotificationsState();
}

class _DoctorNotificationsState extends State<DoctorNotifications> {
  int _selectedIndex = 3; // Notifications tab is selected
  final Color _primaryColor = const Color(0xFF199A8E);
  String _selectedFilter = 'All';

  // Sample notification data
  List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'type': 'Bookings',
      'icon': FontAwesomeIcons.calendar,
      'iconBgColor': const Color(0xFF199A8E).withOpacity(0.1),
      'iconColor': const Color(0xFF199A8E),
      'title': 'New Booking Request',
      'message': 'Sarah Johnson requested a consultation for Jan 15 at 10:30 AM.',
      'time': '2 mins ago',
      'isRead': false,
    },
    {
      'id': 2,
      'type': 'Payments',
      'icon': FontAwesomeIcons.creditCard,
      'iconBgColor': const Color(0xFFFFF4E6),
      'iconColor': const Color(0xFFFFA726),
      'title': 'Payment Received',
      'message': 'Payment of ₹500 received from Raj Patel.',
      'time': '1 hour ago',
      'isRead': false,
    },
    {
      'id': 3,
      'type': 'Consultations',
      'icon': FontAwesomeIcons.video,
      'iconBgColor': const Color(0xFFE3F2FD),
      'iconColor': const Color(0xFF2196F3),
      'title': 'Upcoming Consultation',
      'message': 'Video consultation with Priya Sharma starts in 15 minutes.',
      'time': '15 min ago',
      'isRead': true,
    },
    {
      'id': 4,
      'type': 'Bookings',
      'icon': FontAwesomeIcons.circleXmark,
      'iconBgColor': const Color(0xFFFFEBEE),
      'iconColor': const Color(0xFFE53935),
      'title': 'Appointment Cancelled',
      'message': 'Amit Kumar cancelled the appointment scheduled for Jan 16.',
      'time': '3 hours ago',
      'isRead': true,
    },
    {
      'id': 5,
      'type': 'Consultations',
      'icon': FontAwesomeIcons.clock,
      'iconBgColor': const Color(0xFFF3E5F5),
      'iconColor': const Color(0xFF9C27B0),
      'title': 'Follow-up Reminder',
      'message': 'Time to schedule a follow-up with Neha Gupta.',
      'time': 'Yesterday',
      'isRead': true,
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification['isRead'] = true;
      }
    });
  }

  List<Map<String, dynamic>> get filteredNotifications {
    if (_selectedFilter == 'All') {
      return notifications;
    }
    return notifications
        .where((notification) => notification['type'] == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.checkDouble,
                  color: _primaryColor,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  'Mark all read',
                  style: TextStyle(
                    color: _primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 24 : 16,
              vertical: 16,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Bookings'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Payments'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Consultations'),
                ],
              ),
            ),
          ),

          // Notifications List
          Expanded(
            child: filteredNotifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.bell,
                          size: 64,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No notifications',
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 24 : 16,
                    ),
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = filteredNotifications[index];
                      return _buildNotificationItem(notification);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? _primaryColor : Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: notification['iconBgColor'],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: FaIcon(
                notification['icon'],
                color: notification['iconColor'],
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification['title'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Text(
                          notification['time'],
                          style: TextStyle(
                            color: _primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (!notification['isRead']) ...[
                          const SizedBox(width: 6),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notification['message'],
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
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
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorDashboard()),
          );
            break;

          case 1:
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorMessagesList()),
          );
            break;

          case 2:
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DoctorConsult()),
          );
            break;

          case 3:
            Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorNotifications()),
          );
            break;

          case 4:
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorProfile()),
          );
            break;
        }
      },
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                color: isSelected ? _primaryColor : Colors.grey.shade400,
                size: 26,
              ),
              if (index == 3 && notifications.any((n) => !n['isRead']))
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
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
