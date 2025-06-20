import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';

class ChatService {
  // Replace with your ngrok URL (get this from your Python console output)
  static const String baseUrl = 'https://7ea9-34-125-136-71.ngrok-free.app'; // e.g. 'https://1234-5678-9012.ngrok-free.app'
  
  static Future<ChatMessage> sendMessage(String userMessage) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/chatbot'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': userMessage}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      
      // Handle both string and map responses
      if (responseData is String) {
        return ChatMessage.bot(responseData);
      } else {
        final responseText = responseData['response'] ?? 'No response text';
        final severity = responseData['severity'];
        final timeLimit = responseData['timeLimit'];
        
        bool isEmergency = _isEmergencyResponse(responseText) || 
                          (severity?.toLowerCase() == 'severe');
        
        return ChatMessage.bot(
          responseText,
          isEmergency: isEmergency,
          severity: severity,
          timeLimit: timeLimit,
        );
      }
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
  
}