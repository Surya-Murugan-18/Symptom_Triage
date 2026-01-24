import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';


// Main Chat Doctor Screen
class ChatDoctorScreen extends StatefulWidget {
  final String doctorName;
  final String doctorImage;
  final String doctorStatus;

  const ChatDoctorScreen({
    Key? key,
    this.doctorName = "Dr. Marcus Horizon",
    this.doctorImage = "assets/D6.jpg",
    this.doctorStatus = "Online",
  }) : super(key: key);

  @override
  State<ChatDoctorScreen> createState() => _ChatDoctorScreenState();
}

class _ChatDoctorScreenState extends State<ChatDoctorScreen> {
  late TextEditingController _messageController;
  late ScrollController _scrollController;
  
  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hello, How can i help you?",
      isUser: false,
      timestamp: "10 min ago",
      senderName: "Dr. Marcus Horizon",
    ),
    ChatMessage(
      text: "I have suffering from headache and cold for 3 days, I took 2 tablets of dolo, but still pain",
      isUser: true,
      timestamp: "Now",
    ),
    ChatMessage(
      text: "Ok, Do you have fever? is the headache severe",
      isUser: false,
      timestamp: "5 min ago",
      senderName: "Dr. Marcus Horizon",
    ),
    ChatMessage(
      text: "I don,t have any fever, but headache is painful",
      isUser: true,
      timestamp: "Now",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          text: _messageController.text,
          isUser: true,
          timestamp: "Now",
        ));
      });
      _messageController.clear();
      _scrollToBottom();

      // Simulate doctor's reply
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            messages.add(ChatMessage(
              text: "Thank you for the information. Let me analyze your symptoms.",
              isUser: false,
              timestamp: "Just now",
              senderName: widget.doctorName,
            ));
          });
          _scrollToBottom();
        }
      });
    }
  }

  void _startVideoCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Starting video call with Dr. Marcus Horizon...'),
        backgroundColor: const Color(0xFF199A8E),
        duration: const Duration(seconds: 2),
      ),
    );
    // Implement actual video call functionality here
  }

  void _startVoiceCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Starting voice call with Dr. Marcus Horizon...'),
        backgroundColor: const Color(0xFF199A8E),
        duration: const Duration(seconds: 2),
      ),
    );
    // Implement actual voice call functionality here
  }

  Future<void> _uploadDocument() async {
  try {
    // ✅ Request permission (Android 13 safe)
    await Permission.storage.request();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png', 'jpeg'],
    );

    if (result == null) return; // user cancelled

    setState(() {
      messages.add(ChatMessage(
        text: "📄 ${result.files.single.name}",
        isUser: true,
        timestamp: "Now",
      ));
    });

    _scrollToBottom();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Document uploaded: ${result.files.single.name}'),
        backgroundColor: const Color(0xFF199A8E),
      ),
    );
  } catch (e) {
    debugPrint("File upload error: $e"); // 🔍 DEBUG

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error uploading document'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final isMobile = !isDesktop;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(isDesktop),
      body: Column(
        children: [
          // Consultation Start Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: 16,
            ),
            child: Column(
              children: [
                Text(
                  'Consultation Start',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF199A8E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You can consult your problem to the doctor',
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 24,
                vertical: 12,
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildChatBubble(messages[index], isMobile);
              },
            ),
          ),
          // Message Input Area
          _buildMessageInputArea(isMobile),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDesktop) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(widget.doctorImage),
            onBackgroundImageError: (exception, stackTrace) {
              // Fallback if image doesn't exist
            },
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doctorName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.doctorStatus,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.video,
            color: Colors.black,
            size: 20,
          ),
          onPressed: _startVideoCall,
          tooltip: 'Video Call',
        ),
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.phone,
             color: Colors.black,
            size: 20,
          ),
          onPressed: _startVoiceCall,
          tooltip: 'Voice Call',
        ),
        PopupMenuButton<String>(
          onSelected: (String result) {
            if (result == 'info') {
              // Handle doctor info
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'info',
              child: Text('Doctor Info'),
            ),
            const PopupMenuItem<String>(
              value: 'report',
              child: Text('Reports'),
            ),
            const PopupMenuItem<String>(
              value: 'end',
              child: Text('End Consultation'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChatBubble(ChatMessage message, bool isMobile) {
    final bubbleWidth = isMobile ? null : 400.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: message.isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!message.isUser)
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                child: Text(
                  message.senderName ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            Container(
              constraints: BoxConstraints(
                maxWidth: isMobile
                    ? MediaQuery.of(context).size.width * 0.75
                    : bubbleWidth!,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFF199A8E)
                    : const Color(0xFFE8F5F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: message.isUser ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 4.0,
                left: message.isUser ? 0 : 12.0,
                right: message.isUser ? 12.0 : 0,
              ),
              child: Text(
                message.timestamp,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInputArea(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 24,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Document Upload Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: _uploadDocument,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.paperclip,
                  color: const Color(0xFF199A8E),
                  size: isMobile ? 20 : 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Message Input Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type message ...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: isMobile ? 13 : 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                ),
                onSubmitted: (_) => _sendMessage(),
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Send Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFF199A8E),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.white,
                  size: isMobile ? 18 : 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Chat Message Model
class ChatMessage {
  final String text;
  final bool isUser;
  final String timestamp;
  final String? senderName;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.senderName,
  });
}
