import 'package:flutter/material.dart';

class SigninApp extends StatelessWidget {
  const SigninApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SigninPage(),
    );
  }
}

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bagel-high-resolution-logo-transparent.png', // Replace with your actual logo asset path
              width: 400, // Adjust the size as needed
              height: 200, // Adjust the size as needed
            ),
            SizedBox(height: 40), // Adjust the space as needed
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle login button pressed
                String email = _emailController.text;
                String password = _passwordController.text;
                // For now, just print the email and password
                print('Email: $email, Password: $password');
              },
              child: Text('LOG IN'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
