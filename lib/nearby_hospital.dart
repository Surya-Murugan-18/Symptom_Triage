import 'package:flutter/material.dart';

const Color appColor = Color(0xFF199A8E);
const Color titleColor = Colors.black;
const Color backgroundColor = Colors.white;

class NearbyHospital extends StatelessWidget {
  const NearbyHospital({Key? key}) : super(key: key);

  static final List<HospitalData> hospitals = [
    HospitalData(
      name: 'Hopkins Hospital',
      location: 'Baltimore, USA',
      rating: '5.0 (6K)',
      imageUrl: 'assets/clinic1.jpg',
    ),
    HospitalData(
      name: 'The Mayo Clinic',
      location: 'Rochester, USA',
      rating: '5.0 (5K)',
      imageUrl: 'assets/clinic2.jpg',
    ),
    HospitalData(
      name: 'Cleveland Clinic',
      location: 'Cleveland, Abu Dhabi',
      rating: '5.0 (8K)',
      imageUrl: 'assets/clinic1.jpg',
    ),
    HospitalData(
      name: 'Medi Hope Hospital',
      location: 'Dhaka, Bangladesh',
      rating: '5.0 (2K)',
      imageUrl: 'assets/clinic2.jpg',
    ),
    HospitalData(
      name: 'Charité',
      location: 'Berlin, Abu Dhabi',
      rating: '5.0 (6K)',
      imageUrl: 'assets/clinic1.jpg',
    ),
    HospitalData(
      name: 'Toronto General Hospital',
      location: 'Toronto',
      rating: '5.0 (3K)',
      imageUrl: 'assets/clinic2.jpg',
    ),
    HospitalData(
      name: 'The Mayo Clinic',
      location: 'Rochester, Minnesota',
      rating: '5.0 (5K)',
      imageUrl: 'assets/hospital7.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final horizontalPadding = isSmallScreen ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: titleColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Nearby Hospitals',
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Hospital List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
              itemCount: hospitals.length,
              addRepaintBoundaries: true,
              itemBuilder: (context, index) {
                return _buildHospitalCard(hospitals[index], isSmallScreen, index, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildHospitalCard(HospitalData hospital, bool isSmallScreen, int hospitalIndex, BuildContext context) {
    final imageSize = isSmallScreen ? 80.0 : 100.0;
    final cardHeight = isSmallScreen ? 120.0 : 140.0;

    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      height: cardHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Hospital Image
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 18.0 : 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: imageSize,
                height: imageSize,
                color: _getHospitalImageColor(hospitalIndex),
                child: Image.asset(
                  hospital.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.local_hospital,
                        color: Colors.white,
                        size: isSmallScreen ? 30 : 40,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Hospital Info
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 8.0 : 12.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hospital.name,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 16,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isSmallScreen ? 4 : 6),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: isSmallScreen ? 12 : 14, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          hospital.location,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 4 : 6),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, size: isSmallScreen ? 12 : 14, color: appColor),
                      SizedBox(width: 4),
                      Text(
                        hospital.rating,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Call Button
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 28.0 : 12.0),
            child: FloatingActionButton(
              mini: isSmallScreen,
              backgroundColor: appColor,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Calling ${hospital.name}...'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Icon(
                Icons.phone,
                color: backgroundColor,
                size: isSmallScreen ? 20 : 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Color _getHospitalImageColor(int index) {
    final colors = [
      Colors.blue[100],
      Colors.purple[100],
      Colors.green[100],
      Colors.pink[100],
      Colors.blue[50],
      Colors.cyan[100],
      Colors.purple[100],
    ];
    return colors[index % colors.length] ?? Colors.grey[100]!;
  }
}

class HospitalData {
  final String name;
  final String location;
  final String rating;
  final String imageUrl;

  HospitalData({
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
  });
}
