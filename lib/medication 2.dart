import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/medication3.dart';

class MedicationReminders extends StatefulWidget {
  const MedicationReminders({Key? key}) : super(key: key);

  @override
  State<MedicationReminders> createState() => _MedicationRemindersState();
}

class _MedicationRemindersState extends State<MedicationReminders> {
  final List<Medication> medications = [
    Medication(
      name: 'Metformin',
      dosage: '500mg',
      time: '08:00',
      isActive: true,
    ),
    Medication(
      name: 'Lisinopril',
      dosage: '10mg',
      time: '20:00',
      isActive: true,
    ),
    Medication(
      name: 'Vitamin D',
      dosage: '1 tablet',
      time: '09:00',
      isActive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Reminders',
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMedicinePage(),
                        ),
                      );
                      // onPressed action
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF199A8E),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),
            // Medication List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 24.0,
                  vertical: 8.0,
                ),
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  final medication = medications[index];
                  return MedicationCard(
                    medication: medication,
                    isMobile: isMobile,
                    onToggle: (value) {
                      setState(() {
                        medication.isActive = value;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        medications.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            // Footer Buttons
            Container(
              padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.clock, size: 18),
                      label: Text(
                        'History',
                        style: TextStyle(fontSize: isMobile ? 14 : 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199A8E),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: isMobile ? 16 : 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.timesCircle,
                        size: 18,
                      ),
                      label: Text(
                        'Missed',
                        style: TextStyle(fontSize: isMobile ? 14 : 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: isMobile ? 16 : 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Medication medication;
  final bool isMobile;
  final Function(bool) onToggle;
  final VoidCallback onDelete;

  const MedicationCard({
    Key? key,
    required this.medication,
    required this.isMobile,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 14.0 : 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medicine Name and Dosage with Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF199A8E).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.capsules,
                        color: Color(0xFF199A8E),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medication.name,
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          medication.dosage,
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                PopupMenuButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.ellipsisVertical,
                    size: 18,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context) => [],
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Time and Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.clock,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      medication.time,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                // ...existing code...
                Transform.scale(
                  scale: isMobile ? 0.8 : 1.0,
                  child: Switch(
                    value: medication.isActive,
                    onChanged: onToggle,
                    activeColor: const Color(0xFF199A8E),
                    activeTrackColor: const Color(0xFF199A8E),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade300,
                    thumbColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.white;
                      }
                      return Colors.white;
                    }),
                  ),
                ),
                // ...existing code...
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Medication {
  final String name;
  final String dosage;
  final String time;
  bool isActive;

  Medication({
    required this.name,
    required this.dosage,
    required this.time,
    required this.isActive,
  });
}
