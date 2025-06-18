import 'package:flutter/material.dart';
import '../models/message.dart';
import '../utils/theme.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == MessageType.user;
    final isEmergency = message.isEmergency;
    final isWelcome = message.type == MessageType.welcome;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getBubbleColor(isUser, isEmergency, isWelcome),
                borderRadius: _getBorderRadius(isUser),
                border: !isUser ? Border.all(
                  color: AppColors.botBubbleBorder,
                  width: 1,
                ) : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isEmergency) _buildEmergencyHeader(),
                  _buildMessageContent(),
                  if (message.steps != null) _buildStepsList(),
                  const SizedBox(height: 4),
                  _buildTimestamp(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isUser) _buildUserAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(
        Icons.local_hospital,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.earthBrown,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildEmergencyHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.emergencyRed,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning, color: Colors.white, size: 16),
          SizedBox(width: 4),
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
      style: TextStyle(
        color: message.type == MessageType.user 
            ? Colors.white 
            : AppColors.textPrimary,
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
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📋 Steps to follow:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 8),
          ...message.steps!.map((step) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              step,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
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
        color: message.type == MessageType.user 
            ? Colors.white70 
            : AppColors.textLight,
      ),
    );
  }

  Color _getBubbleColor(bool isUser, bool isEmergency, bool isWelcome) {
    if (isUser) return AppColors.userBubble;
    if (isWelcome) return AppColors.lightGreen;
    if (isEmergency) return AppColors.emergencyLight;
    return AppColors.botBubble;
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