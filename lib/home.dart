import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'profile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bagel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomiePage(),
    );
  }
}

class HomiePage extends StatefulWidget {
  @override
  _HomiePageState createState() => _HomiePageState();
} 
  class _HomiePageState extends State<HomiePage> {

  static File? _image;


  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bagel'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Home Page',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Current Nutrients:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Calories: 2000'),
          Text('Protein: 50g'),
          SizedBox(height: 20.0),
          Text(
            'Target Nutrients:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Calories: 2500'),
          Text('Protein: 75g'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            _pickImage();
            
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Navigate to home page
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to profile page
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProfilePage()),
  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
