import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HealthcareHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Sample data for doctors
const List<Map<String, String>> allDoctors = [
  {
    'name': 'Dr. Surya M',
    'specialty': 'Cardiologist',
    'rating': '4.7',
    'distance': '800m away',
    'image': 'assets/logo.png',
  },
  {
    'name': 'Dr. Madhan A',
    'specialty': 'Psychologist',
    'rating': '4.0',
    'distance': '1.3km away',
    'image': 'assets/logo.png',
  },
  {
    'name': 'Dr. Kishore kur',
    'specialty': 'Orthopedist',
    'rating': '4.8',
    'distance': '25m away',
    'image': 'assets/logo.png',
  },
  {
    'name': 'Dr. Arun Singh',
    'specialty': 'Neurologist',
    'rating': '4.6',
    'distance': '2km away',
    'image': 'assets/logo.png',
  },
  {
    'name': 'Dr. Priya Sharma',
    'specialty': 'Dermatologist',
    'rating': '4.9',
    'distance': '1.5km away',
    'image': 'assets/logo.png',
  },
  {
    'name': 'Dr. Rajesh Kumar',
    'specialty': 'Pediatrician',
    'rating': '4.5',
    'distance': '3km away',
    'image': 'assets/logo.png',
  },
];

class HealthcareHomePage extends StatefulWidget {
  const HealthcareHomePage({Key? key}) : super(key: key);

  @override
  State<HealthcareHomePage> createState() => _HealthcareHomePageState();
}

class _HealthcareHomePageState extends State<HealthcareHomePage> {
  int _selectedIndex = 0;
  bool _showAllDoctors = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Surya M!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Healthcare Chat Banner
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1FA59E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            FontAwesomeIcons.robot,
                            color: Color(0xFF1FA59E),
                            size: 24,
                          ),
                        ),
                        const Text(
                          'Discover Our Healthcare Chat Assistant',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            FontAwesomeIcons.anglesRight,
                            color: Color(0xFF1FA59E),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Our Features
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Our Features',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            // Features Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _FeatureCard(
                          icon:
                              FontAwesomeIcons.clipboardList, // Symptom Checker
                          label: 'Symptom\nChecker',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _FeatureCard(
                          icon:
                              FontAwesomeIcons.stethoscope, // Teleconsultation
                          label: 'Teleconsultation',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _FeatureCard(
                          icon: FontAwesomeIcons
                              .shieldHeart, // Insurance Assistance
                          label: 'Insurance\nAssistance',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _FeatureCard(
                          icon:
                              FontAwesomeIcons.heartPulse, // Health Monitoring
                          label: 'Health\nMonitoring',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _FeatureCard(
                          icon: FontAwesomeIcons.pills, // Medication Reminders
                          label: 'Medication\nReminders',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _FeatureCard(
                          icon:
                              FontAwesomeIcons.fileMedical, // Scan Your Report
                          label: 'Scan Your\nReport',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Find your desire health solution
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Find your desired health solution',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search doctor, drugs, articles...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1FA59E)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 217, 218, 217)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF1FA59E),
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Service Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ServiceIcon(
                    icon: FontAwesomeIcons.stethoscope, // Doctor
                    label: 'Doctor',
                    onPressed: () {},
                  ),

                  _ServiceIcon(
                    icon:
                        FontAwesomeIcons.prescriptionBottleMedical, // Pharmacy
                    label: 'Pharmacy',
                    onPressed: () {},
                  ),

                  _ServiceIcon(
                    icon: FontAwesomeIcons.hospital, // Hospital
                    label: 'Hospital',
                    onPressed: () {},
                  ),

                  _ServiceIcon(
                    icon: FontAwesomeIcons.truckMedical, // Ambulance
                    label: 'Ambulance',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            // Family Health Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F7F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ), // 👈 space moved here
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Early protection for\nyour family health',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            TextButton(
                              onPressed: () {
                                // TODO: Learn more action
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFF1FA59E),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Learn more',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            // Top Doctor
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Doctor',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showAllDoctors = !_showAllDoctors;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Remove extra padding
                      minimumSize: const Size(
                        0,
                        0,
                      ), // Optional: shrink button to text size
                      tapTargetSize:
                          MaterialTapTargetSize.shrinkWrap, // Optional
                    ),
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: Color(0xFF1FA59E),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            // Doctor Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (
                      int i = 0;
                      i < (_showAllDoctors ? allDoctors.length : 3);
                      i++
                    )
                      Row(
                        children: [
                          _DoctorCard(
                            name: allDoctors[i]['name']!,
                            specialty: allDoctors[i]['specialty']!,
                            rating: allDoctors[i]['rating']!,
                            distance: allDoctors[i]['distance']!,
                            imagePath: allDoctors[i]['image']!,
                            onPressed: () {},
                          ),
                          if (i < (_showAllDoctors ? allDoctors.length : 3) - 1)
                            const SizedBox(width: 12),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Health Article
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Health article',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // See all pressed action
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Remove default padding
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: Color(0xFF1FA59E),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            // Article Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  // Card pressed action
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'The 25 Healthiest Fruits You Can Eat, According to a Nutritionist',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Jun 10, 2021   • 5 min read',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Bookmark pressed action
                        },
                        icon: const Icon(
                          Icons.bookmark_border,
                          color: Color(0xFF1FA59E),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
      // Bottom Navigation
    

bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  currentIndex: _selectedIndex,
  onTap: (index) {
    setState(() {
      _selectedIndex = index;
    });
  },
  items: [
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _selectedIndex == 0 ? Color(0xFF1FA59E) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          FontAwesomeIcons.home,
          color: _selectedIndex == 0 ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _selectedIndex == 1 ? Color(0xFF1FA59E) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          FontAwesomeIcons.envelope,
          color: _selectedIndex == 1 ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _selectedIndex == 2 ? Color(0xFF1FA59E) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          FontAwesomeIcons.phone,
          color: _selectedIndex == 2 ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _selectedIndex == 3 ? Color(0xFF1FA59E) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          FontAwesomeIcons.calendarAlt,
          color: _selectedIndex == 3 ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _selectedIndex == 4 ? Color(0xFF1FA59E) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          FontAwesomeIcons.user,
          color: _selectedIndex == 4 ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
      label: '',
    ),
  ],
  showSelectedLabels: false,
  showUnselectedLabels: false,
),


    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _FeatureCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: AspectRatio(
          aspectRatio: 1.2,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF1FA59E), width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color(0xFF1FA59E), size: 36),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1FA59E),
                    fontWeight: FontWeight.w600,
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

class _ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ServiceIcon({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: const Color(0xFF1FA59E), size: 28),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF1FA59E)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String rating;
  final String distance;
  final String imagePath;
  final VoidCallback onPressed;

  const _DoctorCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.distance,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16), // for outline tap effect
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 198, 198, 198),
            ), // outline color
            borderRadius: BorderRadius.circular(16), // rounded corners
          ),
          child: Column(
            children: [
              // Circular profile image with no background color
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent, // removed grey background
                backgroundImage: AssetImage(imagePath),
              ),
              const SizedBox(height: 10),
              // Doctor info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Rating pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1FA59E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              rating,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Distance with location icon
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            distance,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
