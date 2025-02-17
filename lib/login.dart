// import 'package:flutter/material.dart';
// import 'dashboard.dart';
// import 'database_helper.dart';
// import 'signUpPage.dart';
//
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailOrMobileController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   final DatabaseHelper _dbHelper = DatabaseHelper.instance;
//
//   Future<void> _login() async {
//     String input = _emailOrMobileController.text.trim();
//     String password = _passwordController.text.trim();
//
//     if (input.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter all fields')),
//       );
//       return;
//     }
//
//     // Check if input is an email or mobile number
//     bool isEmail = input.contains('@');
//     String queryColumn = isEmail ? 'email' : 'mobile';
//
//     // Query the database
//     final List<Map<String, dynamic>> users = await _dbHelper.database.then((db) {
//       return db.query(
//         'users',
//         where: '$queryColumn = ? AND password = ?',
//         whereArgs: [input, password],
//       );
//     });
//
//     if (users.isNotEmpty) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => Dashboard()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Invalid credentials')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(20),
//             margin: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Welcome Back!!!",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFFB24592),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextField(
//                   controller: _emailOrMobileController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.email, color: Color(0xFFB24592)),
//                     hintText: 'Email or Mobile',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: _obscurePassword,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.lock, color: Color(0xFFB24592)),
//                     hintText: 'Password',
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                         color: Color(0xFFB24592),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _login,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFB24592),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
//                   ),
//                   child: Text('Login', style: TextStyle(fontSize: 18)),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Are you a new User?"),
//                     TextButton(
//                       onPressed: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(builder: (context) => SignUpPage()),
//                         // );
//                       },
//                       child: const Text(
//                         "Sign Up",
//                         style: TextStyle(color: Color(0xFFB24592)),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }