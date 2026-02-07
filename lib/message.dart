import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:symtom_checker/chatdoctor.dart';
import 'package:symtom_checker/emergency_contact_page.dart';
import 'package:symtom_checker/homepage.dart';
import 'package:symtom_checker/profile.dart';
import 'package:symtom_checker/schedule.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  int _selectedTab = 0;
  int _selectedBottomNav = 1;
  int _selectedIndex = 1; // Schedule tab active

  // Method to show emergency popup
  void _showEmergencyPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Emergency Services',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ambulance Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                  /*  Navigator.pop(context);
                    // Call ambulance (you can change the number as needed)
                    final Uri phoneUri = Uri(scheme: 'tel', path: '108');
                    if (await canLaunchUrl(phoneUri)) {
                      await launchUrl(phoneUri);
                    } */
                  },
                  icon: Icon(FontAwesomeIcons.ambulance, size: 20),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Call Ambulance',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1FA59E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              // Emergency Contact Person Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    
                  },
                  icon: Icon(FontAwesomeIcons.userDoctor, size: 20),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Emergency Contact Person',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1FA59E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  final List<MessageData> messageList = [
    MessageData(
      name: 'Dr. Marcus Horizon',
      message: 'I don\'t have any fever, but headache...',
      time: '10:24',
      isRead: false,
      image: 'assets/D2.png',
    ),
    MessageData(
      name: 'Dr. Aiysa Hana',
      message: 'Hello, How can i help you?',
      time: '09:04',
      isRead: true,
      image: 'assets/D4.png',
    ),
    MessageData(
      name: 'Dr. Maria Elena',
      message: 'Do you have fever?',
      time: '08:57',
      isRead: true,
      image: 'assets/D6.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 15 : 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Message',
                    style: TextStyle(
                      fontSize: isMobile ? 26 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(isMobile ? 4 : 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.grey.shade600,
                        size: isMobile ? 22 : 24,
                      ),
                      padding: EdgeInsets.zero, // keeps size tight
                      constraints:
                          const BoxConstraints(), // prevents extra space
                      splashRadius: 22,
                    ),
                  ),
                ],
              ),
            ),
            // Tabs
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : 24.0,
                vertical: 2.0,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                /*  children: [
                    _buildTab(
                      label: 'All',
                      index: 0,
                      isActive: _selectedTab == 0,
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    _buildTab(
                      label: 'Group',
                      index: 1,
                      isActive: _selectedTab == 1,
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    _buildTab(
                      label: 'Private',
                      index: 2,
                      isActive: _selectedTab == 2,
                    ),
                  ], */
                ),
              ),
            ),

            // Messages List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: isMobile ? 12 : 16,
                ),
                itemCount: messageList.length,
               itemBuilder: (context, index) {
  return Column(
    children: [
      _buildMessageTile(messageList[index], isMobile),
      const SizedBox(height: 12), // ✅ space between messages
    ],
  );
},

              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          
        },
        backgroundColor: const Color(0xFF1ABFB8),
        child: const FaIcon(
          FontAwesomeIcons.commentDots,
          color: Colors.white,
          size: 25,
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTab({
    required String label,
    required int index,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1FA59E) : const Color(0xFFEBEBEB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF666666),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageTile(MessageData message, bool isMobile) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 12 : 16),
      child: InkWell(
        onTap: () {

          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDoctorScreen(),
                      ),
                    );
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Profile Picture
            Container(
              width: isMobile ? 56 : 56,
              height: isMobile ? 56 : 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  message.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.person,
                        size: isMobile ? 24 : 28,
                        color: Colors.grey.shade600,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: isMobile ? 12 : 16),
            // Message Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.name,
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: isMobile ? 4 : 6),
                  Text(
                    message.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isMobile ? 13 : 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: isMobile ? 12 : 16),
            // Time and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: isMobile ? 11 : 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: isMobile ? 6 : 8),
                if (message.isRead)
                  Icon(
                    Icons.done_all,
                    size: isMobile ? 14 : 16,
                    color: Colors.grey.shade400,
                  )
                else
                  Container(
                    width: isMobile ? 10 : 10,
                    height: isMobile ? 10 : 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1ABFB8),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,

      onTap: (index) {
        if (index == 2) {
          // Phone button - show emergency popup
          _showEmergencyPopup();
          return;
        }

        if (_selectedIndex == index) return;

        setState(() {
          _selectedIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HealthcareHomePage()),
            );
            break;

          case 1:
            break;

          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SchedulePage()),
            );
            break;

          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
            break;
        }
      },

      items: [
        BottomNavigationBarItem(
          icon: _navIcon(FontAwesomeIcons.home, 0),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _navIcon(FontAwesomeIcons.envelope, 1),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _selectedIndex == 2
                    ? const Color(0xFF1FA59E)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 📞 Tilted call icon (TOP)
                  Positioned(
                    top: 8,
                    child: Transform.rotate(
                      angle: 2.4, // 👈 tilt here
                      child: Icon(
                        FontAwesomeIcons.phone,
                        size: 28,
                        color: _selectedIndex == 2 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),

                  // 🔴 e symbol (BOTTOM)
                  Positioned(
                    bottom: -12,
                    child: Text(
                      'e',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 39,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          ),
        BottomNavigationBarItem(
          icon: _navIcon(FontAwesomeIcons.calendarAlt, 3),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _navIcon(FontAwesomeIcons.user, 4),
          label: '',
        ),
      ],
    );
  }

  Widget _navIcon(IconData icon, int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _selectedIndex == index
            ? const Color(0xFF1FA59E)
            : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: _selectedIndex == index ? Colors.white : Colors.grey,
        size: 24,
      ),
    );
  }
}

class MessageData {
  final String name;
  final String message;
  final String time;
  final bool isRead;
  final String image;

  MessageData({
    required this.name,
    required this.message,
    required this.time,
    required this.isRead,
    required this.image,
  });
}
