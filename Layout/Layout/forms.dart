import 'package:flutter/material.dart';

class Forms extends StatefulWidget {
  @override
  FormState createState() => FormState();
}

class FormState extends State<Forms> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String submittedText = "";

  String? phoneErrorText;
  String? emailErrorText;

  RegExp phoneRegExp = RegExp(r'^\d{10}$');
  RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Enter your name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                errorText: emailErrorText,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Enter your phone number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                errorText: phoneErrorText,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  phoneErrorText = null;
                  emailErrorText = null;

                  if (!phoneRegExp.hasMatch(phoneController.text)) {
                    phoneErrorText = "Phone number must be 10 digits.";
                  } else if (!emailRegExp.hasMatch(emailController.text)) {
                    emailErrorText = "Email must end with @gmail.com.";
                  } else {
                    submittedText =
                        'Name: ${nameController.text}\nEmail: ${emailController.text}\nPhone: ${phoneController.text}';
                  }
                });
              },
              child: Text("Submit"),
            ),
            SizedBox(height: 20),
            if (submittedText.isNotEmpty)
              Text(
                submittedText,
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
