import 'package:flutter/material.dart';
import 'lab8_1.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a TextEditingController to manage the text input
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 1 To Birthday Card Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            // Replace the Text widget with a TextField
            Text(
              "Navigate",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            // Add a TextField for user input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,  // Controller for capturing input
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                  icon: const Icon(Icons.cake, color: Colors.red),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Get the text from the TextField
                String userName = _controller.text;
                // Pass the user input to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BirthdayCardScreen(userName: userName),
                  ),
                );
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
