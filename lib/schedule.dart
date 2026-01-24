import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/homepage.dart';
import 'package:symtom_checker/message.dart';


class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _selectedTabIndex = 0;
  int _selectedIndex = 3; // Schedule tab active


  // Sample appointment data
  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      'doctorName': 'Dr. Marcus Horizon',
      'specialization': 'Cardiologist',
      'date': '26/06/2022',
      'time': '10:30 AM',
      'status': 'Confirmed',
      'imageUrl':
          'assets/D1.png', // Placeholder image
    },
    {
      'doctorName': 'Dr. Alysa Hana',
      'specialization': 'Psikeatr',
      'date': '28/06/2022',
      'time': '2:00 PM',
      'status': 'Confirmed',
      'imageUrl':
          'assets/D4.png', // Placeholder image
    },
  ];

  final List<Map<String, dynamic>> completedAppointments = [
    {
      'doctorName': 'Dr. John Smith',
      'specialization': 'General Practitioner',
      'date': '20/06/2022',
      'time': '9:00 AM',
      'status': 'Completed',
      'imageUrl':
          'assets/D6.jpg',
    },
  ];

  final List<Map<String, dynamic>> canceledAppointments = [
    {
      'doctorName': 'Dr. Emma Wilson',
      'specialization': 'Dermatologist',
      'date': '25/06/2022',
      'time': '11:00 AM',
      'status': 'Canceled',
      'imageUrl':
          'assets/D3.png',
    },
  ];

  List<Map<String, dynamic>> get displayedAppointments {
    switch (_selectedTabIndex) {
      case 0:
        return upcomingAppointments;
      case 1:
        return completedAppointments;
      case 2:
        return canceledAppointments;
      default:
        return upcomingAppointments;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet =
        MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : 24.0,
                vertical: isMobile ? 16.0 : 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Schedule',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 24 : 32,
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                 child: IconButton(
  icon: const Icon(
    Icons.notifications_none,
    color: Color(0xFF333333),
    size: 24,
  ),
  padding: EdgeInsets.zero, // keeps UI same
  constraints: const BoxConstraints(),
  onPressed: () {
   
    
  },
),

                  ),
                ],
              ),
            ),
            // Tab Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : 24.0,
                vertical: 12.0,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTab(
                      label: 'Upcoming',
                      index: 0,
                      isActive: _selectedTabIndex == 0,
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    _buildTab(
                      label: 'Completed',
                      index: 1,
                      isActive: _selectedTabIndex == 1,
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    _buildTab(
                      label: 'Canceled',
                      index: 2,
                      isActive: _selectedTabIndex == 2,
                    ),
                  ],
                ),
              ),
            ),
            // Appointments List
            Expanded(
              child: displayedAppointments.isEmpty
                  ? Center(
                      child: Text(
                        'No appointments found',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16.0 : 24.0,
                        vertical: 12.0,
                      ),
                      itemCount: displayedAppointments.length,
                      itemBuilder: (context, index) {
                        final appointment = displayedAppointments[index];
                        return _buildAppointmentCard(
                          appointment: appointment,
                          isMobile: isMobile,
                          isTablet: isTablet,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
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
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1FA59E) : const Color(0xFFEBEBEB),
          borderRadius: BorderRadius.circular(8),
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

  Widget _buildAppointmentCard({
    required Map<String, dynamic> appointment,
    required bool isMobile,
    required bool isTablet,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(isMobile ? 16.0 : 20.0),
     decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(
    color: Colors.grey.shade300, // ✅ grey outline
    width: 1,
  ),
  boxShadow: [
    BoxShadow(
      color: const Color(0xFFF5F5F5),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ],
),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Avatar
              CircleAvatar(
                radius: isMobile ? 30 : 40,
                backgroundColor: const Color(0xFFE0E0E0),
                backgroundImage:
                    Image.network(appointment['imageUrl']).image,
              ),
              SizedBox(width: isMobile ? 12 : 16),
              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment['doctorName'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 16 : 18,
                          ),
                    ),
                    SizedBox(height: isMobile ? 4 : 6),
                    Text(
                      appointment['specialization'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF999999),
                            fontSize: isMobile ? 12 : 14,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 16),
          // Date and Time Info
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: const Color(0xFF1ABC9C),
                size: 16,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                appointment['date'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: isMobile ? 14 : 14,
                      color: const Color(0xFF333333),
                    ),
              ),
              SizedBox(width: isMobile ? 12 : 16),
              const Icon(
                Icons.access_time,
                color: const Color(0xFF1ABC9C),
                size: 16,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                appointment['time'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: isMobile ? 14 : 14,
                      color: const Color(0xFF333333),
                    ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 248, 247),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  appointment['status'],
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: isMobile ? 12 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 16),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  label: 'Cancel',
                  backgroundColor: const Color(0xFFE0F4F3),
                  textColor:  Colors.black,
                  onPressed: () {
                   
                  },
                  isMobile: isMobile,
                ),
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Expanded(
                child: _buildActionButton(
                  label: 'Reschedule',
                  backgroundColor: const Color(0xFF1FA59E),
                  textColor: Colors.white,
                  onPressed: () {
                    
                  },
                  isMobile: isMobile,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
    required bool isMobile,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 20.0 : 20.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: isMobile ? 14 : 14,
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Message()),
          );
          break;

        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HealthcareHomePage()),
          );
          break;

        case 3:
          // Already on SchedulePage → do nothing
          break;

        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HealthcareHomePage()),
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
        icon: _navIcon(FontAwesomeIcons.phone, 2),
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
