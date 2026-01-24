import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MedicationScheduleScreen extends StatefulWidget {
  const MedicationScheduleScreen({Key? key}) : super(key: key);

  @override
  State<MedicationScheduleScreen> createState() =>
      _MedicationScheduleScreenState();
}

class _MedicationScheduleScreenState extends State<MedicationScheduleScreen> {
  String selectedReminderTime = 'morning';
  String selectedFrequency = 'once_daily';
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);
  DateTime selectedDate = DateTime.now();
  bool repeatUntilStopped = true;
String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final horizontalPadding = isMobile ? 16.0 : 32.0;

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
          'Set Schedule',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Reminder Time Section
              const Text(
                'Reminder Time',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              // Time of Day Selection
              SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      _buildTimeButton(
        'Morning',
        'morning',
        FontAwesomeIcons.sun, // ☀️ Morning
      ),
      const SizedBox(width: 12),
      _buildTimeButton(
        'Afternoon',
        'afternoon',
        FontAwesomeIcons.cloudSun, // ⛅ Afternoon
      ),
      const SizedBox(width: 12),
      _buildTimeButton(
        'Night',
        'night',
        FontAwesomeIcons.moon, // 🌙 Night
      ),
    ],
  ),
),

              const SizedBox(height: 16),
              // Time Picker
              _buildTimePicker(),
              const SizedBox(height: 32),
              // Frequency Section
              const Text(
                'Frequency',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildFrequencyOption('Once daily', 'once_daily'),
              const SizedBox(height: 12),
              _buildFrequencyOption('Twice daily', 'twice_daily'),
              const SizedBox(height: 12),
              _buildFrequencyOption('Custom', 'custom'),
              const SizedBox(height: 32),
              // Duration Section
              const Text(
                'Duration',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              // Start Date
             _buildScheduleTab(isMobile),
const SizedBox(height: 32),

              // Save Button
              _buildSaveButton(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeButton(String label, String value, IconData icon) {
    final isSelected = selectedReminderTime == value;
    return GestureDetector(
      onTap: () => setState(() => selectedReminderTime = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0F4F1) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF199A8E) : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF199A8E) : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF199A8E) : Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildTimePicker() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.access_time,
          color: Colors.grey,
          size: 20,
        ),
        const SizedBox(width: 12),

        /// Selected Time Text (UPDATES LIVE)
        Expanded(
          child: Text(
            _formatTime(selectedTime),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        /// Clock button
        IconButton(
          icon: const Icon(
            Icons.schedule,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: selectedTime,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF199A8E),
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (picked != null) {
              setState(() => selectedTime = picked); // 🔥 THIS WAS MISSING EFFECT
            }
          },
        ),
      ],
    ),
  );
}


  Widget _buildFrequencyOption(String label, String value) {
    final isSelected = selectedFrequency == value;
    return GestureDetector(
      onTap: () => setState(() => selectedFrequency = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0F4F1) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF199A8E) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF199A8E)
                      : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected ? const Color(0xFF199A8E) : Colors.white,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.check,
                          size: 12, color: Colors.white),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleTab(bool isMobile) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        // ───── Start Date Row ─────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 12),
              const Text(
                'Start Date',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => selectedDate = picked);
                  }
                },
                child: const Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ───── Divider ─────
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.shade300,
        ),

        // ───── Repeat Toggle Row ─────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Repeat until stopped',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.scale(
                scale: isMobile ? 0.8 : 1.0,
                child: Switch(
                  value: repeatUntilStopped,
                  onChanged: (value) =>
                      setState(() => repeatUntilStopped = value),
                  activeColor: const Color(0xFF199A8E),
                  activeTrackColor: const Color(0xFF199A8E),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.shade300,
                  thumbColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}



  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          // Handle save reminder logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reminder saved successfully!')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF199A8E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Save Reminder',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}