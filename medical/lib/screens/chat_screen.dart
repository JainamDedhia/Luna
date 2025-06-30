import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/chat_service.dart';
import '../widgets/message_bubble.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import '../services/translation_service.dart';
import 'package:provider/provider.dart';
import '../locale_provider.dart';

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
  
  // Color scheme from EducationalLessonsPage
// Color scheme from EducationalLessonsPage
// Soothing Blue Theme
 final Color _primaryColor = const Color(0xFF9AFF00); // Neon green
  final Color _backgroundColor = const Color(0xFF0A0A0A); // Dark background
  final Color _cardColor = const Color(0xFF1A1A1A); // Mid background
  final Color _textColor = Colors.white;
  final Color _secondaryTextColor = const Color(0xFF888888);

  // Language mapping from locale codes to language names
  final Map<String, String> _localeToLanguage = {
    'en': 'English',
    'hi': 'Hindi',
    'gu': 'Gujarati',
    'mr': 'Marathi',
    'ta': 'Tamil',
    'te': 'Telugu',
    'ml': 'Malayalam',
    'bn': 'Bengali',
    'kn': 'Kannada',
    'pa': 'Punjabi',
    'or': 'Odia',
    'as': 'Assamese',
  };

  // Get current language based on locale
  String _getCurrentLanguage() {
    final currentLocale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return _localeToLanguage[currentLocale.languageCode] ?? 'English';
  }

  void _listen() async {
    var status = await Permission.microphone.status;

    if (!status.isGranted) {
      status = await Permission.microphone.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Microphone permission is required.', style: TextStyle(color: _textColor))
));
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

  // Quick action buttons - updated to use current locale
  List<Map<String, dynamic>> _getQuickActions() {
    final currentLocale = Provider.of<LocaleProvider>(context, listen: false).locale;
    
    switch (currentLocale.languageCode) {
      case 'hi':
        return [
          {'text': 'सिरदर्द का इलाज', 'icon': Icons.psychology, 'query': 'मुझे सिरदर्द है'},
          {'text': 'जलने का इलाज', 'icon': Icons.local_fire_department, 'query': 'जलने पर क्या करें?'},
          {'text': 'अपच की मदद', 'icon': Icons.dining, 'query': 'अपच की समस्या है'},
          {'text': 'कीड़े का काटना', 'icon': Icons.pest_control, 'query': 'कीड़े काटने का इलाज'},
        ];
      case 'mr':
        return [
          {'text': 'डोकेदुखीचा उपाय', 'icon': Icons.psychology, 'query': 'मला डोकेदुखी आहे'},
          {'text': 'जळण्याचा उपचार', 'icon': Icons.local_fire_department, 'query': 'जळण्यासाठी काय करावे?'},
          {'text': 'अपचनाची मदत', 'icon': Icons.dining, 'query': 'अपचनाची समस्या आहे'},
          {'text': 'कीड चावणे', 'icon': Icons.pest_control, 'query': 'कीड चावण्याचा उपाय'},
        ];
      default:
        return [
          {'text': 'Headache remedy', 'icon': Icons.psychology, 'query': 'I have a headache'},
          {'text': 'Burn treatment', 'icon': Icons.local_fire_department, 'query': 'What to do for a burn?'},
          {'text': 'Indigestion help', 'icon': Icons.dining, 'query': 'Help with indigestion'},
          {'text': 'Insect bite', 'icon': Icons.pest_control, 'query': 'Remedy for insect bite'},
        ];
    }
  }

  @override
  void initState() {
    super.initState();
    _typingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
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
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return Scaffold(
          backgroundColor: _backgroundColor,
          body: Column(
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
        );
      },
    );
  }

  Widget _buildAppBar() {
    final currentLanguage = _getCurrentLanguage();
    
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.local_hospital,
                  color: _primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🌿 Ayurvedic First Aid',
                      style: TextStyle(
                        color: _primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Natural remedies for wellness',
                      style: TextStyle(
                        color: _secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _showInfoDialog,
                icon: Icon(Icons.info_outline, color: _primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Language display (read-only, shows current selection from menu)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _primaryColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.language, color: _primaryColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Language: ',
                  style: TextStyle(color: _primaryColor, fontSize: 14),
                ),
                Expanded(
                  child: Text(
                    currentLanguage,
                    style: TextStyle(color: _primaryColor, fontSize: 14),
                  ),
                ),
                Text(
                  '(Change from menu)',
                  style: TextStyle(
                    color: _secondaryTextColor, 
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildEmptyState() {
  return Expanded(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40), // Add spacing from top
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.asset(
              'assets/Luna.png',
              height: 64,
              width: 64,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Welcome to Ayurvedic First Aid',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Get natural remedies for common health issues',
            style: TextStyle(
              fontSize: 16,
              color: _secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildQuickActions(),
        ],
      ),
    ),
  );
}

  Widget _buildQuickActions() {
    final quickActions = _getQuickActions();
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: quickActions.map((action) => 
        GestureDetector(
          onTap: () => _sendMessage(action['query']),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _primaryColor.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(action['icon'], 
                     color: _primaryColor, 
                     size: 20),
                const SizedBox(width: 8),
                Text(
                  action['text'],
                  
                  style: TextStyle(
                    color: _primaryColor,
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
        return MessageBubble(
          message: _messages[index],
          isUserMessage: _messages[index].type == MessageType.user,
          userColor: _primaryColor,
          botColor: _cardColor,
          textColor: _textColor,
        );
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
              color: _primaryColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              Icons.local_hospital,
              color: _backgroundColor,
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
                      color: _primaryColor.withOpacity(
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
          Text(
            'Analyzing your query...',
            style: TextStyle(
              color: _secondaryTextColor,
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
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: const BorderRadius.only(
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
                style: TextStyle(color: _textColor),
                decoration: InputDecoration(
                  hintText: 'Describe your health concern...',
                  hintStyle: TextStyle(color: _secondaryTextColor),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (text) => _sendMessage(text),
              ),
            ),
            const SizedBox(width: 8),
            // Microphone Button
            Container(
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _primaryColor.withOpacity(0.3)),
              ),
              child: IconButton(
                onPressed: _listen,
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: _primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                onPressed: _isLoading ? null : () => _sendMessage(_textController.text),
                icon: Icon(
                  _isLoading ? Icons.hourglass_empty : Icons.send,
                  color: _backgroundColor,
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
    // Get current language from LocaleProvider
    final currentLanguage = _getCurrentLanguage();
    
    // Send message with current language from menu selection
    final botResponse = await ChatService.sendMessage(trimmedText, currentLanguage);
    
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
        backgroundColor: _cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.info, color: _primaryColor),
            const SizedBox(width: 8),
            Text('About Ayurvedic First Aid', style: TextStyle(color: _primaryColor)),
          ],
        ),
        content: Text(
          'This app provides traditional Ayurvedic remedies for common health issues. '
          'Always consult a qualified healthcare professional for serious conditions.\n\n'
          '⚠️ This is not a substitute for professional medical advice.',
          style: TextStyle(color: _textColor, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Got it', style: TextStyle(color: _primaryColor)),
          ),
        ],
      ),
    );
  }
}