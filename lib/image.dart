import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class imageconverter{
  File? _image;
  final String _apiUrl = 'https://api.openai.com/v1/chat/completions';
  final String _apiKey = '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'; // Replace with your actual API Key



  Future<void> _sendImageToApi() async {
    if (_image == null) return;

    final imageBytes = await _image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    try {
      var response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: json.encode({
          'model': 'gpt-4-vision-preview',
          'messages': [
            {
              'role': 'user',
              'content': {
                'image_base64': base64Image
              }
            }
          ],
          'max_tokens': 300,
        }),
      );

      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = json.decode(response.body);
        print(responseBody);
        // Handle the response data
        // ...
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }


}
