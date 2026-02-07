import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:symtom_checker/Iot.dart';
import 'package:symtom_checker/Ocr%20intoduction.dart';
import 'package:symtom_checker/ambulance.dart';
import 'package:symtom_checker/articles.dart';
import 'package:symtom_checker/article_model.dart';
import 'package:symtom_checker/artcile_expand.dart';
import 'package:symtom_checker/chatscreen.dart';
import 'package:symtom_checker/doctordetail.dart';
import 'package:symtom_checker/emergency_contact_page.dart';
import 'package:symtom_checker/finddoctor.dart';
import 'package:symtom_checker/health%20monitotring%201.dart';
import 'package:symtom_checker/help.dart';
import 'package:symtom_checker/insurance1.dart';
import 'package:symtom_checker/medication%20remainder.dart';
import 'package:symtom_checker/message.dart';
import 'package:symtom_checker/nearby_hospital.dart';
import 'package:symtom_checker/notification.dart';
import 'package:symtom_checker/pill%20remainder.dart';
import 'package:symtom_checker/profile.dart';
import 'package:symtom_checker/schedule.dart';
import 'package:symtom_checker/top_doctor.dart';
import 'package:symtom_checker/language/app_state.dart';
import 'package:symtom_checker/language/app_strings.dart';

void main() {
  runApp(const MyApp());
}

final lang = AppState.selectedLanguage;
final strings = AppStrings.data[lang]!;

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
    'name': 'Dr. Mihael Devis',
    'specialty_key': 'cardiologist',
    'rating': '4.7',
    'distance': '800',
    'distance_unit': 'm',
    'image': 'assets/D14.png',
  },
  {
    'name': 'Dr. Ravi Shankar',
    'specialty_key': 'psychologist',
    'rating': '4.0',
    'distance': '1.3',
    'distance_unit': 'km',
    'image': 'assets/D10.png',
  },
  {
    'name': 'Dr. Ananya Sharma',
    'specialty_key': 'orthopedist',
    'rating': '4.8',
    'distance': '25',
    'distance_unit': 'm',
    'image': 'assets/D9.png',
  },
  {
    'name': 'Dr. Arun Singh',
    'specialty_key': 'neurologist',
    'rating': '4.6',
    'distance': '2',
    'distance_unit': 'km',
    'image': 'assets/D4.png',
  },
  {
    'name': 'Dr. Priya Sharma',
    'specialty_key': 'dermatologist',
    'rating': '4.9',
    'distance': '1.5',
    'distance_unit': 'km',
    'image': 'assets/D5.png',
  },
  {
    'name': 'Dr. Rajesh Kumar',
    'specialty_key': 'pediatrician',
    'rating': '4.5',
    'distance': '3',
    'distance_unit': 'km',
    'image': 'assets/D3.png',
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

  void _openArticle(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleExpandPage(article: article),
      ),
    );
  }

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
                    /* Navigator.pop(context);
                    // Call ambulance (you can change the number as needed)
                    final Uri phoneUri = Uri(scheme: 'tel', path: '108');
                    if (await canLaunchUrl(phoneUri)) {
                      await launchUrl(phoneUri);
                    }*/
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
                  onPressed: () {},
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
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final healthArticles = [
      const Article(
        image: 'assets/R3.png',
        category: 'Skin Care',
        title:
            'Beauty Tips For Face: 10 Dos and Don\'ts for Naturally Beautiful Skin',
        date: 'Jun 8, 2021',
        readTime: '6 min read',
        content:
            'A balanced routine matters more than fancy products. This article outlines gentle cleansing, hydration, and sun protection habits along with common mistakes that can irritate skin.\n\n'
            'A consistent skincare routine starts with understanding your skin type and keeping things simple. Using a mild cleanser twice a day helps remove dirt, oil and pollutants without stripping the skin’s natural barrier. Hydration is equally important applying a suitable moisturizer locks in moisture, supports skin repair and keeps the skin soft and resilient. Sunscreen should be a daily habit, even on cloudy days, as regular sun exposure is one of the leading causes of premature aging and uneven skin tone.',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 26),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings['hello']!,
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationPage(),
                            ),
                          );
                        },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1FA59E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 18,
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22.5),
                          ),
                          child: Icon(
                            FontAwesomeIcons.robot,
                            color: Color(0xFF1FA59E),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            strings['discover_chat']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
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
                            size: 18,
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
              child: Text(
                strings['our_features']!,
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
                          label: strings['symptom_checker']!,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _FeatureCard(
                          icon:
                              FontAwesomeIcons.stethoscope, // Teleconsultation
                          label: strings['teleconsultation']!,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FindDoctorsPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _FeatureCard(
                          icon: FontAwesomeIcons
                              .shieldHeart, // Insurance Assistance
                          label: strings['insurance_assistance']!,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Insurance1Page(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _FeatureCard(
                          icon:
                              FontAwesomeIcons.heartPulse, // Health Monitoring
                          label: strings['health_monitoring']!,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HealthMonitoringPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _FeatureCard(
                          icon: FontAwesomeIcons.pills, // Medication Reminders
                          label: strings['medication_reminders']!,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MedicationReminderScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _FeatureCard(
                          icon:
                              FontAwesomeIcons.fileMedical, // Scan Your Report
                          label: strings['scan_report']!,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OcrIntroductionScreen(),
                              ),
                            );
                          },
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
              child: Text(
                strings['find_solution']!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: strings['search_hint']!,

                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1FA59E)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 217, 218, 217),
                    ),
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
                    label: strings['doctor']!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FindDoctorsPage(),
                        ),
                      );
                    },
                  ),

                  _ServiceIcon(
                    icon: FontAwesomeIcons.handHoldingMedical,
                    label: strings['quick_help']!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpPage()),
                      );
                    },
                  ),

                  _ServiceIcon(
                    icon: FontAwesomeIcons.hospital, // Hospital
                    label: strings['hospital']!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NearbyHospital(),
                        ),
                      );
                    },
                  ),

                  _ServiceIcon(
                    icon: FontAwesomeIcons.truckMedical, // Ambulance
                    label: strings['ambulance']!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AmbulancePage(),
                        ),
                      );
                    },
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
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              strings['family_health_title']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => HelpPage()),
                                );
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
                              child: Text(
                                strings['learn_more']!,
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

                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/D2.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
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
                  Text(
                    strings['top_doctor']!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopDoctorPage(),
                        ),
                      );
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
                    child: Text(
                      strings['see_all']!,
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
                            specialty: strings[allDoctors[i]['specialty_key']]!,
                            rating: allDoctors[i]['rating']!,
                            distance:
                                '${allDoctors[i]['distance']}${strings[allDoctors[i]['distance_unit']]!} ${strings['away']}',
                            imagePath: allDoctors[i]['image']!,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDetailPage(
                                    doctorName: allDoctors[i]['name']!,
                                    speciality:
                                        strings[allDoctors[i]['specialty_key']]!,
                                    rating: double.parse(
                                      allDoctors[i]['rating']!,
                                    ),
                                    distanceText:
                                        '${allDoctors[i]['distance']}${strings[allDoctors[i]['distance_unit']]!} ${strings['away']}',
                                    photoUrl: allDoctors[i]['image']!,
                                  ),
                                ),
                              );
                            },
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
                  Text(
                    strings['health_article']!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ArticlesPage()),
                      );
                      // See all pressed action
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Remove default padding
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      strings['see_all']!,
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
            // Health Article List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: healthArticles.length,
                itemBuilder: (context, index) {
                  return _buildHealthArticleCard(healthArticles[index]);
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            // Phone button - show emergency popup
            _showEmergencyPopup();
            return;
          }

          if (_selectedIndex == index) return; // prevent re-push

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
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _selectedIndex == 0
                    ? Color(0xFF1FA59E)
                    : Colors.transparent,
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
                color: _selectedIndex == 1
                    ? Color(0xFF1FA59E)
                    : Colors.transparent,
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
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _selectedIndex == 3
                    ? Color(0xFF1FA59E)
                    : Colors.transparent,
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
                color: _selectedIndex == 4
                    ? Color(0xFF1FA59E)
                    : Colors.transparent,
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

  Widget _buildHealthArticleCard(Article article) {
    return InkWell(
      onTap: () => _openArticle(article),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child: Image.asset(
                  article.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${article.date} • ${article.readTime}',
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark_border,
                color: Color(0xFF1FA59E),
                size: 20,
              ),
            ),
          ],
        ),
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
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1FA59E), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: const Color(0xFF1FA59E), size: 32),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF1FA59E),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
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
              ClipOval(
                child: Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[200],
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
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
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                distance,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
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
