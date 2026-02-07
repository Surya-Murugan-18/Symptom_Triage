import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final Color appColor = const Color(0xFF199A8E);

  // Form Controllers
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController locationController;
  late TextEditingController weightController;
  late TextEditingController healthProblemController;

  // Emergency Contacts List
  late List<Map<String, dynamic>> emergencyContacts;

  // Form States
  String? selectedBPLevel = "Low";
  bool hasLongTermProblem = false;
  bool takesMedicines = false;

  final List<String> relationships = [
    'Father',
    'Mother',
    'Sister',
    'Brother',
    'Spouse',
    'Friend',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: 'Amelia Renata');
    phoneController = TextEditingController(text: '+1 234 567 8900');
    emailController = TextEditingController(text: 'amelia@example.com');
    locationController = TextEditingController(text: 'New York, USA');
    weightController = TextEditingController(text: '103');
    healthProblemController = TextEditingController();

    // Initialize emergency contacts
    emergencyContacts = [
      {
        'name': TextEditingController(),
        'phone': TextEditingController(),
        'relationship': null,
      },
    ];
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    weightController.dispose();
    healthProblemController.dispose();
    for (var contact in emergencyContacts) {
      contact['name'].dispose();
      contact['phone'].dispose();
    }
    super.dispose();
  }

  void _removeEmergencyContact(int index) {
    final contact = emergencyContacts.removeAt(index);
    contact['name'].dispose();
    contact['phone'].dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final horizontalPadding = isMobile ? 16.0 : 40.0;

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
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth > 800
              ? 800
              : constraints.maxWidth;

          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image Section
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: appColor,
                                      width: 3,
                                    ),
                                    image: const DecorationImage(
                                      image: AssetImage('assets/D10.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: appColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Change profile image',
                                              ),
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(50),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Change Picture',
                              style: TextStyle(
                                color: appColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Personal Information Section
                      _buildSectionTitle('Personal Information'),
                      const SizedBox(height: 16),

                      // Name
                      _buildTextField(
                        label: 'Full Name',
                        controller: nameController,
                        icon: FontAwesomeIcons.user,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Phone Number
                      _buildTextField(
                        label: 'Phone Number',
                        controller: phoneController,
                        icon: FontAwesomeIcons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email ID
                      _buildTextField(
                        label: 'Email ID',
                        controller: emailController,
                        icon: FontAwesomeIcons.envelope,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          if (!value!.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Location
                      _buildTextField(
                        label: 'Location',
                        controller: locationController,
                        icon: FontAwesomeIcons.locationArrow,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your location';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Weight
                      _buildTextField(
                        label: 'Weight (lbs)',
                        controller: weightController,
                        icon: FontAwesomeIcons.weight,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your weight';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // Health Information Section
                      _buildSectionTitle('Health Information'),
                      const SizedBox(height: 16),

                      // Long term problem question
                      _buildQuestionBlock(
                        title: 'Do you have any long-term health problem?',
                        child: Row(
                          children: [
                            _buildRadioOption(
                              label: 'Yes',
                              value: true,
                              groupValue: hasLongTermProblem,
                              onChanged: (value) {
                                setState(() => hasLongTermProblem = true);
                              },
                            ),
                            const SizedBox(width: 24),
                            _buildRadioOption(
                              label: 'No',
                              value: false,
                              groupValue: hasLongTermProblem,
                              onChanged: (value) {
                                setState(() => hasLongTermProblem = false);
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // If yes, mention problem
                      if (hasLongTermProblem) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Please mention the health problem:',
                            style: TextStyle(
                              color: appColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade50,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: healthProblemController,
                            cursorColor: appColor,
                            decoration: InputDecoration(
                              hintText: 'Describe your health problem',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(14),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Takes medicines question
                      _buildQuestionBlock(
                        title: 'Do you take any medications?',
                        child: Row(
                          children: [
                            _buildRadioOption(
                              label: 'Yes',
                              value: true,
                              groupValue: takesMedicines,
                              onChanged: (value) {
                                setState(() => takesMedicines = true);
                              },
                            ),
                            const SizedBox(width: 24),
                            _buildRadioOption(
                              label: 'No',
                              value: false,
                              groupValue: takesMedicines,
                              onChanged: (value) {
                                setState(() => takesMedicines = false);
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Blood Pressure Level
                      _buildQuestionBlock(
                        title: 'Blood Pressure Level:',
                        child: Wrap(
                          spacing: 16,
                          children: [
                            _buildRadioOption(
                              label: 'Low',
                              value: 'Low',
                              groupValue: selectedBPLevel,
                              onChanged: (value) {
                                setState(() => selectedBPLevel = value);
                              },
                            ),
                            _buildRadioOption(
                              label: 'Medium',
                              value: 'Medium',
                              groupValue: selectedBPLevel,
                              onChanged: (value) {
                                setState(() => selectedBPLevel = value);
                              },
                            ),
                            _buildRadioOption(
                              label: 'High',
                              value: 'High',
                              groupValue: selectedBPLevel,
                              onChanged: (value) {
                                setState(() => selectedBPLevel = value);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Emergency Contact Section
                      _buildSectionTitle('Emergency Contact'),
                      const SizedBox(height: 16),

                      // Build all emergency contact forms
                      ..._buildEmergencyContactForms(),
                      const SizedBox(height: 20),

                      // Add another contact button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: appColor, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              emergencyContacts.add({
                                'name': TextEditingController(),
                                'phone': TextEditingController(),
                                'relationship': null,
                              });
                            });
                          },
                          child: Text(
                            'Add Another Contact',
                            style: TextStyle(
                              color: appColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: appColor, width: 1.5),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: appColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(24),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: appColor.withOpacity(
                                                    0.1,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: appColor,
                                                  size: 32,
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              Text(
                                                'Profile Updated',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              const Text(
                                                'Your profile has been updated successfully',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF666666),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 24),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: appColor,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 12,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Done',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Save Changes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.grey.shade50, blurRadius: 6)],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: appColor,
        decoration: InputDecoration(
          label: Text(label),
          labelStyle: TextStyle(color: Colors.grey.shade600),
          floatingLabelStyle: TextStyle(color: appColor),
          prefixIcon: Icon(icon),
          prefixIconColor: appColor,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildQuestionBlock({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.grey.shade50, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  List<Widget> _buildEmergencyContactForms() {
    List<Widget> forms = [];

    for (int i = 0; i < emergencyContacts.length; i++) {
      forms.addAll([
        // Contact header
        if (i > 0)
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
            child: Row(
              children: [
                Text(
                  'Contact ${i + 1}',
                  style: TextStyle(
                    color: appColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() => _removeEmergencyContact(i));
                  },
                  tooltip: 'Remove contact',
                  icon: const Icon(FontAwesomeIcons.trashCan),
                  color: Colors.redAccent,
                ),
              ],
            ),
          )
        else
          const SizedBox(height: 0),

        // Name field
        _buildTextField(
          label: 'Emergency Contact Name',
          controller: emergencyContacts[i]['name'],
          icon: FontAwesomeIcons.user,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter emergency contact name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Phone field
        _buildTextField(
          label: 'Emergency Contact Phone',
          controller: emergencyContacts[i]['phone'],
          icon: FontAwesomeIcons.phone,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter emergency contact phone';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Relationship dropdown
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [BoxShadow(color: Colors.grey.shade50, blurRadius: 6)],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.white),
            child: DropdownButtonFormField<String>(
              value: emergencyContacts[i]['relationship'],
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                labelText: 'Relationship',
                labelStyle: TextStyle(color: Colors.grey.shade600),
                floatingLabelStyle: TextStyle(color: appColor),
                prefixIcon: const Icon(FontAwesomeIcons.userFriends),
                prefixIconColor: appColor,
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              items: relationships
                  .map(
                    (relationship) => DropdownMenuItem<String>(
                      value: relationship,
                      child: Text(
                        relationship,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => emergencyContacts[i]['relationship'] = value);
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select relationship';
                }
                return null;
              },
            ),
          ),
        ),
        if (i < emergencyContacts.length - 1) const SizedBox(height: 24),
      ]);
    }

    return forms;
  }

  Widget _buildRadioOption<T>({
    required String label,
    required T value,
    required T groupValue,
    required ValueChanged<T?> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: appColor,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
