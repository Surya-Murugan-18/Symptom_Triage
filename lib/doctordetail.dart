import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:symtom_checker/bookingdoctor.dart';
import 'package:intl/intl.dart';


class DoctorDetailPage extends StatefulWidget {
  const DoctorDetailPage({
    super.key,
    this.doctorName = 'Dr. Marcus Horizon',
    this.speciality = 'Cardiologist',
    this.rating = 4.7,
    this.distanceText = '800m away',
    this.photoUrl,
  });

  final String doctorName;
  final String speciality;
  final double rating;
  final String distanceText;
  final String? photoUrl;

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  static const Color _primary = Color(0xFF16B3A6);
  static const Color _textMuted = Color(0xFF77838F);
  static const Color _border = Color(0xFFE4E6EA);

  late final List<DateTime> _dates;
  int _selectedDate = -1;
  String? _selectedTime;

  final List<String> _timeSlots = <String>[
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '07:00 PM',
    '08:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _dates = List<DateTime>.generate(
      31,
      (int i) => DateTime.now().add(Duration(days: i)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Doctor Detail',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
  
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool wide = constraints.maxWidth > 640;
          final double panelWidth = wide ? 520 : double.infinity;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: panelWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 96,
                            height: 96,
                            child: widget.photoUrl != null
                                ? Image.network(
                                    widget.photoUrl!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/D6.jpg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 26),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.doctorName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.speciality,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: _textMuted,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE6F8F2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.star,
                                          color: _primary,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          widget.rating.toStringAsFixed(1),
                                          style: const TextStyle(
                                            color: _primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.place,
                                        color: _textMuted,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        widget.distanceText,
                                        style: const TextStyle(
                                          color: _textMuted,
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
                    const SizedBox(height: 24),
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const ReadMoreText(
                      text:
                          'A Cardiologist specializes in diagnosing and treating heart and blood vessel conditions, including high blood pressure, heart disease, and rhythm disorders.They focus on prevention, early detection, and long-term care to maintain overall heart health.',
                    ),

                    const SizedBox(height: 24),
                    _buildDateSelector(),
                    const SizedBox(height: 24),
                    _buildTimeGrid(),
                    const SizedBox(height: 22),

					

SafeArea(
  child: Row(
    children: <Widget>[
      SizedBox(
        width: 56,
        height: 56,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 243, 251, 251),
            shape: const CircleBorder(),
            side: const BorderSide(color: _border),
            padding: EdgeInsets.zero,
          ),
          onPressed: () {},
          child: const FaIcon(
            FontAwesomeIcons.commentDots,
            color: _primary,
            size: 25,
          ),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              if (_selectedDate == -1 || _selectedTime == null) {
                _showSelectionAlert();
                return;
              }

              final DateTime date = _dates[_selectedDate];
              final DateTime parsedTime = DateFormat('hh:mm a').parse(_selectedTime!);
              final DateTime appointmentDateTime = DateTime(
                date.year,
                date.month,
                date.day,
                parsedTime.hour,
                parsedTime.minute,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDoctorPage(
                    doctorName: widget.doctorName,
                    specialization: widget.speciality,
                    rating: widget.rating,
                    distanceText: widget.distanceText,
                    appointmentDateTime: appointmentDateTime,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              shape: const StadiumBorder(),
            ),
            child: const Text(
              'Book  Appointment',
              style: TextStyle(
                color: Colors.white,
				fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int index) {
          final DateTime date = _dates[index];
          final bool selected = index == _selectedDate;
         return MouseRegion(
  cursor: SystemMouseCursors.click, // ✅ hand cursor
  child: GestureDetector(
    onTap: () => setState(() => _selectedDate = index),
    child: Container(
      width: 64,
      decoration: BoxDecoration(
        color: selected ? _primary : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _weekdayAbbrev(date.weekday),
            style: TextStyle(
              color: selected ? Colors.white : _textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date.day.toString().padLeft(2, '0'),
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  ),
);

        },
      ),
    );
  }

  Widget _buildTimeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // ✅ 3 per row
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.6, // controls button height
      ),
      itemCount: _timeSlots.length,
      itemBuilder: (context, index) {
        final time = _timeSlots[index];
        final bool selected = _selectedTime == time;

        return OutlinedButton(
          onPressed: () => setState(() => _selectedTime = time),
          style: OutlinedButton.styleFrom(
            backgroundColor: selected ? _primary : Colors.white,
            side: BorderSide(color: selected ? _primary : _border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }

  String _weekdayAbbrev(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  void _showSelectionAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Select date and time',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Please choose both date and time to proceed with booking.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: Navigator.of(context).pop,
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 14,
                        color: _primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ReadMoreText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ReadMoreText({super.key, required this.text, this.trimLines = 3});

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: const TextStyle(
              fontSize: 14,
              color: _DoctorDetailPageState._textMuted,
              height: 1.5,
            ),
          ),
          maxLines: widget.trimLines,
textDirection: Directionality.of(context),
        )..layout(maxWidth: constraints.maxWidth);

        final bool exceeds = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              maxLines: _expanded ? null : widget.trimLines,
              overflow: _expanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: _DoctorDetailPageState._textMuted,
                height: 1.5,
              ),
            ),
            if (exceeds)
              TextButton(
                onPressed: () {
                  setState(() => _expanded = !_expanded);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  _expanded ? 'Read less' : 'Read more',
                  style: const TextStyle(
                    color: Color(0xFF16B3A6), // ✅ required color
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
