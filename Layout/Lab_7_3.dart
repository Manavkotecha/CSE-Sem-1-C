import 'package:flutter/material.dart';

class Lab7_3 extends StatefulWidget {
   Lab7_3({super.key});

  @override
  State<Lab7_3> createState() => _Lab7_3State();
}

class _Lab7_3State extends State<Lab7_3> {
   TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: name,
          ),
          ElevatedButton(onPressed: () => print(name.text) ,child: Text("Submit"),),
          Text(name.text)
        ],
      ),

    );
  }
}
