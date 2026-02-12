import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorChatDetail extends StatefulWidget {
  final String name;
  final String initials;
  final bool isOnline;

  const DoctorChatDetail({
    Key? key,
    required this.name,
    required this.initials,
    required this.isOnline,
  }) : super(key: key);

  @override
  State<DoctorChatDetail> createState() => _DoctorChatDetailState();
}

class _DoctorChatDetailState extends State<DoctorChatDetail> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    // Sample messages for Sarah Johnson
    if (widget.name == 'Sarah Johnson') {
      messages = [
        ChatMessage(
          text: "Hello doctor, I've been taking the medicine as prescribed.",
          isDoctor: false,
          time: '10:30 AM',
          date: 'Today, Jan 15',
        ),
        ChatMessage(
          text: "That's great to hear, Sarah. Have the headaches subsided?",
          isDoctor: true,
          time: '10:32 AM',
        ),
        ChatMessage(
          text: 'Yes, much better now. But I still feel a bit tired in the evenings.',
          isDoctor: false,
          time: '10:33 AM',
        ),
        ChatMessage(
          text: 'Fatigue can be a side effect. Make sure to stay hydrated and get enough rest.',
          isDoctor: true,
          time: '10:35 AM',
        ),
      ];
    } else {
      // Default messages for other contacts
      messages = [
        ChatMessage(
          text: "Hello doctor, I need your assistance.",
          isDoctor: false,
          time: '10:00 AM',
          date: 'Today, Jan 15',
        ),
        ChatMessage(
          text: "Of course! How can I help you today?",
          isDoctor: true,
          time: '10:02 AM',
        ),
      ];
    }
    setState(() {});
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      messages.add(ChatMessage(
        text: _messageController.text,
        isDoctor: true,
        time: _getCurrentTime(),
      ));
    });
    
    _messageController.clear();
    
    // Scroll to bottom
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

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final maxWidth = isDesktop ? 600.0 : screenWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Warning Banner
       //       _buildWarningBanner(),
              
              // Chat Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final showDate = index == 0 && message.date != null;
                    
                    return Column(
                      children: [
                        if (showDate)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              message.date!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                          ),
                        _buildChatBubble(message),
                      ],
                    );
                  },
                ),
              ),
              
              // Quick Replies (only for Sarah Johnson)
              if (widget.name == 'Sarah Johnson')
                _buildQuickReplies(),
              
              // Message Input
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Back Button
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 8),
              
              // Name and Status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.isOnline 
                            ? const Color(0xFF4CAF50) 
                            : const Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Phone Icon
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.phone,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  // Handle phone call
                },
              ),
              
              // Video Icon
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.video,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  // Handle video call
                },
              ),
              
              // More Icon
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  // Handle more options
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  Widget _buildWarningBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFFFD54F).withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.triangleExclamation,
            color: Color(0xFFFFA726),
            size: 16,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Medical advice given here is for guidance only.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFFF57C00),
              ),
            ),
          ),
        ],
      ),
    );
  } */

  Widget _buildChatBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isDoctor 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.isDoctor)
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF199A8E),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.time,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            )
          else
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.time,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickReplies() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildQuickReplyButton('How are you feeling?'),
            const SizedBox(width: 8),
            _buildQuickReplyButton('Please schedule a follow-up.'),
            const SizedBox(width: 8),
            _buildQuickReplyButton('Take the medicine at...'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReplyButton(String text) {
    return InkWell(
      onTap: () {
        _messageController.text = text;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF199A8E),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF199A8E),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              // Attachment Button
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.paperclip,
                  color: Color(0xFF9E9E9E),
                  size: 20,
                ),
                onPressed: () {
                  // Handle attachment
                },
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
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              
              // Send Button
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF199A8E),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: _sendMessage,
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
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isDoctor;
  final String time;
  final String? date;

  ChatMessage({
    required this.text,
    required this.isDoctor,
    required this.time,
    this.date,
  });
}
