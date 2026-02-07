import 'package:flutter/material.dart';

class SafetyInformationPage extends StatelessWidget {
  const SafetyInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Safety information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive design: different max width for desktop and mobile
          double maxWidth = constraints.maxWidth > 800 ? 800 : constraints.maxWidth;
          double horizontalPadding = constraints.maxWidth > 800 ? 40 : 24;
          
          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Title
                    
                    
                    
                    // Subtitle
                    const Text(
                      'Important: When to Seek Immediate Medical Help',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Description
                    const Text(
                      'SEV-AI is designed to provide general health guidance and care navigation.\nIt does not replace a doctor, hospital, or emergency services.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF333333),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Warning text
                    const Text(
                      'Do NOT use SEV-AI if you or someone with you is experiencing any of the following symptoms:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Symptoms list
                    _buildBulletPoint(
                      'Severe or tight chest pain, especially if accompanied by sweating, nausea, or pale skin',
                    ),
                    _buildBulletPoint(
                      'Sudden weakness or numbness on one side of the face, arm, or leg',
                    ),
                    _buildBulletPoint(
                      'Difficulty speaking, understanding speech, or sudden confusion',
                    ),
                    _buildBulletPoint(
                      'Severe or worsening difficulty breathing',
                    ),
                    _buildBulletPoint(
                      'Uncontrolled or heavy bleeding',
                    ),
                    _buildBulletPoint(
                      'Seizures, convulsions, or loss of consciousness',
                    ),
                    _buildBulletPoint(
                      'Sudden swelling of the face, lips, tongue, or throat',
                    ),
                    _buildBulletPoint(
                      'Thoughts of self-harm or harming others',
                    ),
                    _buildBulletPoint(
                      'Serious burns, major injuries, or injuries after an accident',
                    ),
                    _buildBulletPoint(
                      'Any condition that feels life-threatening or rapidly worsening',
                    ),
                    const SizedBox(height: 24),
                    
                    // Emergency section title
                    const Text(
                      'What to Do in an Emergency',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    const Text(
                      'If you experience any of the above symptoms:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Emergency actions
                    _buildBulletPoint(
                      ' Call your local emergency number immediately',
                    ),
                    _buildBulletPoint(
                      ' Visit the nearest Emergency Department',
                    ),
                    _buildBulletPoint(
                      ' Do not delay care by using this app',
                    ),
                    const SizedBox(height: 5),
                    
                    const Text(
                      'SEV-AI will automatically highlight emergency situations and provide one-tap emergency assistance when critical symptoms are detected.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF333333),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Disclaimer section
                    const Text(
                      'Medical Disclaimer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildBulletPoint(
                      'SEV-AI does not provide medical diagnoses',
                    ),
                    _buildBulletPoint(
                      'Information is based on trusted public health guidelines',
                    ),
                    _buildBulletPoint(
                      'Always follow advice from qualified healthcare professionals',
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF333333),
              height: 1.5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF333333),
          height: 1.5,
        ),
      ),
    );
  }
}
