import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrient Tracker',
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


  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
