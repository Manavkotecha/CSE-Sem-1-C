import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ensure you have this import

class Dateformat extends StatefulWidget {
  const Dateformat({super.key}); // No parameter needed here

  @override
  State<Dateformat> createState() => _DateformatState();
}

class _DateformatState extends State<Dateformat> {
  final currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Date Format"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('dd/MM/yyyy').format(currentDate)),
            Text(DateFormat('dd-MM-yyyy').format(currentDate)),
            Text(DateFormat('dd-MMM-yyyy').format(currentDate)),
            Text(DateFormat('dd MM yyyy').format(currentDate)),

          ],
        ), // Display the formatted date
      ),
    );
  }
}
