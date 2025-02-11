import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/addUser.dart';

class UserDetail extends StatefulWidget {
  final Map<String, dynamic> user;
  final Function(Map<String, dynamic>) onUserUpdated;

  const UserDetail({Key? key, required this.user, required this.onUserUpdated}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late Map<String, dynamic> _user;

  int calculateAge(String dob) {
    try {
      DateTime birthDate = DateFormat('dd/MM/yyyy').parse(dob);
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return -1;
    }
  }

  void editUser(Map<String, dynamic> userEdit) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUser(
          onSaveUser: (updatedUserData) {
            setState(() {
              // Update the user data
              userEdit.addAll(updatedUserData);
              // Recalculate the age after updating the user data
              userEdit['age'] = calculateAge(userEdit['dob']);
            });
            widget.onUserUpdated(userEdit);
          },
          existingUser: userEdit,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    // Calculate age initially when loading user data
    _user['age'] = calculateAge(_user['dob']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user['name']),
        backgroundColor: Color(0xFFB24592),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFB24592),
                      child: Text(
                        _user['name'][0].toUpperCase(),
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(_user['name'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text("Personal Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink)),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetail(Icons.phone, "Phone", _user['mobile']),
                    _buildDetail(Icons.email, "Email", _user['email']),
                    _buildDetail(Icons.male, "Gender", _user['gender']),
                    _buildDetail(Icons.location_city, "City", _user['city']),
                    _buildDetail(Icons.cake, "Birthdate", _user['dob']),
                    _buildDetail(Icons.tag, "Age", _user['age'].toString()),
                    _buildDetail(Icons.favorite, "Hobbies", _user['hobbies'].toString()),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => editUser(_user),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text("Edit", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text("Back", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(IconData icon, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.pink),
          SizedBox(width: 10),
          Text("$title: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(child: Text(value ?? "N/A", style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
