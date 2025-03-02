// import 'package:matrimony3/database_helper.dart';
// import 'userDetail.dart';
// import 'addUser.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:matrimony3/database_helper.dart';
//
//
// class UserList extends StatefulWidget {
//   final List<Map<String, dynamic>> users;
//   final List<Map<String, dynamic>> favoriteUsers;
//   final Function(List<Map<String, dynamic>>) onFavoritesUpdated;
//
//   const UserList({
//     Key? key,
//     required this.users,
//     required this.favoriteUsers,
//     required this.onFavoritesUpdated,
//   }) : super(key: key);
//
//   @override
//   State<UserList> createState() => _UserListState();
// }
//
// class _UserListState extends State<UserList> {
//   TextEditingController searchController = TextEditingController();
//   List<Map<String, dynamic>> filteredUsers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredUsers = List.from(widget.users);
//     loadFavorites();
//     loadUsers();
//   }
//
//   void loadFavorites() async {
//     List<Map<String, dynamic>> loadedUsers = await DatabaseHelper.instance.fetchUsers();
//     setState(() {
//       var favoriteUsers = loadedUsers.where((user) => user['isFavourite'] == 1).toSet();
//     });
//   }
//
//   void loadUsers() async {
//     List<Map<String, dynamic>> loadedUsers = await DatabaseHelper.instance.fetchUsers();
//
//     setState(() {
//       widget.users.clear();
//       widget.users.addAll(loadedUsers);
//
//       filteredUsers = List.from(widget.users);
//
//       widget.favoriteUsers.clear();
//       widget.favoriteUsers.addAll(
//         loadedUsers.where((user) => user['isFavourite'] == 1),
//       );
//     });
//   }
//
//   void searchName(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         // Reset the list to the latest loaded users
//         filteredUsers = List.from(widget.users);
//       } else {
//         filteredUsers = widget.users.where((user) {
//           int age = calculateAge(user['dob']);
//           return user['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
//               user['mobile'].toString().contains(query) ||
//               user['email'].toString().toLowerCase().contains(query.toLowerCase()) ||
//               age.toString().contains(query);
//         }).toList();
//       }
//     });
//   }
//
//   int calculateAge(String dob) {
//     try {
//       DateTime birthDate = DateFormat('dd/MM/yyyy').parse(dob);
//       DateTime currentDate = DateTime.now();
//       int age = currentDate.year - birthDate.year;
//       if (currentDate.month < birthDate.month ||
//           (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
//         age--;
//       }
//       return age;
//     } catch (e) {
//       return -1;
//     }
//   }
//
//   void editUser(Map<String, dynamic> userEdit) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddUser(
//           onSaveUser: (updatedUserData) async {
//             await DatabaseHelper.instance.updateUser(updatedUserData);
//             loadUsers(); // Reload users to update the UI
//           },
//           existingUser: userEdit,
//         ),
//       ),
//     );
//   }
//
//   void deleteUser(int id) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Delete'),
//           content: const Text('Are you sure you want to delete this user?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 Navigator.of(context).pop(); // Close the dialog first
//                 int deletedRows = await DatabaseHelper.instance.deleteUser(id);
//                 if (deletedRows > 0) {
//                   setState(() {
//                     widget.users.removeWhere((user) => user['id'] == id);
//                     filteredUsers.removeWhere((user) => user['id'] == id);
//                   });
//                 }
//               },
//               child: const Text('Delete', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void toggleFavorite(Map<String, dynamic> user) async {
//     Map<String, dynamic> updatedUser = Map<String, dynamic>.from(user);
//     updatedUser['isFavourite'] = (updatedUser['isFavourite'] == 1) ? 0 : 1;
//
//     print("Toggling favorite for user: ${updatedUser['name']} (ID: ${updatedUser['id']})");
//     print("New isFavourite status: ${updatedUser['isFavourite']}");
//
//     await DatabaseHelper.instance.updateUser(updatedUser);
//     List<Map<String, dynamic>> allUsers = await DatabaseHelper.instance.fetchUsers();
//     print("Updated users: $allUsers");
//
//     setState(() {
//       int index = filteredUsers.indexWhere((u) => u['id'] == user['id']);
//       if (index != -1) {
//         filteredUsers[index] = updatedUser;
//       }
//
//       if (updatedUser['isFavourite'] == 1) {
//         if (!widget.favoriteUsers.any((u) => u['id'] == updatedUser['id'])) {
//           widget.favoriteUsers.add(updatedUser);
//         }
//       } else {
//         widget.favoriteUsers.removeWhere((u) => u['id'] == updatedUser['id']);
//       }
//     });
//
//     print("Updated favorite users: ${widget.favoriteUsers}");
//
//     widget.onFavoritesUpdated(List.from(widget.favoriteUsers));
//   }
//
//   void sortUsersByName({required bool ascending}) {
//     setState(() {
//       filteredUsers.sort((a, b) {
//         int result = a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
//         return ascending ? result : -result;
//       });
//     });
//   }
//
//   void sortUsersByAge({required bool ascending}) {
//     setState(() {
//       filteredUsers.sort((a, b) {
//         int result = calculateAge(a['dob']).compareTo(calculateAge(b['dob']));
//         return ascending ? result : -result;
//       });
//     });
//   }
//
//   void sortUsersByCity({required bool ascending}) {
//     setState(() {
//       filteredUsers.sort((a, b) {
//         int result = a['city'].toLowerCase().compareTo(b['city'].toLowerCase());
//         return ascending ? result : -result;
//       });
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User List'),
//         backgroundColor: Color(0xFFB24592),
//         actions: [
//           PopupMenuButton<String>(
//             icon: Icon(Icons.sort), // Sort icon
//             onSelected: (value) {
//               if (value == "name_asc") {
//                 sortUsersByName(ascending: true);
//               } else if (value == "name_desc") {
//                 sortUsersByName(ascending: false);
//               } else if (value == "age_asc") {
//                 sortUsersByAge(ascending: true);
//               } else if (value == "age_desc") {
//                 sortUsersByAge(ascending: false);
//               } else if (value == "city_asc") {
//                 sortUsersByCity(ascending: true);
//               } else if (value == "city_desc") {
//                 sortUsersByCity(ascending: false);
//               }
//             },
//             itemBuilder: (context) => [
//               PopupMenuItem(value: "name_asc", child: Text("Sort by Name (A-Z)")),
//               PopupMenuItem(value: "name_desc", child: Text("Sort by Name (Z-A)")),
//               PopupMenuItem(value: "age_asc", child: Text("Sort by Age (Youngest First)")),
//               PopupMenuItem(value: "age_desc", child: Text("Sort by Age (Oldest First)")),
//               PopupMenuItem(value: "city_asc", child: Text("Sort by City (A-Z)")),
//               PopupMenuItem(value: "city_desc", child: Text("Sort by City (Z-A)")),
//             ],
//           ),
//         ],
//       ),
//
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: "Search according to your need",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.grey[160],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               onChanged: searchName,
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredUsers.length,
//               itemBuilder: (context, index) {
//                 final user = filteredUsers[index];
//                 int age = calculateAge(user['dob']);
//                 bool isFavorite = widget.favoriteUsers.contains(user);
//
//                 return Card(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.pink,
//                       child: Text(user['name'][0].toUpperCase(),
//                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                     ),
//                     title: Text(
//                       user['name'],
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     subtitle: Text("$age years | ${user['city']}",
//                         style: const TextStyle(color: Colors.grey)),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UserDetail(
//                             user: Map<String, dynamic>.from(user),
//                             onUserUpdated: (updatedUserData) {
//                               setState(() {
//                                 int index = widget.users.indexWhere((u) => u['id'] == updatedUserData['id']);
//                                 if (index != -1) {
//                                   widget.users[index] = updatedUserData;
//                                 }
//                               });
//                               loadUsers();
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             user['isFavourite'] == 1 ? Icons.favorite : Icons.favorite_border,
//                             color: user['isFavourite'] == 1 ? Colors.red : Colors.grey,
//                           ),
//                           onPressed: () => toggleFavorite(user),
//                         ),
//
//                         IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.blueAccent),
//                           onPressed: () => editUser(user),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => deleteUser(user['id']), // Ensure it passes the user ID
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:matrimony3/database_helper.dart';
import 'userDetail.dart';
import 'addUser.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserList extends StatefulWidget {
  final List<Map<String, dynamic>> users;
  final List<Map<String, dynamic>> favoriteUsers;
  final Function(List<Map<String, dynamic>>) onFavoritesUpdated;

  const UserList({
    Key? key,
    required this.users,
    required this.favoriteUsers,
    required this.onFavoritesUpdated,
  }) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = List.from(widget.users);
    loadFavorites();
    loadUsers();
  }

  void loadFavorites() async {
    List<Map<String, dynamic>> loadedUsers = await DatabaseHelper.instance.fetchUsers();
    setState(() {
      var favoriteUsers = loadedUsers.where((user) => user['isFavourite'] == 1).toSet();
    });
  }

  void loadUsers() async {
    List<Map<String, dynamic>> loadedUsers = await DatabaseHelper.instance.fetchUsers();

    setState(() {
      widget.users.clear();
      widget.users.addAll(loadedUsers);

      filteredUsers = List.from(widget.users);

      widget.favoriteUsers.clear();
      widget.favoriteUsers.addAll(
        loadedUsers.where((user) => user['isFavourite'] == 1),
      );
    });
  }

  void searchName(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = List.from(widget.users);
      } else {
        filteredUsers = widget.users.where((user) {
          int age = calculateAge(user['dob']);
          return user['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
              user['city'].toString().toLowerCase().contains(query.toLowerCase()) ||
              user['gender'].toString().toLowerCase().contains(query.toLowerCase()) ||
              user['mobile'].toString().contains(query) ||
              user['email'].toString().toLowerCase().contains(query.toLowerCase()) ||
              age.toString().contains(query);
        }).toList();
      }
    });
  }

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
          onSaveUser: (updatedUserData) async {
            await DatabaseHelper.instance.updateUser(updatedUserData);
            loadUsers(); // Reload users to update the UI
          },
          existingUser: userEdit,
        ),
      ),
    );
  }

  void deleteUser(int id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog first
                int deletedRows = await DatabaseHelper.instance.deleteUser(id);
                if (deletedRows > 0) {
                  setState(() {
                    widget.users.removeWhere((user) => user['id'] == id);
                    filteredUsers.removeWhere((user) => user['id'] == id);
                  });
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void toggleFavorite(Map<String, dynamic> user) async {
    Map<String, dynamic> updatedUser = Map<String, dynamic>.from(user);
    updatedUser['isFavourite'] = (updatedUser['isFavourite'] == 1) ? 0 : 1;

    print("Toggling favorite for user: ${updatedUser['name']} (ID: ${updatedUser['id']})");
    print("New isFavourite status: ${updatedUser['isFavourite']}");

    await DatabaseHelper.instance.updateUser(updatedUser);
    List<Map<String, dynamic>> allUsers = await DatabaseHelper.instance.fetchUsers();
    print("Updated users: $allUsers");

    setState(() {
      int index = filteredUsers.indexWhere((u) => u['id'] == user['id']);
      if (index != -1) {
        filteredUsers[index] = updatedUser;
      }

      if (updatedUser['isFavourite'] == 1) {
        if (!widget.favoriteUsers.any((u) => u['id'] == updatedUser['id'])) {
          widget.favoriteUsers.add(updatedUser);
        }
      } else {
        widget.favoriteUsers.removeWhere((u) => u['id'] == updatedUser['id']);
      }
    });

    print("Updated favorite users: ${widget.favoriteUsers}");

    widget.onFavoritesUpdated(List.from(widget.favoriteUsers));
  }

  void sortUsersByName({required bool ascending}) {
    setState(() {
      filteredUsers.sort((a, b) {
        int result = a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
        return ascending ? result : -result;
      });
    });
  }

  void sortUsersByAge({required bool ascending}) {
    setState(() {
      filteredUsers.sort((a, b) {
        int result = calculateAge(a['dob']).compareTo(calculateAge(b['dob']));
        return ascending ? result : -result;
      });
    });
  }

  void sortUsersByCity({required bool ascending}) {
    setState(() {
      filteredUsers.sort((a, b) {
        int result = a['city'].toLowerCase().compareTo(b['city'].toLowerCase());
        return ascending ? result : -result;
      });
    });
  }

  void viewUserDetail(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetail(
          user: Map<String, dynamic>.from(user),
          onUserUpdated: (updatedUserData) {
            setState(() {
              int index = widget.users.indexWhere((u) => u['id'] == updatedUserData['id']);
              if (index != -1) {
                widget.users[index] = updatedUserData;
              }
            });
            loadUsers();
          },
        ),
      ),
    );
  }

  void showSortOptions() {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 80, 0, 0),
      items: [
        PopupMenuItem(value: "name_asc", child: Text("Sort by Name (A-Z)")),
        PopupMenuItem(value: "name_desc", child: Text("Sort by Name (Z-A)")),
        PopupMenuItem(value: "age_asc", child: Text("Sort by Age (Youngest First)")),
        PopupMenuItem(value: "age_desc", child: Text("Sort by Age (Oldest First)")),
        PopupMenuItem(value: "city_asc", child: Text("Sort by City (A-Z)")),
        PopupMenuItem(value: "city_desc", child: Text("Sort by City (Z-A)")),
      ],
    ).then((value) {
      if (value == "name_asc") {
        sortUsersByName(ascending: true);
      } else if (value == "name_desc") {
        sortUsersByName(ascending: false);
      } else if (value == "age_asc") {
        sortUsersByAge(ascending: true);
      } else if (value == "age_desc") {
        sortUsersByAge(ascending: false);
      } else if (value == "city_asc") {
        sortUsersByCity(ascending: true);
      } else if (value == "city_desc") {
        sortUsersByCity(ascending: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List', style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Color(0xFFB24592), // Changed to the requested color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Removed the sort button from app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color(0xFFB24592), // Changed to the requested color
              Color(0xFFF3E5F5), // Light purple/pink at bottom
            ],
          ),
        ),
        child: Column(
          children: [
            // Search bar with rounded corners
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search Here",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.tune, color: Colors.grey),
                      onPressed: showSortOptions,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onChanged: searchName,
                ),
              ),
            ),
            // User list
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  int age = calculateAge(user['dob']);
                  String gender = user['gender'] ?? 'Unknown';
                  String location = user['city'] ?? 'Unknown';

                  return GestureDetector(
                    onTap: () => viewUserDetail(user), // Added onTap to view user details
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Avatar with first letter
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Color(0xFFB24592),
                                  child: Text(
                                    user['name']?.isNotEmpty == true
                                        ? user['name'][0].toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                // User info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Name
                                      Text(
                                        user['name'] ?? 'Unknown',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFB24592),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      // Gender tag
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              gender.toLowerCase() == 'male'
                                                  ? Icons.male
                                                  : gender.toLowerCase() == 'female'
                                                  ? Icons.female
                                                  : Icons.transgender, // Added transgender icon for other genders
                                              size: 16,
                                              color: gender.toLowerCase() == 'male'
                                                  ? Colors.blue
                                                  : gender.toLowerCase() == 'female'
                                                  ? Colors.pink
                                                  : Colors.purple, // Assigned purple color for transgender
                                            ),

                                            SizedBox(width: 4),
                                            Text(
                                              gender,
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      // Location and age
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              size: 16, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            location,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            " • $age years",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            // Row for Edit, Delete, and Favorite buttons
                            Row(
                              children: [
                                // Edit button
                                Expanded(
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.edit, color: Colors.green),
                                    label: Text("Edit",
                                        style: TextStyle(color: Colors.green)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFE8F5E9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                    ),
                                    onPressed: () => editUser(user),
                                  ),
                                ),
                                SizedBox(width: 12),
                                // Delete button
                                Expanded(
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    label: Text("Delete",
                                        style: TextStyle(color: Colors.red)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFCE4EC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                    ),
                                    onPressed: () => deleteUser(user['id']),
                                  ),
                                ),
                                SizedBox(width: 12),
                                // Favorite button
                                Container(
                                  decoration: BoxDecoration(
                                    color: user['isFavourite'] == 1 ? Color(0xFFFFEBEE) : Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      user['isFavourite'] == 1
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: user['isFavourite'] == 1
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () => toggleFavorite(user),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}