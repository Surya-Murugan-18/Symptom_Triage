import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final Color appColor = Color(0xFF199A8E);
  final Color titleColor = Colors.black;
  final Color backgroundColor = Colors.white;

  // Sample notification data with actual dates
  late List<NotificationItem> allNotifications;
  late List<NotificationItem> filteredNotifications;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    allNotifications = [
      NotificationItem(
        title: "I'm Seeing People Die!",
        description: "Heilbron is a board certified...",
        icon: Icons.shield_outlined,
        dateTime: DateTime.now().subtract(Duration(hours: 12, minutes: 10)),
      ),
      NotificationItem(
        title: "Health News",
        description: "Discovered had get considered...",
        icon: Icons.newspaper,
        dateTime: DateTime.now().subtract(Duration(hours: 12, minutes: 5)),
      ),
      NotificationItem(
        title: "Benifex Pill Reminder",
        description: "Discovered had get considered projection who favourable. Necessary up your knowledge it",
        icon: Icons.medication_liquid_outlined,
        dateTime: DateTime.now().subtract(Duration(hours: 1, minutes: 15)),
      ),
      NotificationItem(
        title: "Biggest drop after COVID-19",
        description: "Heilbron is a board surgeon...",
        icon: Icons.trending_down,
        dateTime: DateTime.now().subtract(Duration(days: 1, hours: 5)),
      ),
      NotificationItem(
        title: "How to Work Out COVID-19 ?",
        description: "Despite the hopeful news of the...",
        icon: Icons.fitness_center,
        dateTime: DateTime.now().subtract(Duration(days: 2, hours: 3)),
      ),
      NotificationItem(
        title: "When Self-Care Community Care",
        description: "Board certified surgeon who?...",
        icon: Icons.people_outline,
        dateTime: DateTime.now().subtract(Duration(days: 3, hours: 2)),
      ),
      NotificationItem(
        title: "Pfizer or Moderna?",
        description: "The biggest disadvantage to...",
        icon: Icons.vaccines,
        dateTime: DateTime.now().subtract(Duration(days: 4, hours: 1)),
      ),
      NotificationItem(
        title: "Health News",
        description: "Discovered had get considered...",
        icon: Icons.newspaper,
        dateTime: DateTime.now().subtract(Duration(days: 5, hours: 2)),
      ),
      NotificationItem(
        title: "COVID-19 Update",
        description: "Latest news about coronavirus...",
        icon: Icons.info_outline,
        dateTime: DateTime.now().subtract(Duration(days: 7, hours: 4)),
      ),
      NotificationItem(
        title: "Vaccination Reminder",
        description: "Time for your next vaccine dose...",
        icon: Icons.vaccines,
        dateTime: DateTime.now().subtract(Duration(days: 10, hours: 6)),
      ),
    ];
    filteredNotifications = allNotifications;
  }

  void _filterNotificationsByDate(DateTime date) {
    setState(() {
      selectedDate = date;
      final selectedDay = DateTime(date.year, date.month, date.day);
      
      filteredNotifications = allNotifications.where((notification) {
        final notificationDay = DateTime(
          notification.dateTime.year,
          notification.dateTime.month,
          notification.dateTime.day,
        );
        return notificationDay == selectedDay;
      }).toList();

      // Sort by time - recent first
      filteredNotifications.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    });
  }

  void _clearDateFilter() {
    setState(() {
      selectedDate = null;
      filteredNotifications = allNotifications;
    });
  }

void _onNotificationPressed(NotificationItem notification) {
  
}


  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final padding = isDesktop ? 24.0 : 16.0;
    final fontSize = isDesktop ? 18.0 : 16.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Arrow and Title
            Padding(
              padding: EdgeInsets.all(padding),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: titleColor,
                      size: isDesktop ? 28 : 24,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  Expanded(
                    child: Text(
                      "NOTIFICATION",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize + 2,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(width: isDesktop ? 28 : 24),
                ],
              ),
            ),
            // Date Filter Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter by Date",
                    style: TextStyle(
                      fontSize: isDesktop ? 18.0 : 18.0,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 12 : 8),
                  TextButton(
  onPressed: () async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appColor,
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (pickedDate != null) {
      _filterNotificationsByDate(pickedDate);
    }
  },
  style: TextButton.styleFrom(
    padding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(color: appColor.withOpacity(0.3), width: 1.8),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Row(
      children: [
        Icon(
          FontAwesomeIcons.calendarAlt,
          color: appColor,
          size: isDesktop ? 20 : 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            selectedDate == null
                ? "Select a date to filter"
                : DateFormat('EEEE, MMMM dd, yyyy').format(selectedDate!),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: selectedDate == null
                  ? Colors.grey[500]
                  : titleColor,
            ),
          ),
        ),
        if (selectedDate != null)
          IconButton(
            onPressed: _clearDateFilter,
            icon: Icon(Icons.close, color: appColor),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        Icon(
          Icons.arrow_drop_down,
          color: appColor,
          size: isDesktop ? 24 : 24,
        ),
      ],
    ),
  ),
),

                ],
              ),
            ),
            // Notifications List
            Expanded(
              child: filteredNotifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_none,
                            color: appColor.withOpacity(0.5),
                            size: isDesktop ? 64 : 48,
                          ),
                          SizedBox(height: 16),
                          Text(
                            selectedDate == null
                                ? "No notifications"
                                : "No notifications for this date",
                            style: TextStyle(
                              fontSize: isDesktop ? 16.0 : 14.0,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      itemCount: filteredNotifications.length,
                      itemBuilder: (context, index) {
                        return NotificationCard(
                          notification: filteredNotifications[index],
                          appColor: appColor,
                          titleColor: titleColor,
                          backgroundColor: backgroundColor,
                          isDesktop: isDesktop,
                          onPressed: () => _onNotificationPressed(filteredNotifications[index]),
                        );
                      },
                    ),
            ),
            // Action Buttons at Bottom
       
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final Color appColor;
  final Color titleColor;
  final Color backgroundColor;
  final bool isDesktop;
  final VoidCallback onPressed;

  const NotificationCard({
    required this.notification,
    required this.appColor,
    required this.titleColor,
    required this.backgroundColor,
    required this.isDesktop,
    required this.onPressed,
  });

  String getTimeString(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final notificationDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    String dayString;
    if (notificationDate == today) {
      dayString = "Today";
    } else if (notificationDate == yesterday) {
      dayString = "Yesterday";
    } else {
      dayString = DateFormat('EEEE').format(dateTime); // Monday, Tuesday, etc.
    }

    String dateString = DateFormat('MMM dd').format(dateTime); // Jan 18
    String timeString = DateFormat('hh:mm a').format(dateTime); // 12:10 AM

    return "$dayString, $dateString · $timeString";
  }

  @override
  Widget build(BuildContext context) {
  final iconSize = isDesktop ? 48.0 : 40.0;
  final titleFontSize = isDesktop ? 16.0 : 16.0;
  final descFontSize = isDesktop ? 13.0 : 13.0;
  final timeFontSize = isDesktop ? 12.0 : 12.0;

  return TextButton(
    onPressed: onPressed, // ✅ onPressed added here
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Container(
      margin: EdgeInsets.only(bottom: isDesktop ? 16 : 12),
      padding: EdgeInsets.all(isDesktop ? 16 : 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: appColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    notification.icon,
                    color: appColor,
                    size: iconSize * 0.55,
                  ),
                ),
              ),
              SizedBox(width: isDesktop ? 16 : 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      notification.description,
                      style: TextStyle(
                        fontSize: descFontSize,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 12 : 8),

          // Date & Time
          Text(
            getTimeString(notification.dateTime),
            style: TextStyle(
              fontSize: timeFontSize,
              fontWeight: FontWeight.w500,
              color: appColor,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    ),
  );
}

}

class NotificationItem {
  final String title;
  final String description;
  final IconData icon;
  final DateTime dateTime;

  NotificationItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.dateTime,
  });
}
