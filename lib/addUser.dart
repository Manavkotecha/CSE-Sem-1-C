import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:matrimony3/database_helper.dart';


class AddUser extends StatefulWidget {
  final Function(Map<String, dynamic>) onSaveUser;
  final Map<String, dynamic>? existingUser;


  const AddUser({Key? key, required this.onSaveUser, this.existingUser}) : super(key: key);

  @override
  State<AddUser> createState() => AddUserState();
}

class AddUserState extends State<AddUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? gender;
  List<String> hobbies = [];

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? nameError;
  String? emailError;
  String? mobileError;
  String? dobError;
  String? genderError;
  String? passwordError;
  String? cityError;

  @override
  void initState() {
    super.initState();
    if (widget.existingUser != null) {
      var user = widget.existingUser!;
      nameController.text = user['name'];
      emailController.text = user['email'];
      mobileController.text = user['mobile'];
      dobController.text = user['dob'];
      cityController.text = user['city'];
      gender = user['gender'];
      hobbies = user['hobbies'].split(', ').toList();
      passwordController.text = user['password'] ?? '';
      confirmPasswordController.text = user['password'] ?? '';
    }
  }

  bool validateForm() {
    bool isValid = true;

    setState(() {
      // Name validation
      if (nameController.text.isEmpty ||
          !RegExp(r"^[a-zA-Z\s'-]{3,50}$").hasMatch(nameController.text)) {
        nameError = "Enter a valid full name (3-50 characters)";
        isValid = false;
      } else {
        nameError = null;
      }

      // Email validation
      if (emailController.text.trim().isEmpty ||
          !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,63}$").hasMatch(emailController.text.trim())) {
        emailError = "Enter a valid email address.";
        isValid = false;
      } else {
        emailError = null;
      }

      // Mobile validation
      if (mobileController.text.isEmpty ||
          mobileController.text.length != 10 ||
          !RegExp(r"^[0-9]{10}$").hasMatch(mobileController.text)) {
        mobileError = "Enter a valid 10-digit mobile number.";
        isValid = false;
      } else {
        mobileError = null;
      }

      // Date of Birth validation
      if (dobController.text.isEmpty) {
        dobError = "Please select your date of birth.";
        isValid = false;
      } else {
        dobError = null;
      }

      // City validation
      if (cityController.text.isEmpty) {
        cityError = "Please select a city.";
        isValid = false;
      } else {
        cityError = null;
      }

      // Gender validation
      if (gender == null) {
        genderError = "Please select your gender.";
        isValid = false;
      } else {
        genderError = null;
      }

      // Password validation
      RegExp passwordRegEx = RegExp(r'^(?=.*[A-Z])(?=.*[\W_]).{6,16}$');

      if (passwordController.text.isEmpty ||
          passwordController.text.length < 6 ||
          !passwordRegEx.hasMatch(passwordController.text) ||
          passwordController.text != confirmPasswordController.text) {
        passwordError = "Password must be at least 6 characters long, include at least 1 uppercase letter, and 1 special character.";
        isValid = false;
      } else {
        passwordError = null;
      }

    });

    return isValid;
  }

  // Function to handle date picker
  Future<void> selectDate(BuildContext context) async {
    DateTime initialDate = DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
    if (dobController.text.isNotEmpty) {
      try {
        initialDate = DateFormat('dd/MM/yyyy').parse(dobController.text);
      } catch (e) {
        //
      }
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 80, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingUser == null ? 'Add User' : 'Edit User'),
        backgroundColor: Color(0xFFB24592),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Name Field
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.person, color: Color(0xFFB24592)),
                title: TextField(
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter your full name',
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
            ),


            // Email Field
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.email, color: Color(0xFFB24592)),
                title: TextField(
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email address',
                    errorText: emailError,
                    border: InputBorder.none,
                  ),
                ),

              ),
            ),

            // Mobile Field
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.phone, color: Color(0xFFB24592)),
                title: TextField(
                  keyboardType: TextInputType.phone,
                  controller: mobileController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter your mobile number',
                    errorText: mobileError,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // Date of Birth Field with Date Picker
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color:Color(0xFFB24592)),
                title: GestureDetector(
                  onTap: () => selectDate(context),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: dobController,
                      decoration: InputDecoration(
                        hintText: 'Select your date of birth',
                        errorText: dobError,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // City Field
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.location_city, color: Color(0xFFB24592)),
                title: DropdownButtonFormField<String>(
                  value: cityController.text.isNotEmpty ? cityController.text : null,
                  decoration: InputDecoration(
                    labelText: 'City',
                    errorText: cityError,
                    border: InputBorder.none,
                  ),
                  isExpanded: true, // Ensures the dropdown takes up the full width
                  items: const [
                    DropdownMenuItem(value: 'Rajkot', child: Text('Rajkot')),
                    DropdownMenuItem(value: 'Porbandar', child: Text('Porbandar')),
                    DropdownMenuItem(value: 'Jamnagar', child: Text('Jamnagar')),
                    DropdownMenuItem(value: 'Morbi', child: Text('Morbi')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      cityController.text = value!;
                      cityError = null;
                    });
                  },
                ),
              ),
            ),

            // Gender
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Gender', style: TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => gender = 'Male'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: gender == 'Male' ? const Color(0xFFB24592) : Colors.white,
                                border: Border.all(color: const Color(0xFFB24592)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Male',
                                style: TextStyle(
                                  color: gender == 'Male' ? Colors.white : const Color(0xFFB24592),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => gender = 'Female'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: gender == 'Female' ? const Color(0xFFB24592) : Colors.white,
                                border: Border.all(color: const Color(0xFFB24592)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Female',
                                style: TextStyle(
                                  color: gender == 'Female' ? Colors.white : const Color(0xFFB24592),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => gender = 'Other'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: gender == 'Other' ? const Color(0xFFB24592) : Colors.white,
                                border: Border.all(color: const Color(0xFFB24592)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Other',
                                style: TextStyle(
                                  color: gender == 'Other' ? Colors.white : const Color(0xFFB24592),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (genderError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          genderError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Hobbies Field
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hobbies',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 8.0,
                      children: [
                        for (var hobby in ['Dancing','Singing','Sports','Reading','Gaming','Other'])
                          SizedBox(
                            width: 108,
                            child: FilterChip(
                              label: Center(
                                child: Text(
                                  hobby,
                                  style: TextStyle(
                                    color: hobbies.contains(hobby) ? Colors.white : const Color(0xFFB24592),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              selected: hobbies.contains(hobby),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    hobbies.add(hobby);
                                  } else {
                                    hobbies.remove(hobby);
                                  }
                                });
                              },
                              selectedColor: const Color(0xFFB24592),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side:const BorderSide(
                                  color: Color(0xFFB24592),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Password Field
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.lock_open, color: Color(0xFFB24592)),
                title: TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    errorText: passwordError,
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        color: Color(0xFFB24592),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),

            //Confirm password Field
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.lock, color: Color(0xFFB24592)),
                title: TextField(
                  controller: confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    errorText: passwordError,
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        color: Color(0xFFB24592),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Save and Cancel Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (validateForm()) {
                      Map<String, dynamic> updatedUser = {
                        'id': widget.existingUser?['id'],
                        'name': nameController.text,
                        'email': emailController.text,
                        'mobile': mobileController.text,
                        'dob': dobController.text,
                        'city': cityController.text,
                        'gender': gender,
                        'hobbies': hobbies.join(', '),
                        'password': passwordController.text,
                      };

                      if (widget.existingUser != null) {
                        await DatabaseHelper.instance.updateUser(updatedUser);
                      } else {
                        await DatabaseHelper.instance.insertUser(updatedUser);
                      }

                      widget.onSaveUser(updatedUser);
                      Navigator.pop(context);
                    }
                  },


                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFB24592)),
                  child: const Text('Save',style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFB24592)),
                  child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}