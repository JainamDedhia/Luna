import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/chat_service.dart';
import '../widgets/message_bubble.dart';
import '../utils/theme.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;  
  late AnimationController _typingAnimationController;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  
void _listen() async {
  var status = await Permission.microphone.status;

  if (!status.isGranted) {
    status = await Permission.microphone.request();
    if (!status.isGranted) {
      // Show error or toast
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Microphone permission is required.')),
      );
      return;
    }
  }

  if (!_isListening) {
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == 'done' || val == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (val) {
        setState(() => _isListening = false);
      },
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) {
          setState(() {
            _textController.text = val.recognizedWords;
          });

          if (val.hasConfidenceRating && val.confidence > 0.5 && val.finalResult) {
            _sendMessage(val.recognizedWords);
            _speech.stop();
          }
        },
      );
    }
  } else {
    _speech.stop();
    setState(() => _isListening = false);
  }
}



  // Quick action buttons
  final List<Map<String, dynamic>> _quickActions = [
    {'text': 'Headache remedy', 'icon': Icons.psychology, 'query': 'I have a headache'},
    {'text': 'Burn treatment', 'icon': Icons.local_fire_department, 'query': 'What to do for a burn?'},
    {'text': 'Indigestion help', 'icon': Icons.dining, 'query': 'Help with indigestion'},
    {'text': 'Insect bite', 'icon': Icons.pest_control, 'query': 'Remedy for insect bite'},
  ];

  @override
  void initState() {
    super.initState();
    _typingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    // Add welcome message after first frame render
    //WidgetsBinding.instance.addPostFrameCallback((_) {
      //_addWelcomeMessage();
    //});
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _typingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: _messages.isEmpty 
                  ? _buildEmptyState()
                  : _buildMessagesList(),
            ),
            if (_isLoading) _buildTypingIndicator(),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.local_hospital,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🌿 Ayurvedic First Aid',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Natural remedies for wellness',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showInfoDialog,
            icon: const Icon(Icons.info_outline, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.healing,
              size: 64,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Welcome to Ayurvedic First Aid',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Get natural remedies for common health issues',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _quickActions.map((action) => 
        GestureDetector(
          onTap: () => _sendMessage(action['query']),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.lightGreen),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(action['icon'], 
                     color: AppColors.primaryGreen, 
                     size: 20),
                const SizedBox(width: 8),
                Text(
                  action['text'],
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return MessageBubble(message: _messages[index]);
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
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
          ),
          const SizedBox(width: 12),
          AnimatedBuilder(
            animation: _typingAnimationController,
            builder: (context, child) {
              return Row(
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(
                        0.3 + 0.7 * 
                        ((_typingAnimationController.value + index * 0.3) % 1),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              );
            },
          ),
          const SizedBox(width: 8),
          const Text(
            'Analyzing your query...',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    child: SafeArea(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Describe your health concern...',
                hintStyle: TextStyle(color: AppColors.textLight),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (text) => _sendMessage(text),
            ),
          ),
          const SizedBox(width: 8),
          // 🎤 Microphone Button
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: _listen,
              icon: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: AppColors.primaryGreen,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: _isLoading ? null : () => _sendMessage(_textController.text),
              icon: Icon(
                _isLoading ? Icons.hourglass_empty : Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    final trimmedText = text.trim();
    final userMessage = ChatMessage.user(trimmedText);
    
    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
      _textController.clear();
    });

    _scrollToBottom();

    try {
      final botResponse = await ChatService.sendMessage(trimmedText);
      setState(() {
        _messages.add(botResponse);
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage.bot(
          '⚠️ Error: ${e.toString().replaceFirst('Exception: ', '')}',
          isEmergency: true,
        ));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.info, color: AppColors.primaryGreen),
            SizedBox(width: 8),
            Text('About Ayurvedic First Aid'),
          ],
        ),
        content: const Text(
          'This app provides traditional Ayurvedic remedies for common health issues. '
          'Always consult a qualified healthcare professional for serious conditions.\n\n'
          '⚠️ This is not a substitute for professional medical advice.',
          style: TextStyle(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}