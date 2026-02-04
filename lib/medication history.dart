import 'package:flutter/material.dart';

class MedicationHistoryPage extends StatefulWidget {
  const MedicationHistoryPage({Key? key}) : super(key: key);

  @override
  State<MedicationHistoryPage> createState() => _MedicationHistoryPageState();
}

class _MedicationHistoryPageState extends State<MedicationHistoryPage> {
  // Sample medication history data
  late List<MedicationRecord> medicationHistory;

  @override
  void initState() {
    super.initState();
    medicationHistory = [
      MedicationRecord(
        name: 'Metformin',
        date: 'Today',
        time: '08:00',
        status: MedicationStatus.taken,
      ),
      MedicationRecord(
        name: 'Lisinopril',
        date: 'Yesterday',
        time: '20:00',
        status: MedicationStatus.taken,
      ),
      MedicationRecord(
        name: 'Metformin',
        date: 'Yesterday',
        time: '08:00',
        status: MedicationStatus.missed,
      ),
      MedicationRecord(
        name: 'Vitamin D',
        date: 'Yesterday',
        time: '09:00',
        status: MedicationStatus.skipped,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 60,
        leading: Padding(
          padding: EdgeInsets.only(left: isMobile ? 16 : 24),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: isMobile ? 24 : 28,
              ),
            ),
          ),
        ),
        title: Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontSize: isMobile ? 24 : 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isTablet ? 32 : 48),
            vertical: 16,
          ),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: medicationHistory.length,
                itemBuilder: (context, index) {
                  return MedicationHistoryCard(
                    record: medicationHistory[index],
                    isMobile: isMobile,
                  );
                },
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'This history is for personal tracking only.',
                  style: TextStyle(
                    color: Color(0xFFB0B0B0),
                    fontSize: isMobile ? 13 : 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicationHistoryCard extends StatelessWidget {
  final MedicationRecord record;
  final bool isMobile;

  const MedicationHistoryCard({
    Key? key,
    required this.record,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF0F0F0),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 0,
        ),
        child: Row(
          children: [
            // Status Icon
            Container(
              width: 48,
              height: 48,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getIconBackgroundColor(),
              ),
              child: Center(
                child: _buildStatusIcon(),
              ),
            ),
            // Medication Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: isMobile ? 16 : 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${record.date} • ${record.time}',
                    style: TextStyle(
                      color: Color(0xFF8B8B8B),
                      fontSize: isMobile ? 13 : 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Status Badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: _getStatusBadgeColor(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _getStatusText(),
                style: TextStyle(
                  color: _getStatusTextColor(),
                  fontSize: isMobile ? 11 : 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getIconBackgroundColor() {
    switch (record.status) {
      case MedicationStatus.taken:
        return Color(0xFFE8F8F5);
      case MedicationStatus.missed:
        return Color(0xFFFBEBED);
      case MedicationStatus.skipped:
        return Color(0xFFF5F5F5);
    }
  }

  Widget _buildStatusIcon() {
    switch (record.status) {
      case MedicationStatus.taken:
        return Icon(
          Icons.check_circle,
          color: Color(0xFF199A8E),
          size: 24,
        );
      case MedicationStatus.missed:
        return Icon(
          Icons.cancel,
          color: Color(0xFFD32F2F),
          size: 24,
        );
      case MedicationStatus.skipped:
        return Icon(
          Icons.schedule,
          color: Color(0xFF757575),
          size: 24,
        );
    }
  }

  Color _getStatusBadgeColor() {
    switch (record.status) {
      case MedicationStatus.taken:
        return Color(0xFFE8F8F5);
      case MedicationStatus.missed:
        return Color(0xFFFBEBED);
      case MedicationStatus.skipped:
        return Color(0xFFF5F5F5);
    }
  }

  Color _getStatusTextColor() {
    switch (record.status) {
      case MedicationStatus.taken:
        return Color(0xFF199A8E);
      case MedicationStatus.missed:
        return Color(0xFFD32F2F);
      case MedicationStatus.skipped:
        return Color(0xFF757575);
    }
  }

  String _getStatusText() {
    switch (record.status) {
      case MedicationStatus.taken:
        return 'TAKEN';
      case MedicationStatus.missed:
        return 'MISSED';
      case MedicationStatus.skipped:
        return 'SKIPPED';
    }
  }
}

enum MedicationStatus {
  taken,
  missed,
  skipped,
}

class MedicationRecord {
  final String name;
  final String date;
  final String time;
  final MedicationStatus status;

  MedicationRecord({
    required this.name,
    required this.date,
    required this.time,
    required this.status,
  });
}
