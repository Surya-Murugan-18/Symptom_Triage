import 'package:flutter/material.dart';
import 'package:symtom_checker/doctordetail.dart';

class FindDoctorsPage extends StatefulWidget {
  const FindDoctorsPage({super.key});

  @override
  State<FindDoctorsPage> createState() => _FindDoctorsPageState();
}

// Accent colors tuned to match the provided UI (teal + subtle grays)
const Color _teal = Color(0xFF16B3A6);
const Color _tealDark = Color(0xFF0E8D83);
const Color _textPrimary = Color(0xFF0F1A26);
const Color _textSecondary = Color(0xFF7C8A99);
const Color _bg = Colors.white;
const Color _cardBorder = Colors.white;

class _FindDoctorsPageState extends State<FindDoctorsPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<_Doctor> _allDoctors = <_Doctor>[
    _Doctor(
      name: 'Dr. Marcus Horizon',
      specialty: 'Cardiologist',
      rating: 4.7,
      distanceText: '800m away',
      imageUrl: 'assets/D6.jpg',
    ),
    _Doctor(
      name: 'Dr. Maria',
      specialty: 'Psychiatrist',
      rating: 4.5,
      distanceText: '1.2km away',
      imageUrl: 'assets/D1.png',
    ),
    _Doctor(
      name: 'Dr. Stevi',
      specialty: 'Dentist',
      rating: 4.6,
      distanceText: '2.0km away',
      imageUrl: 'assets/D3.png',
    ),
    _Doctor(
      name: 'Dr. Luke',
      specialty: 'General',
      rating: 4.4,
      distanceText: '3.1km away',
      imageUrl: 'assets/D4.png',
      
    ),
  ];

  final List<_CategoryItem> _categories = const <_CategoryItem>[
    _CategoryItem(label: 'General', icon: Icons.local_hospital_outlined),
    _CategoryItem(label: 'Lungs Specialist', icon: Icons.health_and_safety),
    _CategoryItem(label: 'Dentist', icon: Icons.medical_services_outlined),
    _CategoryItem(label: 'Psychiatrist', icon: Icons.psychology_alt_outlined),
    _CategoryItem(label: 'Covid-19', icon: Icons.coronavirus_outlined),
    _CategoryItem(label: 'Surgeon', icon: Icons.vaccines_outlined),
    _CategoryItem(label: 'Cardiologist', icon: Icons.monitor_heart_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: _textPrimary),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        centerTitle: true,
        title: const Text(
          'Find Doctors',
          style: TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final bool isDesktop = width >= 900;
          final double contentMaxWidth = isDesktop ? 720 : 420;

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentMaxWidth),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SearchBar(
                      controller: _searchController,
                      hintText: 'Find a doctor',
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Category',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _CategoryGrid(
                      items: _categories,
                      isDesktop: isDesktop,
                      onPressed: (item) {},
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Recommended Doctors',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._recommendedSection(context),
                    const SizedBox(height: 24),
                    const Text(
                      'Your Recent Doctors',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _RecentDoctorsRow(
                      doctors: _allDoctors,
                      onPressed: (doctor) {},
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 120,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _cardBorder,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _recommendedSection(BuildContext context) {
    final String q = _searchController.text.trim().toLowerCase();
    final List<_Doctor> filtered = q.isEmpty
        ? [_allDoctors.first]
        : _allDoctors.where((d) => d.name.toLowerCase().contains(q)).toList();

    if (filtered.isEmpty) {
      return [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _cardBorder),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Text(
            'No matching doctors found.',
            style: TextStyle(color: _textSecondary),
          ),
        ),
      ];
    }

    return filtered
        .map((d) => _RecommendedCard(doctor: d, onPressed: () {
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  DoctorDetailPage(),
                              ),
                            );
        }))
        .toList();
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const _SearchBar({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _cardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search, color: _textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: const TextStyle(color: _textSecondary, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final List<_CategoryItem> items;
  final bool isDesktop;
  final void Function(_CategoryItem) onPressed;
  const _CategoryGrid({
    required this.items,
    required this.isDesktop,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Use Wrap to keep layout identical while remaining responsive
    final double itemWidth = isDesktop ? 150 : 100;
    final double itemHeight = isDesktop ? 130 : 110;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items
          .map(
            (e) => SizedBox(
              width: itemWidth,
              height: itemHeight,
              child: _CategoryCard(item: e, onPressed: () => onPressed(e)),
            ),
          )
          .toList(),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final _CategoryItem item;
  final VoidCallback onPressed;
  const _CategoryCard({required this.item, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 180,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(item.icon, color: _teal, size: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
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

class _RecommendedCard extends StatelessWidget {
  final _Doctor doctor;
  final VoidCallback onPressed;
  const _RecommendedCard({required this.doctor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final double avatarSize = isMobile ? 80 : 106;
        final double spaceBetween = isMobile ? 12 : 52;

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(18),
            child: Ink(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0),
                    blurRadius: 1800,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _Avatar(imageUrl: doctor.imageUrl, size: avatarSize),
                  SizedBox(width: spaceBetween),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: const TextStyle(
                            color: _textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          doctor.specialty,
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            _RatingPill(
                              ratingText: doctor.rating.toStringAsFixed(1),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.place_outlined,
                                  color: _textSecondary,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    doctor.distanceText,
                                    style: const TextStyle(
                                      color: _textSecondary,
                                      fontSize: 13,
                                    ),
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
            ),
          ),
        );
      },
    );
  }
}

class _RecentDoctorsRow extends StatelessWidget {
  final List<_Doctor> doctors;
  final void Function(_Doctor) onPressed;
  const _RecentDoctorsRow({required this.doctors, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: doctors
            .map(
              (d) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () => onPressed(d),
                        customBorder: const CircleBorder(),
                        child: Ink(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 180,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: _Avatar(imageUrl: d.imageUrl, size: 72),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 70,
                      child: Text(
                        d.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  const _Avatar({required this.imageUrl, this.size = 106});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _cardBorder, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFEAF1F5),
              child: const Icon(Icons.person, color: _teal, size: 32),
            );
          },
        ),
      ),
    );
  }
}

class _RatingPill extends StatelessWidget {
  final String ratingText;
  const _RatingPill({required this.ratingText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7F6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rate_rounded, color: _tealDark, size: 16),
          const SizedBox(width: 4),
          Text(
            ratingText.replaceAll('.', ','),
            style: const TextStyle(
              color: _tealDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Doctor {
  final String name;
  final String specialty;
  final double rating;
  final String distanceText;
  final String imageUrl;
  const _Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.distanceText,
    required this.imageUrl,
  });
}

class _CategoryItem {
  final String label;
  final IconData icon;
  const _CategoryItem({required this.label, required this.icon});
}
