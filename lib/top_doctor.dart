import 'package:flutter/material.dart';

class TopDoctorPage extends StatefulWidget {
  const TopDoctorPage({Key? key}) : super(key: key);

  @override
  State<TopDoctorPage> createState() => _TopDoctorPageState();
}

class _TopDoctorPageState extends State<TopDoctorPage> {
  // List of doctors data
  final List<DoctorModel> doctors = [
    DoctorModel(
      name: 'Dr. Marcus Horizon',
      specialty: 'Cardiologist',
      rating: 4.7,
      distance: '800m away',
      image: 'assets/D1.png',
    ),
    DoctorModel(
      name: 'Dr. Maria Elena',
      specialty: 'Psychologist',
      rating: 4.7,
      distance: '800m away',
      image: 'assets/D2.png',
    ),
    DoctorModel(
      name: 'Dr. Stefi Jessi',
      specialty: 'Orthopedist',
      rating: 4.7,
      distance: '800m away',
      image: 'assets/D3.png',
    ),
    DoctorModel(
      name: 'Dr. Gerty Cori',
      specialty: 'Orthopedist',
      rating: 4.7,
      distance: '800m away',
      image: 'assets/D4.png',
    ),
    DoctorModel(
      name: 'Dr. Diandra',
      specialty: 'Orthopedist',
      rating: 4.7,
      distance: '800m away',
      image: 'assets/D5.png',
    ),
  ];

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
            // Header with back button, title, and menu icon
            _buildHeader(context, isMobile),
            // Doctors list
            Expanded(
              child: _buildDoctorsList(isMobile, isTablet),
            ),
          ],
        ),
      ),
    );
  }

  // Header widget
  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : 24.0,
        vertical: isMobile ? 12.0 : 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: isMobile ? 20 : 24,
              color: Colors.black,
            ),
          ),
          // Title
          Text(
            'Top Doctor',
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          // Menu icon
          Icon(
            Icons.more_vert,
            size: isMobile ? 20 : 24,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  // Doctors list widget
  Widget _buildDoctorsList(bool isMobile, bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : isTablet ? 24.0 : 32.0,
        vertical: isMobile ? 12.0 : 16.0,
      ),
      child: isTablet
          ? _buildGridView()
          : Column(
              children: List.generate(
                doctors.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 12.0 : 16.0),
                  child: _buildDoctorCard(doctors[index], isMobile),
                ),
              ),
            ),
    );
  }

  // Grid view for tablet/desktop
  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return _buildDoctorCard(doctors[index], false);
      },
    );
  }

  // Individual doctor card
  Widget _buildDoctorCard(DoctorModel doctor, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor image and info row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: isMobile ? 100 : 80,
                  height: isMobile ? 100 : 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    doctor.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: isMobile ? 32 : 16),
              // Doctor details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor name
                    Text(
                      doctor.name,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isMobile ? 4 : 6),
                    // Doctor specialty
                    Text(
                      doctor.specialty,
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isMobile ? 6 : 10),
                    // Rating and Distance row
                    Wrap(
                      spacing: isMobile ? 8 : 12,
                      runSpacing: 4,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: isMobile ? 14 : 16,
                              color: const Color(0xFF00BFA5),
                            ),
                            SizedBox(width: isMobile ? 4 : 6),
                            Text(
                              doctor.rating.toString(),
                              style: TextStyle(
                                fontSize: isMobile ? 11 : 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: isMobile ? 14 : 16,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: isMobile ? 2 : 6),
                            Flexible(
                              child: Text(
                                doctor.distance,
                                style: TextStyle(
                                  fontSize: isMobile ? 11 : 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
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
    );
  }
}

// Doctor model
class DoctorModel {
  final String name;
  final String specialty;
  final double rating;
  final String distance;
  final String image;

  DoctorModel({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.distance,
    required this.image,
  });
}
