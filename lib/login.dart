import 'package:flutter/material.dart';
import 'package:matrimony3/signUpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'database_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailOrMobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> login() async {
    String input = _emailOrMobileController.text.trim();
    String password = _passwordController.text.trim();

    // Validation Checks
    if (input.isEmpty ||
        (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,63}$").hasMatch(input) &&
            !RegExp(r"^[0-9]{10}$").hasMatch(input))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid email or 10-digit mobile number.')),
      );
      return;
    }

    RegExp passwordRegEx = RegExp(r'^(?=.*[A-Z])(?=.*[\W_]).{6,16}$');
    if (password.isEmpty || !passwordRegEx.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be 6-16 characters long, include at least 1 uppercase letter, and 1 special character.')),
      );
      return;
    }

    // 1️⃣ Check in tempUsers (if you have temporary users)
    final List<Map<String, dynamic>> tempUsers = await _dbHelper.fetchTempUser(input, password);

    if (tempUsers.isNotEmpty) {
      final user = tempUsers.first;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', user['name'] ?? 'User');
      await prefs.setString('userEmail', user['email'] ?? '');
      await prefs.setString('profileImage', user['profileImage'] ?? 'assets/images/logo2.webp');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
            (Route<dynamic> route) => false,
      );
      return;
    }

    // 2️⃣ Check in main user table
    bool isEmail = input.contains('@');
    String queryColumn = isEmail ? 'email' : 'mobile';

    final List<Map<String, dynamic>> users = await _dbHelper.database.then((db) {
      return db.query(
        'users',
        where: '$queryColumn = ? AND password = ?',
        whereArgs: [input, password],
      );
    });

    if (users.isNotEmpty) {
      final user = users.first;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', user['name'] ?? 'User');
      await prefs.setString('userEmail', user['email'] ?? '');
      await prefs.setString('profileImage', user['profileImage'] ?? 'assets/images/logo2>webp');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome Back!!!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB24592),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _emailOrMobileController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Color(0xFFB24592)),
                    hintText: 'Email or Mobile',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFFB24592)),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFFB24592),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB24592),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  ),
                  child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Are you a new User?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Color(0xFFB24592)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

