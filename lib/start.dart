import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/bagel-high-resolution-logo-transparent.png', // Replace with your actual asset path to the logo
                width: 200, // Set the width to the desired value
                height: 200, // Set the height to the desired value
              ),
              SizedBox(height: 100), // Provides spacing between logo and buttons
              ElevatedButton(
                child: Text('LOG IN'),
                onPressed: () {
                  // Handle login action
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF1F55B3), backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                child: Text('SIGN UP'),
                onPressed: () {
                  // Handle sign up action
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF1F55B3),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
