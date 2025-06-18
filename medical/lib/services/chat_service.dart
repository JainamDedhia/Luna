import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';

class ChatService {
  // Replace with your ngrok URL (get this from your Python console output)
  static const String baseUrl = 'https://3979-35-227-10-177.ngrok-free.app'; // e.g. 'https://1234-5678-9012.ngrok-free.app'
  
  static Future<ChatMessage> sendMessage(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chatbot'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': userMessage}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
final botResponse = responseData is String ? responseData : responseData.toString();

bool isEmergency = _isEmergencyResponse(botResponse);
List<String>? steps = _parseSteps(botResponse);

// If steps are extracted, clear the main text to avoid duplication
final cleanedBotText = steps != null ? '' : botResponse;

return ChatMessage.bot(
  cleanedBotText,
  isEmergency: isEmergency,
  steps: steps,
);

      } else {
        return ChatMessage.bot(
          '⚠️ Sorry, the server responded with an error (${response.statusCode}). Please try again later.',
          isEmergency: true,
        );
      }
    } catch (e) {
      return ChatMessage.bot(
        '⚠️ Network error: ${e.toString()}. Please check your connection and try again.',
        isEmergency: true,
      );
    }
  }
  
  static bool _isEmergencyResponse(String response) {
    final emergencyKeywords = ['severe', '🚨', 'immediate', 'emergency', 'urgent', 'serious', '⚠️'];
    return emergencyKeywords.any((keyword) => response.toLowerCase().contains(keyword));
  }
  
  static List<String>? _parseSteps(String response) {
    final lines = response.split('\n');
    List<String> steps = [];
    
    for (String line in lines) {
      String trimmed = line.trim();
      if (RegExp(r'^\d+\.').hasMatch(trimmed)) {
        steps.add(trimmed);
      }
    }
    
    return steps.isNotEmpty ? steps : null;
  }
}