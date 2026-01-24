import 'package:flutter/material.dart';
import 'dart:convert';               // ⭐ jsonEncode
import 'dart:math';                  // ⭐ sessionId generator
import 'package:http/http.dart' as http; // ⭐ http.post
import 'selfcare_urgency.dart';
import 'doctorvist_urgency.dart';
import 'emergency_classification.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String selectedLanguage = 'English';
  bool showLanguageDropdown = false;
  late String sessionId; // ⭐ DECLARED
  bool _isTyping = false; // ⭐ NEW: Track if user is typing

  @override
  void initState() {
    super.initState();
    messages.add(
  ChatMessage(
    text: "👋 Hello! I'm here to give basic health guidance.\nYou can type or speak in your language.",
    isBot: true,
    hasVoice: true,
  ),
);

    sessionId = Random().nextInt(1000000).toString(); // ⭐ INITIALIZED
    _messageController.addListener(_updateTypingStatus); // ⭐ NEW: Listen to text changes
  }

  // ⭐ NEW: Update typing status
  void _updateTypingStatus() {
    setState(() {
      _isTyping = _messageController.text.isNotEmpty;
    });
  }


  // Chat messages
  final List<ChatMessage> messages = [];


    // ================= SEND MESSAGE =================
  Future<void> sendMessageToBackend(String userText) async {
  final response = await http.post(
    Uri.parse("http://10.105.197.129:3000/chat"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "sessionId": sessionId,
      "message": userText,
      "language": selectedLanguage.toLowerCase(),
    }),
  );

  final data = jsonDecode(response.body);

  if (data["type"] == "question") {
    setState(() {
      messages.add(
        ChatMessage(
          text: data["message"],
          isBot: true,
          hasVoice: true,
        ),
      );
    });
  }

  if (data["type"] == "triage") {
    navigateBasedOnTriage(data);
  }

  scrollDown();
}


  // ================= MESSAGE HELPERS =================
  void addUserMessage(String text) {
    setState(() {
      messages.add(ChatMessage(text: text, isBot: false));
    });
    scrollDown();
  }

  void addBotMessage(String text) {
    setState(() {
      messages.add(
        ChatMessage(text: text, isBot: true, hasVoice: true),
      );
    });
    scrollDown();
  }

  void scrollDown() {
    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // ================= TRIAGE NAVIGATION =================
  void navigateBasedOnTriage(Map data) {
    final triage = data["triage"];

    if (triage == "self_care") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SelfCareUrgencyPage()),
      );
    } else if (triage == "doctor") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DoctorVisitUrgencyPage()),
      );
    } else if (triage == "emergency") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => EmergencyClassificationPage()),
      );
    }
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final maxWidth = isDesktop ? 600.0 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              children: [
                // Header
                _buildHeader(context),
                
                // Language Selector
                _buildLanguageSelector(),
                
                // Chat Messages
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return _buildMessageItem(messages[index]);
                        },
                      ),
                      
                      // Scroll to bottom button
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: Color(0xFF26A69A),
                          elevation: 2,
                          onPressed: () {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                          child: Icon(Icons.keyboard_arrow_up, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Input Section
                _buildInputSection(),
                
                // Bottom Navigation
                _buildBottomNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFF26A69A),
      ),
      child: Row(
        children: [
          // Bot Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.smart_toy_outlined,
              color: Color(0xFF26A69A),
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          
          // Title and Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sev-ai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'online',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Menu Icon
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: () {},
          ),
          
          // Notification Icon
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.white, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    final languages = ['English', 'Tamil', 'Hindi'];
    final visibleLanguages = languages.where((lang) => lang != selectedLanguage).toList();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showLanguageDropdown = !showLanguageDropdown;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF26A69A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedLanguage,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
          if (showLanguageDropdown)
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (String lang in visibleLanguages)
                    Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLanguage = lang;
                            showLanguageDropdown = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selectedLanguage == lang ? Color(0xFF26A69A) : Color(0xFF26A69A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            lang,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
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
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (message.isBot) ...[
            // Bot Avatar
            Container(
              width: 32,
              height: 32,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF26A69A), width: 2),
              ),
              child: Icon(
                Icons.smart_toy_outlined,
                color: Color(0xFF26A69A),
                size: 18,
              ),
            ),
            
            // Bot Message
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFFB2DFDB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                  
                  // Voice Button
                  if (message.hasVoice)
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF26A69A),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.volume_up, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'voice',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ] else ...[
            // User Message
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            
            // User Avatar
            Container(
              width: 32,
              height: 32,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'type..',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
  if (value.trim().isEmpty) return;

  setState(() {
    messages.add(ChatMessage(text: value, isBot: false));
  });

  _messageController.clear();
  scrollDown();

  sendMessageToBackend(value);
},

              ),
            ),
          ),
          SizedBox(width: 12),
          
          // ⭐ MODIFIED: Toggle between Voice and Send button based on typing status
          _isTyping ? _buildSendButton() : _buildMicButton(),
        ],
      ),
    );
  }

  // ⭐ NEW: Build Send Button
  Widget _buildSendButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFF26A69A),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.send, color: Colors.white, size: 24),
        onPressed: () {
  final text = _messageController.text;
  if (text.trim().isEmpty) return;

  setState(() {
    messages.add(ChatMessage(text: text, isBot: false));
  });

  _messageController.clear();
  scrollDown();

  sendMessageToBackend(text);
},

      ),
    );
  }

  // ⭐ NEW: Build Mic Button
  Widget _buildMicButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFF26A69A),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.mic, color: Colors.white, size: 24),
        onPressed: () {},
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, false),
          _buildNavItem(Icons.mail_outline, false),
          _buildNavItem(Icons.phone, true), // Active item
          _buildNavItem(Icons.calendar_today_outlined, false),
          _buildNavItem(Icons.person_outline, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF26A69A) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.grey[400],
        size: 26,
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isBot;
  final bool hasVoice;

  ChatMessage({
    required this.text,
    required this.isBot,
    this.hasVoice = false,
  });
}