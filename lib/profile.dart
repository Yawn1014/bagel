import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        // The leading widget is optional, as Flutter automatically
        // includes a back button when needed.
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // This line will navigate back to the previous screen in the stack.
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.blue[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Calorie Goal',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter your calorie goal',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Meals',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  MealItem(date: 'March 1, 2024', calorieCount: 500),
                  MealItem(date: 'February 28, 2024', calorieCount: 700),
                  // Add more MealItems as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _goToProfile(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
}


class MealItem extends StatelessWidget {
  final String date;
  final int calorieCount;

  MealItem({required this.date, required this.calorieCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date),
          Text('$calorieCount calories'),
        ],
      ),
    );
  }
}