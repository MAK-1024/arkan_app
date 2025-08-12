import 'dart:convert';
import 'package:http/http.dart' as http;

class ISendApi {
  final String _baseUrl = 'https://isend.com.ly/api/v3/sms';
  final String _authToken = '150|KJBHDX9oaioy2fXAvABDQxNkMx9NSKUfB31edRMG';

  Future<Map<String, dynamic>> sendSms(String recipient, String message) async {
    final url = Uri.parse('$_baseUrl/send');
    final headers = {
      'Authorization': 'Bearer $_authToken',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'recipient': recipient,
      'sender_id': 'iSend',
      'type': 'unicode',
      'message': message,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception('Failed to send SMS: ${errorBody['message']}');
    }
  }
}
