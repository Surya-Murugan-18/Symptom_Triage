import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/finddoctor.dart';
import 'package:symtom_checker/ocr%20notes.dart';

class OCRReportDescription extends StatelessWidget {
  const OCRReportDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final padding = isMobile ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'What This Report Means',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 236, 245, 252),
                  borderRadius: BorderRadius.circular(8),
                  border: const Border(),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Color(0xFF2196F3),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This is a simplified explanation. Always follow your doctor\'s specific instructions.',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 13, 95, 177),
                          fontSize: isMobile ? 13 : 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Medicines Section
              _buildSectionTitle('MEDICINES', isMobile),
              const SizedBox(height: 12),

              // Amoxicillin Card
              _buildMedicineCard(
                title: 'Amoxicillin',
                badge: 'Antibiotic',
                description:
                    'Used to treat bacterial infections. It kills bacteria that cause infections in your body.',
                isMobile: isMobile,
              ),
              const SizedBox(height: 12),

              // Paracetamol Card
              _buildMedicineCard(
                title: 'Paracetamol',
                badge: 'Pain Reliever',
                description:
                    'Used to reduce fever and relieve mild to moderate pain.',
                isMobile: isMobile,
              ),
              const SizedBox(height: 28),

              // Tests Section
              _buildSectionTitle('TESTS', isMobile),
              const SizedBox(height: 12),

              // CBC Card
              _buildTestCard(
                title: 'CBC',
                badge: 'Blood Test',
                description:
                    'Complete Blood Count. Checks your overall health and detects disorders like anemia or infection.',
                isMobile: isMobile,
              ),
              const SizedBox(height: 28),

              // Doctor Confirmation Warning
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: const Border(
                    left: BorderSide(
                      color: Color.fromARGB(255, 247, 212, 203),
                      width: 1.5,
                    ),
                    top: BorderSide(
                      color: Color.fromARGB(255, 247, 212, 203),
                      width: 1.5,
                    ),
                    right: BorderSide(
                      color: Color.fromARGB(255, 247, 212, 203),
                      width: 1.5,
                    ),
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 247, 212, 203),
                      width: 1.5,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Color(0xFFD84315),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Doctor Confirmation Required',
                          style: TextStyle(
                            color: const Color(0xFFD84315),
                            fontSize: isMobile ? 14 : 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Only your doctor can confirm diagnosis or treatment. Do not change your medication based on this summary.',
                      style: TextStyle(
                        color: const Color(0xFFD84315),
                        fontSize: isMobile ? 13 : 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Consult Doctor Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {

                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  FindDoctorsPage(),
                              ),
                            );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.stethoscope, // 👨‍⚕️ Doctor symbol
                    size: 20,
                  ),
                  label: const Text('Consult Doctor (Optional)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF199A8E),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 20 : 22, // ⬆ increased height
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(
                      fontSize: isMobile ? 15 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Continue to Notes Link
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImportantNotesScreen(),
                              ),
                            );
                    // onPressed logic here
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 13,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
  Expanded(
    child: Center(
      child: Text(
        'Continue to Notes',
        style: TextStyle(
          color: Color.fromARGB(255, 117, 117, 117),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
],

                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isMobile) {
    return Row(
      children: [
        FaIcon(
          title == 'MEDICINES'
              ? FontAwesomeIcons
                    .pills // 💊 Medicines
              : FontAwesomeIcons.vial, // 🧪 Tests
          color: const Color(0xFF199A8E),
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMedicineCard({
    required String title,
    required String badge,
    required String description,
    required bool isMobile,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: const Color(0xFF199A8E), width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isMobile ? 16 : 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 239, 252, 251),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: Color(0xFF199A8E),
                    fontSize: isMobile ? 12 : 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: isMobile ? 13 : 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestCard({
    required String title,
    required String badge,
    required String description,
    required bool isMobile,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: const Color(0xFF6A1B9A), width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isMobile ? 16 : 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 241, 249),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: const Color(0xFF6A1B9A),
                    fontSize: isMobile ? 12 : 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: isMobile ? 13 : 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
