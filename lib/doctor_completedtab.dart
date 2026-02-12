import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompletedConsultationsPage extends StatefulWidget {
  const CompletedConsultationsPage({super.key});

  @override
  State<CompletedConsultationsPage> createState() => _CompletedConsultationsPageState();
}

class _CompletedConsultationsPageState extends State<CompletedConsultationsPage> {
  static const Color _primary = Color(0xFF199A8E);
  static const Color _border = Color(0xFFE7EEF0);
  static const Color _searchBg = Color(0xFFF5F7F8);
  static const Color _completedBg = Color(0xFFE8F4F2);
  static const Color _linkBlue = Color(0xFF4A90E2);

  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _consultations = [
    {
      'name': 'Amit Kumar',
      'age': '55 yrs',
      'gender': 'Male',
      'date': 'Jan 14, 2024 at 3:00 PM',
      'hasPrevious': true,
    },
    {
      'name': 'Neha Gupta',
      'age': '38 yrs',
      'gender': 'Female',
      'date': 'Jan 14, 2024 at 4:00 PM',
      'hasPrevious': false,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = constraints.maxWidth >= 700 ? 600 : constraints.maxWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  children: [
                    _buildTopBar(context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              _buildSearchBar(),
                              const SizedBox(height: 16),
                              _buildFilterTabs(),
                              const SizedBox(height: 16),
                              ..._consultations.map((consultation) => _buildConsultationCard(consultation)),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 18, color: Colors.black),
          ),
          const Expanded(
            child: Text(
              'Completed Consultations',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: _searchBg,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          const FaIcon(FontAwesomeIcons.magnifyingGlass, size: 16, color: Color(0xFF9AA8AA)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by patient name...',
                hintStyle: TextStyle(fontSize: 14, color: Color(0xFF9AA8AA)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = ['All', 'This Week', 'This Month'];

    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = _selectedTab == index;
        return Padding(
          padding: EdgeInsets.only(right: index < tabs.length - 1 ? 10 : 0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? _primary : const Color(0xFFF5F7F8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF6A7B7D),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildConsultationCard(Map<String, dynamic> consultation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                consultation['name'],
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _completedBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Completed',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${consultation['age']} - ${consultation['gender']}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF6A7B7D)),
          ),
          const SizedBox(height: 4),
          Text(
            consultation['date'],
            style: const TextStyle(fontSize: 12, color: Color(0xFF9AA8AA)),
          ),
          if (consultation['hasPrevious']) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Previous consultation available',
                style: TextStyle(fontSize: 13, color: _linkBlue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.clipboardList, size: 14, color: Color(0xFF6A7B7D)),
                  label: const Text(
                    'Summary',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF6A7B7D)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: _primary),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.fileLines, size: 14, color: _primary),
                  label: const Text(
                    'Report',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _primary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
