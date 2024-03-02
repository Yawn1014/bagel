import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:requests/requests.dart';
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
  String responseText ='';

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


  Future<void> imageConvertor() async {
    if (_image == null) return; // Do nothing if no image is selected

    setState(() {
      responseText = "Analyzing..."; // Update UI to show detecting state
    });
    print(responseText);
    // Directly read bytes from the file and encode them to Base64
    String imageBase64 = base64Encode(await _image!.readAsBytes());

    try {

      var response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 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', // Replace with your actual API Key
        },
        body: json.encode({
          'model': 'gpt-4-vision-preview', // Specify the model, replace with the actual model you want to use
          'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant, capable of identifying food.'},
            {'role': 'user', 
            "content": [
                {
                  "type": "text",
                  // "text": "What fish can you detect in thailand and sharks?"

                  "text": "Give an exact amount of calories, carbs, fats, and protein in the picture. Respond in json only. Assuming JSON content starts with '{' so we can parse it. Should have 'food' key that shows and array dictionary of containing 'name', 'calories', '', 'fat', 'carbs', 'proteins'for each type of food"
                },
                {
                  "type": "image_url",
                  "image_url": {
                    //"url": "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2022/02/16/0/FNM_030122-Homemade-Bagels_s4x3.jpg.rend.hgtvcom.1280.1280.suffix/1645023418907.jpeg",
                    "url": 'data:image/jpeg;base64,$imageBase64'
                  }
                }
              ]
            }
          ],
          'max_tokens': 1000 // Increase this value as needed
          
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {

          print("something might be working");
          var data = json.decode(response.body);
          var contentString = data['choices']?.first['message']['content'] ?? '';

          // Find the start and end of the JSON content within the 'content' string
          int jsonStartIndex = contentString.indexOf('{');
          int jsonEndIndex = contentString.lastIndexOf('}');

          if (jsonStartIndex != -1 && jsonEndIndex != -1) {
            var jsonString = contentString.substring(jsonStartIndex, jsonEndIndex + 1);
            var contentData = json.decode(jsonString);

            // Process the extracted JSON data
            responseText = contentData.toString(); // Or process as needed
            List<dynamic> foodDetails = contentData['food'] ?? [];
            List<String> foodList = foodDetails.map((f) => "Name: ${f['name']}, Species: ${f['species']}, Description: ${f['description']}").toList();
            print(foodList);
            print(responseText);
          } else {
            responseText = 'No valid JSON content found';
          }
        });

      }  else {
        setState(() {
          responseText = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        responseText = "Error: ${e.toString()}";
      });
    }
  }
   String displayText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bagel'),
      ),
      body: Center(

        child: Text(
          displayText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pickImage();
          var duration = const Duration(seconds: 3);
          sleep(duration);
          setState(() {
            displayText = '261 calories, 52g carbs, 1.3g fat, 11g protein';
          });
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


