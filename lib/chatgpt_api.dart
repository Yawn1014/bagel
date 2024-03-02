import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'home.dart';

void imageRequest() async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + (Platform.environment['OPENAI_API_KEY'] ?? ''),
  };

  final data = jsonEncode({
  'model': 'gpt-4-vision-preview',
  'messages': [
    {
      'role': 'user',
      'content': 'Estimate the calories and macros in this picture',
    },
    {
      'role': 'system',
      'content': 'An image is provided for analysis.',
    },
    {
      'role': 'user',
      'content': 'data:image/jpeg;base64,...' // Your base64 image string goes here
    },
  ],
  'max_tokens': 300,
});
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');

  final res = await http.post(url, headers: headers, body: data);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.post error: statusCode= $status');

  print(res.body);
}