import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'doctor_chat_detail.dart';
import 'doctor_dashboard.dart';
import 'doctor_consult.dart';
import 'doctor_notifications.dart';
import 'doctor-Profile.dart';

class DoctorMessagesList extends StatefulWidget {
  const DoctorMessagesList({Key? key}) : super(key: key);

  @override
  State<DoctorMessagesList> createState() => _DoctorMessagesListState();
}

class _DoctorMessagesListState extends State<DoctorMessagesList> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 1;
  final Color _primaryColor = const Color(0xFF199A8E);
  
  final List<MessageItem> messages = [
    MessageItem(
      name: 'Sarah Johnson',
      message: 'Thank you doctor, I will take the medicine as prescr...',
      time: '10:30 AM',
      isOnline: true,
      unreadCount: 2,
      initials: 'SJ',
      color: const Color(0xFF199A8E),
    ),
    MessageItem(
      name: 'Raj Patel',
      message: 'Can I reschedule my appointment for tomorrow?',
      time: 'Yesterday',
      isOnline: false,
      unreadCount: 1,
      initials: 'RP',
      color: const Color(0xFF199A8E),
    ),
    MessageItem(
      name: 'Priya Sharma',
      message: 'The pain has subsided significantly.',
      time: 'Yesterday',
      isOnline: true,
      unreadCount: 0,
      initials: 'PS',
      color: const Color(0xFF199A8E),
    ),
    MessageItem(
      name: 'Amit Kumar',
      message: 'Please find the attached report.',
      time: 'Jan 12',
      isOnline: false,
      unreadCount: 0,
      initials: 'AK',
      color: const Color(0xFF199A8E),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final maxWidth = isDesktop ? 600.0 : screenWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              // Header
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Messages',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search conversations...',
                      hintStyle: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF9E9E9E),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
              ),
              
              // Messages List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessageItem(messages[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildMessageItem(MessageItem message) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorChatDetail(
              name: message.name,
              initials: message.initials,
              isOnline: message.isOnline,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Avatar with initials
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: message.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      message.initials,
                      style: const TextStyle(
                        color: Color(0xFF199A8E),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (message.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            
            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        message.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: message.unreadCount > 0 
                              ? const Color(0xFF199A8E) 
                              : const Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.message,
                          style: TextStyle(
                            fontSize: 14,
                            color: message.unreadCount > 0 
                                ? Colors.black87 
                                : const Color(0xFF757575),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (message.unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF199A8E),
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Center(
                            child: Text(
                              '${message.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class MessageItem {
  final String name;
  final String message;
  final String time;
  final bool isOnline;
  final int unreadCount;
  final String initials;
  final Color color;

  MessageItem({
    required this.name,
    required this.message,
    required this.time,
    required this.isOnline,
    required this.unreadCount,
    required this.initials,
    required this.color,
  });
}
