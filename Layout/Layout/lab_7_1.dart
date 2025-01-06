import 'package:flutter/material.dart';

class Lab7_1 extends StatelessWidget {
  const Lab7_1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(),
      body: Center(
        child: Text("Hello",style: TextStyle(
          color: Colors.yellowAccent,
          backgroundColor: Colors.black,
          fontSize: 21,
          
        ),),
      ),
    );
  }
}
