import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class PrivacyNotificationsPage extends StatefulWidget {
  const PrivacyNotificationsPage({Key? key}) : super(key: key);

  @override
  State<PrivacyNotificationsPage> createState() =>
      _PrivacyNotificationsPageState();
}

class _PrivacyNotificationsPageState extends State<PrivacyNotificationsPage> {
  bool pushNotifications = false;
  bool promotionalEmails = false;
  bool research = false;
  bool appUsage = false;

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
  onPressed: () {
    Navigator.pop(context);
  },
  icon: const Icon(
    Icons.arrow_back_ios,
    color: Colors.black,
    size: 18,
  ),
),

        centerTitle: true,
        title: const Text(
          'Privacy and notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
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
              const Divider(),
              SizedBox(height: isMobile ? 20 : 30),

              // Manage your privacy section
              Text(
                'Manage your privacy',
                style: TextStyle(
                  fontSize: isMobile ? 22 : 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              RichText(
                text: TextSpan(
                  text:
                      'You can change your privacy choices at any time in your settings. For more information, visit the ',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 16,
                    height: 1.4,
                    color: const Color(0xFF999999),
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: 'privacy policy',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: const Color(0xFF0066CC),
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _navigateToDetailPage('Privacy Policy');
                        },
                    ),
                    TextSpan(
                      text: '.',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: const Color(0xFF999999),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
                SizedBox(height: isMobile ? 10 : 50),
              const Divider(),
              SizedBox(height: isMobile ? 20 : 50),

              // Communications section
              Text(
                'Communications',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: isMobile ? 20 : 30),

              // Push notifications
              _buildToggleItem(
                title: 'Push notifications',
                descriptionWidget: _buildClickableDescription(
                  text:
                      'Receive notifications related to your symptoms, assessments, health profile, seasonal health concerns and more.',
                  clickableText: 'notifications',
                  onTap: () {
                    // Navigate to notifications detail page
                    _navigateToDetailPage('Notifications');
                  },
                  isMobile: isMobile,
                ),
                value: pushNotifications,
                onChanged: (value) {
                  setState(() {
                    pushNotifications = value;
                  });
                },
                isMobile: isMobile,
              ),
              SizedBox(height: isMobile ? 10 : 32),
               const Divider(),
              SizedBox(height: isMobile ? 14 : 32),

              // Promotional emails
              _buildToggleItem(
                title: 'Promotional emails',
                descriptionWidget: _buildClickableDescription(
                  text:
                      'Receive emails about new features and products, seasonal health concerns, assessment reminders and more.',
                  clickableText: 'emails',
                  onTap: () {
                    // Navigate to emails detail page
                    _navigateToDetailPage('Emails');
                  },
                  isMobile: isMobile,
                ),
                value: promotionalEmails,
                onChanged: (value) {
                  setState(() {
                    promotionalEmails = value;
                  });
                },
                isMobile: isMobile,
              ),
                SizedBox(height: isMobile ? 10 : 50),
               const Divider(),
              SizedBox(height: isMobile ? 13 : 50),

              // Sharing with the Ada team section
              Text(
                'Sharing with the Sev-ai team',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: isMobile ? 20 : 30),

              // Research
              _buildToggleItem(
                title: 'Research',
                descriptionWidget: _buildClickableDescription(
                  text:
                      'Get invited to participate in research based on your health information or use of the app.',
                  clickableText: 'research',
                  onTap: () {
                    // Navigate to research detail page
                    _navigateToDetailPage('Research');
                  },
                  isMobile: isMobile,
                ),
                value: research,
                onChanged: (value) {
                  setState(() {
                    research = value;
                  });
                },
                isMobile: isMobile,
              ),
               SizedBox(height: isMobile ? 10 : 32),
               const Divider(),
              SizedBox(height: isMobile ? 14 : 32),

              // App usage
              _buildToggleItem(
                title: 'App usage',
                descriptionWidget: _buildClickableDescription(
                  text:
                      'Let us know how you found your way to Sev-ai by sharing tracking and usage data.',
                  clickableText: 'tracking and usage data',
                  onTap: () {
                    // Navigate to tracking and usage data detail page
                    _navigateToDetailPage('Tracking and Usage Data');
                  },
                  isMobile: isMobile,
                ),
                value: appUsage,
                onChanged: (value) {
                  setState(() {
                    appUsage = value;
                  });
                },
                isMobile: isMobile,
              ),
              SizedBox(height: isMobile ? 10 : 50),
               const Divider(),
              SizedBox(height: isMobile ? 14 : 50),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetailPage(String title) {
    
  }

  Widget _buildClickableDescription({
    required String text,
    required String clickableText,
    required VoidCallback onTap,
    required bool isMobile,
  }) {
    final parts = text.split(clickableText);
    final textStyle = TextStyle(
      fontSize: isMobile ? 16 : 16,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF7A7A7A),
      height: 1.4,
    );
    final linkStyle = TextStyle(
      fontSize: isMobile ? 16 : 16,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF0066CC),
      decoration: TextDecoration.underline,
      height: 1.4,
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: parts[0], style: textStyle),
          TextSpan(
            text: clickableText,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
          if (parts.length > 1) TextSpan(text: parts[1], style: textStyle),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    Widget? descriptionWidget,
    required bool value,
    required Function(bool) onChanged,
    required bool isMobile,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7A7A7A),
                ),
              ),
              SizedBox(height: isMobile ? 8 : 10),
              descriptionWidget ?? const SizedBox.shrink(),
            ],
          ),
        ),
        SizedBox(width: isMobile ? 12 : 16),
        Transform.scale(
  scale: isMobile ? 0.8 : 1.0,
  child: Switch(
    value: value,
    onChanged: onChanged,
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

      ],
    );
  }
}

// Detail Page for each clickable link

