import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/doctor_activetab.dart';
import 'package:symtom_checker/doctor_booking.dart';
import 'package:symtom_checker/doctor_calendar.dart';
import 'package:symtom_checker/doctor_completedtab.dart';
import 'package:symtom_checker/doctor_consult.dart';
import 'package:symtom_checker/doctor_statistics.dart';
import 'package:symtom_checker/doctordetail.dart';
import 'package:symtom_checker/doctordocuments.dart';
import 'package:symtom_checker/doctorsignin.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int _selectedIndex = 0;
  bool _isOnline = true;
  final Color _primaryColor = const Color(0xFF199A8E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          bool isDesktop = maxWidth > 800;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildHeader(isDesktop, maxWidth),
                    Positioned(
                      left: isDesktop ? (maxWidth - 800) / 2 + 20 : 20,
                      right: isDesktop ? (maxWidth - 800) / 2 + 20 : 20,
                      bottom: 40,
                      child: _buildStatsGrid(isDesktop),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? (maxWidth - 800) / 2 : 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 35),
                      _buildQuickActions(),
                      const SizedBox(height: 35),
                      _buildAppointmentsHeader(),
                      const SizedBox(height: 20),
                      _buildAppointmentsList(),
                      const SizedBox(height: 120), // Bottom spacing for Nav Bar
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader(bool isDesktop, double maxWidth) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      padding: EdgeInsets.only(
        top: 40,
        bottom: 335,
        left: isDesktop ? (maxWidth - 800) / 2 + 20 : 25,
        right: isDesktop ? (maxWidth - 800) / 2 + 20 : 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: Image.asset('assets/D10.png', fit: BoxFit.cover),
                ),
              ),

              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Dr. John Smith',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'General Physician',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          "Change Availability",
                          style: TextStyle(color: Colors.black),
                        ),
                        content: Text(
                          _isOnline ? "Go Offline?" : "Go Online?",
                          style: const TextStyle(color: Colors.black),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isOnline = !_isOnline;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Confirm",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },

                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Center(
                      child: FaIcon(
                        _isOnline
                            ? FontAwesomeIcons.toggleOn
                            : FontAwesomeIcons.toggleOff,
                        size: 22,
                        color: _isOnline
                            ? const Color(0xFF199A8E)
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _isOnline ? 'Online' : 'Offline',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _isOnline ? const Color(0xFF199A8E) : Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

Widget _buildStatsGrid(bool isDesktop) {
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    mainAxisSpacing: 15,
    crossAxisSpacing: 25,
    childAspectRatio: 1.8,
    children: [
      _buildStatCard(
        icon: FontAwesomeIcons.bell,
        value: '5',
        label: 'New Bookings',
        iconColor: const Color(0xFF4A90E2),
        bgColor: const Color(0xFFE3F2FD),
        onTap: () {
          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookingRequestsPage()),
                      );
        },
      ),
      _buildStatCard(
        icon: FontAwesomeIcons.video,
        value: '3',
        label: 'Active',
        iconColor: const Color(0xFF199A8E),
        bgColor: const Color(0xFFE0F2F1),
        onTap: () {
          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ActiveConsultationsPage()),
                      );
        },
      ),
      _buildStatCard(
        icon: FontAwesomeIcons.circleCheck,
        value: '28',
        label: 'Completed',
        iconColor: const Color(0xFF199A8E),
        bgColor: const Color(0xFFE0F2F1),
        onTap: () {
          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CompletedConsultationsPage()),
                      );
        },
      ),
      _buildStatCard(
       icon: LucideIcons.dollarSign, // replaced Lucide
        value: '2',
        label: 'Pending Pay',
        iconColor: const Color(0xFFFFA726),
        bgColor: const Color(0xFFFFF3E0),
        onTap: () {
          // Navigate to Pending Payments
        },
      ),
    ],
  );
}


Widget _buildStatCard({
  required IconData icon,
  required String value,
  required String label,
  required Color iconColor,
  required Color bgColor,
  required VoidCallback onTap, // 👈 add this
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}



  Widget _buildQuickActions() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Quick Actions',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 20),

      Row(
        children: [
          Expanded(
            child: _buildActionItem(
              FontAwesomeIcons.plus,
              'Create Slot',
              onTap: () {
                // Navigate to Create Slot screen
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionItem(
              FontAwesomeIcons.calendarDays,
              'Calendar',
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorCalendar()),
                      );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionItem(
              FontAwesomeIcons.chartSimple,
              'Statistics',
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorStatistics()),
                      );
              },
            ),
          ),
        ],
      ),
    ],
  );
}


  Widget _buildActionItem(
  IconData icon,
  String label, {
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: _primaryColor, size: 26),
            ),
            const SizedBox(height: 14),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  Widget _buildAppointmentsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Today\'s Appointments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Text(
                'View All',
                style: TextStyle(
                  color: _primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 4),
              Icon(LucideIcons.chevronRight, color: _primaryColor, size: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentsList() {
    return Column(
      children: [
        _buildAppointmentCard(
          name: 'Sarah Johnson',
          initials: 'SJ',
          time: '10:30 AM',
          type: 'General consultation',
        ),
        const SizedBox(height: 18),
        _buildAppointmentCard(
          name: 'Raj Patel',
          initials: 'RP',
          time: '11:30 AM',
          type: 'Follow-up',
        ),
      ],
    );
  }

  Widget _buildAppointmentCard({
    required String name,
    required String initials,
    required String time,
    required String type,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: TextStyle(
                color: Colors.blueGrey.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      LucideIcons.clock,
                      size: 15,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('•', style: TextStyle(color: Colors.grey.shade400)),
                    const SizedBox(width: 10),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Upcoming',
              style: TextStyle(
                color: _primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
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
            MaterialPageRoute(builder: (context) => const DoctorDetailPage()),
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
                builder: (context) => const DoctorSignIn()),
          );
          break;

        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorDocuments()),
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

}
