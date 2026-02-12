import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConsultationDetailsPage extends StatefulWidget {
  final ConsultationDetailsData? consultationData;

  const ConsultationDetailsPage({
    Key? key,
    this.consultationData,
  }) : super(key: key);

  @override
  State<ConsultationDetailsPage> createState() =>
      _ConsultationDetailsPageState();
}

class _ConsultationDetailsPageState extends State<ConsultationDetailsPage> {
  static const Color appColor = Color(0xFF199A8E);
  static const Color titleColor = Colors.black;
  static const Color backgroundColor = Colors.white;

  late ConsultationDetailsData consultationData;

  @override
  void initState() {
    super.initState();
    // Use passed data or default data
    consultationData = widget.consultationData ??
        ConsultationDetailsData(
          name: 'Sarah Johnson',
          age: 32,
          gender: 'Female',
          location: 'Mumbai, Maharashtra',
          appointmentTime: '10:30 AM',
          symptomContext: 'Patient reports persistent headaches (7 days), mild fever, and fatigue. No history of migraines. BP normal.',
          initials: 'SJ',
        );
  }

  void _handleBackButton() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: titleColor, size: 24),
          onPressed: _handleBackButton,
        ),
        title: const Text(
          'Consultation Details',
          style: TextStyle(
            color: titleColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? 16
                : isTablet
                ? 24
                : 32,
            vertical: isMobile ? 16 : 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient Card
              _buildPatientCard(isMobile, isTablet),
              const SizedBox(height: 24),

              // Appointment Time Card
              _buildAppointmentCard(isMobile, isTablet),
              const SizedBox(height: 24),

              // Symptom Context Section
              _buildSymptomContextSection(isMobile, isTablet),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientCard(bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: isMobile ? 60 : 70,
            height: isMobile ? 60 : 70,
            decoration: BoxDecoration(
              color: const Color(0xFFB8E6D5),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Center(
              child: Text(
                consultationData.initials,
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: appColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Patient Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  consultationData.name,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${consultationData.age} yrs • ${consultationData.gender}',
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.locationDot,
                      size: isMobile ? 12 : 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        consultationData.location,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 14,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appointment Time',
                style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                consultationData.appointmentTime,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            ],
          ),
          FaIcon(
            FontAwesomeIcons.clock,
            size: isMobile ? 24 : 28,
            color: appColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomContextSection(bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Symptom Context',
          style: TextStyle(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            consultationData.symptomContext,
            style: TextStyle(
              fontSize: isMobile ? 14 : 15,
              color: Colors.grey.shade700,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

// Data model for consultation details
class ConsultationDetailsData {
  final String name;
  final int age;
  final String gender;
  final String location;
  final String appointmentTime;
  final String symptomContext;
  final String initials;

  ConsultationDetailsData({
    required this.name,
    required this.age,
    required this.gender,
    required this.location,
    required this.appointmentTime,
    required this.symptomContext,
    required this.initials,
  });
}
