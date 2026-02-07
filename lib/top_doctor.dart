import 'package:flutter/material.dart';
import 'package:symtom_checker/doctordetail.dart';

class TopDoctorPage extends StatefulWidget {
  final String? specialty;

  const TopDoctorPage({Key? key, this.specialty}) : super(key: key);

  @override
  State<TopDoctorPage> createState() => _TopDoctorPageState();
}

class _TopDoctorPageState extends State<TopDoctorPage> {
  // List of all doctors data
  final List<DoctorModel> allDoctors = [
    // Cardiologists (5 doctors)
    DoctorModel(
      name: 'Dr. Michael Davis',
      specialty: 'Cardiologist',
      rating: 4.7,
      distance: '800m away',
      image: 'assets/D14.png',
    ),
    DoctorModel(
      name: 'Dr. Arjun Sharma',
      specialty: 'Cardiologist',
      rating: 4.6,
      distance: '1.2km away',
      image: 'assets/D2.png',
    ),
    DoctorModel(
      name: 'Dr. Kavya Reddy',
      specialty: 'Cardiologist',
      rating: 4.8,
      distance: '2km away',
      image: 'assets/D3.png',
    ),
    DoctorModel(
      name: 'Dr. Marcus Horizon',
      specialty: 'Cardiologist',
      rating: 4.7,
      distance: '800m away',
      image: 'assets/D6.jpg',
    ),
    
    // Psychiatrist (5 doctors)
    DoctorModel(
      name: 'Dr. Maria Elena',
      specialty: 'Psychiatrist',
      rating: 4.7,
      distance: '800m away',
      image: 'assets/D4.png',
    ),
    DoctorModel(
      name: 'Dr. Sarah Miller',
      specialty: 'Psychiatrist',
      rating: 4.5,
      distance: '1.5km away',
      image: 'assets/D7.png',
    ),
    DoctorModel(
      name: 'Dr. Ravi Shankar',
      specialty: 'Psychiatrist',
      rating: 4.9,
      distance: '3km away',
      image: 'assets/D10.png',
    ),
    DoctorModel(
      name: 'Dr. Neha Verma',
      specialty: 'Psychiatrist',
      rating: 4.6,
      distance: '1.8km away',
      image: 'assets/D1.png',
    ),
    
    // Dentist (5 doctors)
    DoctorModel(
      name: 'Dr. Ananya Sharma',
      specialty: 'Dentist',
      rating: 4.6,
      distance: '500m away',
      image: 'assets/D9.png',
    ),
    DoctorModel(
      name: 'Dr. Vijay Kumar',
      specialty: 'Dentist',
      rating: 4.8,
      distance: '1km away',
      image: 'assets/D12.png',
    ),
    DoctorModel(
      name: 'Dr. Stevi Brown',
      specialty: 'Dentist',
      rating: 4.6,
      distance: '2.0km away',
      image: 'assets/D3.png',
    ),
    DoctorModel(
      name: 'Dr. Aisha Patel',
      specialty: 'Dentist',
      rating: 4.7,
      distance: '1.3km away',
      image: 'assets/D8.jpg',
    ),
   
    // General (5 doctors)
    DoctorModel(
      name: 'Dr. Lisa Chen',
      specialty: 'General',
      rating: 4.5,
      distance: '600m away',
      image: 'assets/D11.png',
    ),
    DoctorModel(
      name: 'Dr. Patricia Garcia',
      specialty: 'General',
      rating: 4.7,
      distance: '1.1km away',
      image: 'assets/D13.png',
    ),
    DoctorModel(
      name: 'Dr. Luke Thompson',
      specialty: 'General',
      rating: 4.4,
      distance: '3.1km away',
      image: 'assets/D4.png',
    ),
    DoctorModel(
      name: 'Dr. Sophia Martinez',
      specialty: 'General',
      rating: 4.8,
      distance: '0.9km away',
      image: 'assets/D14.png',
    ),
    DoctorModel(
      name: 'Dr. Raj Desai',
      specialty: 'General',
      rating: 4.6,
      distance: '2.3km away',
      image: 'assets/D2.png',
    ),
    // Lungs Specialist (5 doctors)
    DoctorModel(
      name: 'Dr. Emily Wilson',
      specialty: 'Lungs Specialist',
      rating: 4.9,
      distance: '1.5km away',
      image: 'assets/D1.png',
    ),
    DoctorModel(
      name: 'Dr. Ashok Patel',
      specialty: 'Lungs Specialist',
      rating: 4.7,
      distance: '2km away',
      image: 'assets/D15.png',
    ),
    DoctorModel(
      name: 'Dr. Christine Lee',
      specialty: 'Lungs Specialist',
      rating: 4.8,
      distance: '1.2km away',
      image: 'assets/D7.png',
    ),
    DoctorModel(
      name: 'Dr. Rahul Gupta',
      specialty: 'Lungs Specialist',
      rating: 4.6,
      distance: '2.8km away',
      image: 'assets/D10.png',
    ),
    
    // Surgeon (5 doctors)
    DoctorModel(
      name: 'Dr. Jennifer White',
      specialty: 'Surgeon',
      rating: 4.8,
      distance: '2.5km away',
      image: 'assets/D16.png',
    ),
    DoctorModel(
      name: 'Dr. Amanda Taylor',
      specialty: 'Surgeon',
      rating: 4.6,
      distance: '3km away',
      image: 'assets/D17.png',
    ),
    DoctorModel(
      name: 'Dr. David Lawrence',
      specialty: 'Surgeon',
      rating: 4.9,
      distance: '2.1km away',
      image: 'assets/D9.png',
    ),
    DoctorModel(
      name: 'Dr. Natasha Singh',
      specialty: 'Surgeon',
      rating: 4.7,
      distance: '1.9km away',
      image: 'assets/D12.png',
    ),
   
    // Covid-19 (5 doctors)
    DoctorModel(
      name: 'Dr. Raymond Martinez',
      specialty: 'Covid-19',
      rating: 4.9,
      distance: '1.2km away',
      image: 'assets/D18.png',
    ),
    DoctorModel(
      name: 'Dr. Victoria Anderson',
      specialty: 'Covid-19',
      rating: 4.7,
      distance: '1.8km away',
      image: 'assets/D19.png',
    ),
    DoctorModel(
      name: 'Dr. Robert Zhang',
      specialty: 'Covid-19',
      rating: 4.8,
      distance: '1.4km away',
      image: 'assets/D3.png',
    ),
  
  ];

  List<DoctorModel> get doctors {
    if (widget.specialty == null) {
      return allDoctors;
    }
    return allDoctors
        .where((doctor) => doctor.specialty == widget.specialty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet =
        MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button, title, and menu icon
            _buildHeader(context, isMobile),
            // Doctors list
            Expanded(child: _buildDoctorsList(isMobile, isTablet)),
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
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: isMobile ? 20 : 24,
              color: Colors.black,
            ),
            splashRadius: 22, // optional nice ripple
          ),

          // Title
          Text(
            widget.specialty ?? 'Top Doctor',
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          // Menu icon
          Icon(Icons.more_vert, size: isMobile ? 20 : 24, color: Colors.black),
        ],
      ),
    );
  }

  // Doctors list widget
  Widget _buildDoctorsList(bool isMobile, bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? 16.0
            : isTablet
            ? 24.0
            : 32.0,
        vertical: isMobile ? 12.0 : 16.0,
      ),
      child: isTablet
          ? _buildGridView()
          : Column(
              children: List.generate(
                doctors.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 12.0 : 16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetailPage(
                            doctorName: doctors[index].name,
                            speciality: doctors[index].specialty,
                            rating: doctors[index].rating,
                            distanceText: doctors[index].distance,
                            photoUrl: doctors[index].image,
                          ),
                        ),
                      );
                    },
                    child: _buildDoctorCard(doctors[index], isMobile),
                  ),
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
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorDetailPage(
                  doctorName: doctors[index].name,
                  speciality: doctors[index].specialty,
                  rating: doctors[index].rating,
                  distanceText: doctors[index].distance,
                  photoUrl: doctors[index].image,
                ),
              ),
            );
          },
          child: _buildDoctorCard(doctors[index], false),
        );
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
