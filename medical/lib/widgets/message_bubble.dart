import 'package:flutter/material.dart';
import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isUserMessage;
  final Color userColor;
  final Color botColor;
  final Color textColor;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isUserMessage,
    this.userColor = const Color(0xFFD9F99D),
    this.botColor = const Color(0xFF2C2C2C),
    this.textColor = const Color(0xFFD9F99D),
  }) : super(key: key);

Widget _buildSeverityWarning() {
  if (message.severity == null || message.severity!.isEmpty) return const SizedBox();
  
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    margin: const EdgeInsets.only(bottom: 8),
    // decoration: BoxDecoration(
    //   color: Colors.orange.withOpacity(0.2),
    //   borderRadius: BorderRadius.circular(8),
    //   border: Border.all(color: Colors.orange),
    // ),
    // child: Row(
    //   mainAxisSize: MainAxisSize.min,
    //   // children: [
    //   //   Icon(Icons.warning_amber, color: Colors.orange, size: 16),
    //   //   const SizedBox(width: 4),
    //   //   Text(
    //   //     'Severity: ${message.severity}',
    //   //     style: TextStyle(
    //   //       color: Colors.orange,
    //   //       fontSize: 12,
    //   //       fontWeight: FontWeight.w500,
    //   //     ),
    //   //   ),
    //   // ],
    // ),
  );
}

Widget _buildTimeLimitWarning() {
  if (message.timeLimit == null || message.timeLimit!.isEmpty) return const SizedBox();
  
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    margin: const EdgeInsets.only(bottom: 8),
    // decoration: BoxDecoration(
    //   color: Colors.blue.withOpacity(0.2),
    //   borderRadius: BorderRadius.circular(8),
    //   border: Border.all(color: Colors.blue),
    // ),
    // child: Row(
    //   mainAxisSize: MainAxisSize.min,
    //   // children: [
    //   //   Icon(Icons.access_time, color: Colors.blue, size: 16),
    //   //   const SizedBox(width: 4),
    //   //   Text(
    //   //     'Time Limit: ${message.timeLimit}',
    //   //     style: TextStyle(
    //   //       color: Colors.blue,
    //   //       fontSize: 12,
    //   //       fontWeight: FontWeight.w500,
    //   //     ),
    //   //   ),
    //   // ],
    // ),
  );
}
  @override
  Widget build(BuildContext context) {
    final isEmergency = message.isEmergency;
    final isWelcome = message.type == MessageType.welcome;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUserMessage) _buildAvatar(),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getBubbleColor(isUserMessage, isEmergency, isWelcome),
                borderRadius: _getBorderRadius(isUserMessage),
                border: !isUserMessage ? Border.all(
                  color: userColor.withOpacity(0.3),
                  width: 1,
                ) : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    if (isEmergency) _buildEmergencyHeader(),
    if (message.severity != null) _buildSeverityWarning(),
    if (message.timeLimit != null) _buildTimeLimitWarning(),
    _buildMessageContent(),
    if (message.steps != null) _buildStepsList(),
    const SizedBox(height: 4),
    _buildTimestamp(),
  ],
),
              ),
            ),
          const SizedBox(width: 8),
          if (isUserMessage) _buildUserAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: userColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        Icons.local_hospital,
        color: Colors.black,
        size: 20,
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: userColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        Icons.person,
        color: Colors.black,
        size: 20,
      ),
    );
  }

  Widget _buildEmergencyHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            'IMPORTANT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent() {
  return Text(
    message.text,
    softWrap: true,
    overflow: TextOverflow.visible,
    style: TextStyle(
      color: isUserMessage ? Colors.black : textColor,
      fontSize: 15,
      height: 1.4,
    ),
  );
}


  Widget _buildStepsList() {
    if (message.steps == null || message.steps!.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: botColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: userColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📋 Steps to follow:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: userColor,
            ),
          ),
          const SizedBox(height: 8),
          ...message.steps!.map((step) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              step,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTimestamp() {
    return Text(
      _formatTime(message.timestamp),
      style: TextStyle(
        fontSize: 11,
        color: isUserMessage ? Colors.black.withOpacity(0.7) : textColor.withOpacity(0.7),
      ),
    );
  }

  Color _getBubbleColor(bool isUser, bool isEmergency, bool isWelcome) {
    if (isUser) return userColor;
    if (isWelcome) return botColor.withOpacity(0.8);
    if (isEmergency) return Colors.redAccent.withOpacity(0.2);
    return botColor;
  }

  BorderRadius _getBorderRadius(bool isUser) {
    return BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: Radius.circular(isUser ? 20 : 4),
      bottomRight: Radius.circular(isUser ? 4 : 20),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}