import 'package:flutter/material.dart';

class EmergencyClassificationPage extends StatefulWidget {
  const EmergencyClassificationPage({Key? key}) : super(key: key);

  @override
  State<EmergencyClassificationPage> createState() =>
      _EmergencyClassificationPageState();
}

class _EmergencyClassificationPageState
    extends State<EmergencyClassificationPage> {
  // Colors
  static const Color primaryRed = Color(0xFFE63946);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkText = Color(0xFF000000);
  static const Color greyText = Color(0xFF757575);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: darkText),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Result',
            style: TextStyle(
              color: darkText,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20.0 : 40.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isMobile ? 20 : 30),
                // Emergency Icon
                Container(
                  width: isMobile ? 100 : 130,
                  height: isMobile ? 100 : 130,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryRed,
                  ),
                  child: Center(
                    child: Text(
                      '!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 60 : 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 30 : 40),
                // Main Heading
                Text(
                  'Emergency Attention\nRequired',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkText,
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: isMobile ? 15 : 20),
                // Subheading
                Text(
                  'Your symptoms may indicate a serious\ncondition.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: greyText,
                    fontSize: isMobile ? 14 : 16,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: isMobile ? 25 : 35),
                // Warning Box
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryRed, width: 2),
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFFFF5F5),
                  ),
                  child: Text(
                    'Please seek emergency medical care\nimmediately.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryRed,
                      fontSize: isMobile ? 15 : 17,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 35 : 45),
                // What to do now section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'What to do now',
                    style: TextStyle(
                      color: darkText,
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 25),
                // Action items
                _buildActionItem(
                  number: '1',
                  text: 'Do not delay treatment',
                  isMobile: isMobile,
                ),
                SizedBox(height: isMobile ? 15 : 20),
                _buildActionItem(
                  number: '2',
                  text: 'Call emergency services',
                  isMobile: isMobile,
                ),
                SizedBox(height: isMobile ? 15 : 20),
                _buildActionItem(
                  number: '3',
                  text: 'Go to the nearest emergency facility if\npossible',
                  isMobile: isMobile,
                ),
                SizedBox(height: isMobile ? 30 : 40),
                // Call Ambulance Button
                SizedBox(
                  width: double.infinity,
                  height: isMobile ? 55 : 60,
                  child: ElevatedButton(
                    onPressed: () {
                      _handleCallAmbulance(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Call Ambulance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 15 : 18),
                // Call Emergency Contact Button
                SizedBox(
                  width: double.infinity,
                  height: isMobile ? 55 : 60,
                  child: OutlinedButton(
                    onPressed: () {
                      _handleCallEmergencyContact(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryRed,
                      side: const BorderSide(color: primaryRed, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Call Emergency Contact',
                      style: TextStyle(
                        color: primaryRed,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 25 : 35),
                // Info box about location
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: greyText,
                          size: isMobile ? 20 : 22,
                        ),
                      ),
                      SizedBox(width: isMobile ? 12 : 15),
                      Expanded(
                        child: Text(
                          'Your location may be shared with emergency services if permitted.',
                          style: TextStyle(
                            color: greyText,
                            fontSize: isMobile ? 13 : 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 15 : 20),
                // Footer disclaimer
                Text(
                  'Guidance based on symptom patterns and public medical guidelines.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: greyText,
                    fontSize: isMobile ? 12 : 14,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem({
    required String number,
    required String text,
    required bool isMobile,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: isMobile ? 40 : 50,
          height: isMobile ? 40 : 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primaryRed,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: isMobile ? 15 : 20),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: isMobile ? 8 : 10),
            child: Text(
              text,
              style: TextStyle(
                color: darkText,
                fontSize: isMobile ? 15 : 17,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleCallAmbulance(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Initiating ambulance call...'),
        duration: Duration(seconds: 2),
      ),
    );
    // TODO: Implement actual ambulance calling functionality
    // This could integrate with emergency services API
  }

  void _handleCallEmergencyContact(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Calling emergency contact...'),
        duration: Duration(seconds: 2),
      ),
    );
    // TODO: Implement actual emergency contact calling functionality
    // This could use the device contacts and phone dialer
  }
}
