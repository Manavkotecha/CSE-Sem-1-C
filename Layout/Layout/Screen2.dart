import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'lab8_1.dart';

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BirthdayCardScreen(userName: '',),
        ),
      );

    });
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


