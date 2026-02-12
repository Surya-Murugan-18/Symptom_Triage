import 'package:flutter/material.dart';

class BookingRequestsPage extends StatefulWidget {
  const BookingRequestsPage({Key? key}) : super(key: key);

  @override
  State<BookingRequestsPage> createState() => _BookingRequestsPageState();
}

class _BookingRequestsPageState extends State<BookingRequestsPage> {
  final List<BookingRequest> bookingRequests = [
    BookingRequest(
      id: '1',
      patientName: 'Sarah Johnson',
      initials: 'SJ',
      age: 32,
      gender: 'Female',
      dateTime: DateTime(2024, 1, 15, 10, 30),
      reason:
          'Experiencing persistent headaches for the past week, along with mild fever and fatigue.',
      specialization: 'General Consultation',
      isRepeat: true,
      avatarColor: const Color(0xFF4DD0E1),
    ),
    BookingRequest(
      id: '2',
      patientName: 'Raj Patel',
      initials: 'RP',
      age: 45,
      gender: 'Male',
      dateTime: DateTime(2024, 1, 15, 11, 30),
      reason:
          'Follow-up consultation for blood pressure monitoring and medication review.',
      specialization: 'Cardiology',
      isRepeat: false,
      avatarColor: const Color(0xFF4DD0E1),
    ),
  ];

  void _handleAccept(BookingRequest request) {
    // Handle accept action
  }

  void _handleReject(BookingRequest request) {
    // Handle reject action
  }

  void _handleModify(BookingRequest request) {
    // Handle modify action
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final maxWidth = isDesktop ? 800.0 : double.infinity;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Booking Requests',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 247, 249),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '2 New',
              style: TextStyle(
                color: Color(0xFF199A8E),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookingRequests.length,
            itemBuilder: (context, index) {
              return BookingRequestCard(
                request: bookingRequests[index],
                onAccept: () => _handleAccept(bookingRequests[index]),
                onReject: () => _handleReject(bookingRequests[index]),
                onModify: () => _handleModify(bookingRequests[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BookingRequest {
  final String id;
  final String patientName;
  final String initials;
  final int age;
  final String gender;
  final DateTime dateTime;
  final String reason;
  final String specialization;
  final bool isRepeat;
  final Color avatarColor;

  BookingRequest({
    required this.id,
    required this.patientName,
    required this.initials,
    required this.age,
    required this.gender,
    required this.dateTime,
    required this.reason,
    required this.specialization,
    required this.isRepeat,
    required this.avatarColor,
  });
}

class BookingRequestCard extends StatelessWidget {
  final BookingRequest request;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onModify;

  const BookingRequestCard({
    Key? key,
    required this.request,
    required this.onAccept,
    required this.onReject,
    required this.onModify,
  }) : super(key: key);

  String _formatDateTime(DateTime dateTime) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final month = months[dateTime.month - 1];
    final day = dateTime.day;
    final year = dateTime.year;
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$month $day, $year at $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with avatar, name, and badges
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: request.avatarColor,
                child: Text(
                  request.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Name and badges
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          request.patientName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (request.isRepeat) ...[
                          const SizedBox(width: 18),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF2196F3),
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Repeat',
                              style: TextStyle(
                                color: Color(0xFF2196F3),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(width: 18),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 235, 248, 250),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              request.specialization,
                              style: const TextStyle(
                                color: Color(0xFF199A8E),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    Text(
                      '${request.age} yrs • ${request.gender}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),

                    Divider(color: Colors.grey[300], height: 16, thickness: 1),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Date and time
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                _formatDateTime(request.dateTime),
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Reason section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5), // background
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300, // outline
                width: 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reason',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  request.reason,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 23),
          // Action buttons
          Row(
            children: [
              Expanded(child: _AcceptButton(onPressed: onAccept)),
              const SizedBox(width: 12),
              Expanded(child: _RejectButton(onPressed: onReject)),
              const SizedBox(width: 12),
              Expanded(child: _ModifyButton(onPressed: onModify)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AcceptButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AcceptButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF199A8E),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Accept',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _RejectButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RejectButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Reject',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ModifyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ModifyButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.grey[300]!, width: 1.5),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Modify',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
