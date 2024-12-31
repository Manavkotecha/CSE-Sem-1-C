import 'package:flutter/material.dart';

class Lab8_1 extends StatelessWidget {
  const Lab8_1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NameInputScreen(),
    );
  }
}

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _nameController = TextEditingController();

  void _navigateToCardScreen() {
    String userName = _nameController.text;
    if (userName.isNotEmpty) {
      // Navigate to the birthday card screen with the user's name
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BirthdayCardScreen(userName: userName),
        ),
      );
    } else {
      // Show an error if the name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Name"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToCardScreen,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class BirthdayCardScreen extends StatelessWidget {
  final String userName;

  const BirthdayCardScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Happy Birthday Card"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://marketplace.canva.com/EAE1KWKcx_A/1/0/900w/canva-happy-birthday-93AD8XNZOr8.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Text positioned below center
          Positioned(
            bottom: 300, // Adjust this value to move text further down
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Happy Birthday, $userName!',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
