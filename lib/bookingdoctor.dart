import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:symtom_checker/chatdoctor.dart';
import 'package:symtom_checker/doctordetail.dart';

class BookingDoctorPage extends StatefulWidget {
  final String doctorName;
  final String specialization;
  final double rating;
  final String distanceText;
  final DateTime appointmentDateTime;

  const BookingDoctorPage({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.rating,
    required this.distanceText,
    required this.appointmentDateTime,
  });

  @override
  State<BookingDoctorPage> createState() => _BookingDoctorPageState();
}

class _BookingDoctorPageState extends State<BookingDoctorPage> {
  late double consultationFee;
  late double adminFee;
  late double totalAmount;

  final TextEditingController reasonController = TextEditingController();
  String selectedReason = 'General Consultation';
  String? reasonError;

  String selectedPaymentMethod = 'VISA';
  IconData selectedPaymentIcon = FontAwesomeIcons.ccVisa;
  Color selectedPaymentColor = Colors.black87;


  @override
  void initState() {
    super.initState();
    consultationFee = 50;
    adminFee = 5;
    totalAmount = consultationFee + adminFee;
  }

  void _changePaymentMethod() {
    final List<Map<String, dynamic>> paymentMethods = [
      {
        'name': 'VISA',
        'icon': FontAwesomeIcons.ccVisa,
        'color': const Color.fromARGB(255, 2, 36, 64), // ✅ Visa blue
      },
      {
        'name': 'Debit Card',
        'icon': FontAwesomeIcons.creditCard,
        'color': Colors.black87,
      },
      {
        'name': 'PhonePe',
        'icon': FontAwesomeIcons.phone,
        'color': Color(0xFF5F259F), // ✅ PhonePe purple
      },
      {
        'name': 'Google Pay',
        'icon': FontAwesomeIcons.google,
        'color': Color(0xFF4285F4), // ✅ Google blue
      },
      {
        'name': 'UPI',
        'icon': FontAwesomeIcons.indianRupeeSign,
        'color': Color(0xFF0F9D58), // ✅ UPI green
      },
    ];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.all(16),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              ...paymentMethods.map((method) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      setState(() {
  selectedPaymentMethod = method['name'] as String;
  selectedPaymentIcon = method['icon'] as IconData;
  selectedPaymentColor = method['color'] as Color; // ✅ save color
});

                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedPaymentMethod == method['name']
                              ? Color(0xFF17A697)
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: selectedPaymentMethod == method['name']
                            ? Color(0xFF17A697).withOpacity(0.05)
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Center(
  child: FaIcon(
    method['icon'] as IconData,
    color: selectedPaymentMethod == method['name']
        ? Color(0xFF17A697) // ✅ highlight when selected
        : method['color'] as Color,
    size: 20,
  ),
),

                          ),
                          SizedBox(width: 16),
                          Text(
                            method['name'] as String,
                           style: TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: selectedPaymentMethod == method['name']
      ? Color(0xFF17A697) // ✅ selected color
      : Colors.black87,
),

                          ),
                          Spacer(),
                          if (selectedPaymentMethod == method['name'])
                            Icon(
                              Icons.check_circle,
                              color: Color(0xFF17A697),
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmBooking() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: EdgeInsets.symmetric(horizontal: 54),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 54, vertical: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  color: Color(0xFFF1FBF8),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.check, color: Color(0xFF17A697), size: 44),
                ),
              ),
              SizedBox(height: 22),
              Text(
                'Payment Success',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Your payment has been successful, you can have a consultation session with your trusted doctor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  ChatDoctorScreen(),
                              ),
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF17A697),
                    padding: EdgeInsets.symmetric(vertical: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34),
                    ),
                  ),
                  child: Text(
                    'Chat Doctor',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Appointment',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/D6.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: const Icon(Icons.person, size: 40),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.doctorName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.specialization,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Color(0xFF17A697),
                              ),
                              const SizedBox(width: 4),
                              Text(widget.rating.toString()),
                              const SizedBox(width: 12),
                              const Icon(Icons.location_on, size: 16),
                              const SizedBox(width: 4),
                              Text(widget.distanceText),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

_buildSectionHeader(
  'Date',
  'Change',
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorDetailPage(), 
        // ⬆️ replace with your actual page (date selection page)
      ),
    );
  },
),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 242, 248, 247),
                      child: FaIcon(
                        FontAwesomeIcons.calendarDays,
                        size: 18,
                        color: Color(0xFF17A697),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        DateFormat(
                          'EEEE, MMM dd, yyyy | hh:mm a',
                        ).format(widget.appointmentDateTime),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              _buildSectionHeader('Reason', 'Change', _changeReason),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 242, 248, 247),
                      child: FaIcon(
                        FontAwesomeIcons.notesMedical,
                        size: 18,
                        color: Color(0xFF17A697),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        selectedReason,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Payment Detail',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              _buildPaymentItem(
                'Consultation',
                '\$${consultationFee.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 12),
              _buildPaymentItem(
                'Admin Fee',
                '\$${adminFee.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 12),
_buildPaymentItem(
  'Additional Discount',
  '-',
  isDiscount: true,
),

              
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF17A697),
                    ),
                  ),
                ],
              ),
 const Divider(),
              const SizedBox(height: 12),

              _buildSectionHeader(
                'Payment Method',
                'Change',
                _changePaymentMethod,
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
FaIcon(
  selectedPaymentIcon,
  color: selectedPaymentColor, // ✅ USE STORED COLOR
  size: 32,
),
                    const SizedBox(width: 12),
                    Text(
                      selectedPaymentMethod,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _confirmBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF17A697),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Booking',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

void _changeReason() {
  final TextEditingController reasonController =
      TextEditingController(text: selectedReason);
  String? localError;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setLocalState) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter Reason for Consultation',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                /// 🔹 INPUT BOX
                TextField(
                  controller: reasonController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Describe your reason...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF17A697),
                        width: 2,
                      ),
                    ),
                    errorText: localError, // 🔴 inline error
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: const TextStyle(color: Colors.black87),
                ),

                const SizedBox(height: 24),

                /// 🔹 DONE BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (reasonController.text.trim().isEmpty) {
                        setLocalState(() {
                          localError = 'Please enter a reason';
                        });
                        return;
                      }

                      setState(() {
                        selectedReason = reasonController.text.trim();
                      });

                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF17A697),
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(52),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
  );
}


  Widget _buildSectionHeader(
    String title,
    String buttonText,
    VoidCallback onPressed,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        TextButton(
  onPressed: onPressed,
  style: TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    backgroundColor: Colors.transparent,
    overlayColor: const Color.fromARGB(255, 9, 86, 78), // ✅ hover / press color
  ),
  child: Text(
    buttonText,
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.grey[600],
    ),
  ),
),

      ],
    );
  }

  Widget _buildPaymentItem(
    String label,
    String amount, {
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDiscount ? Colors.grey[400] : Colors.black87,
          ),
        ),
      ],
    );
  }
}
