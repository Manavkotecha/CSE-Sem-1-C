// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'database_helper.dart';
// //
// // class FavouriteUser extends StatefulWidget {
// //   final List<Map<String, dynamic>> favoriteUsers;
// //   final Function(List<Map<String, dynamic>>) onFavoriteUpdate;
// //
// //   const FavouriteUser({super.key, required this.favoriteUsers, required this.onFavoriteUpdate});
// //
// //   @override
// //   _FavouriteUserState createState() => _FavouriteUserState();
// // }
// //
// // class _FavouriteUserState extends State<FavouriteUser> {
// //   late Set<Map<String, dynamic>> favoriteUsers;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     favoriteUsers = widget.favoriteUsers.toSet();
// //   }
// //
// //   void _updateFavoriteUsers(List<Map<String, dynamic>> updatedFavorites) {
// //     setState(() {
// //       favoriteUsers = updatedFavorites.toSet();
// //     });
// //   }
// //
// //   void toggleFavorite(Map<String, dynamic> user) async {
// //     Map<String, dynamic> updatedUser = Map<String, dynamic>.from(user);
// //     updatedUser['isFavourite'] = (updatedUser['isFavourite'] == 1) ? 0 : 1;
// //
// //     print("Toggling favorite in favoriteUser.dart for: ${updatedUser['name']} (ID: ${updatedUser['id']})");
// //
// //     await DatabaseHelper.instance.updateUser(updatedUser);
// //
// //     setState(() {
// //       favoriteUsers.removeWhere((u) => u['id'] == updatedUser['id']);
// //       if (updatedUser['isFavourite'] == 1) {
// //         favoriteUsers.add(updatedUser);
// //       }
// //     });
// //
// //     print("Updated favorite users in favoriteUser.dart: $favoriteUsers");
// //
// //     widget.onFavoriteUpdate(favoriteUsers.toList());
// //   }
// //
// //   int calculateAge(String dob) {
// //     try {
// //       DateTime birthDate = DateFormat('dd/MM/yyyy').parse(dob);
// //       DateTime currentDate = DateTime.now();
// //       int age = currentDate.year - birthDate.year;
// //       if (currentDate.month < birthDate.month ||
// //           (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
// //         age--;
// //       }
// //       return age;
// //     } catch (e) {
// //       return -1;
// //     }
// //   }
// //
// //   // ✅ **Remove the extra @override here**
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Favourite Users"),
// //         backgroundColor: Colors.pinkAccent,
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: favoriteUsers.isEmpty
// //                 ? const Center(child: Text("No Favorite Users"))
// //                 : ListView.builder(
// //               itemCount: favoriteUsers.length,
// //               itemBuilder: (context, index) {
// //                 final user = favoriteUsers.elementAt(index);
// //                 int age = calculateAge(user['dob']); // Calculate age
// //
// //                 return Card(
// //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //                   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //                   child: ListTile(
// //                     leading: CircleAvatar(
// //                       backgroundColor: Colors.pink,
// //                       child: Text(
// //                         user['name'][0].toUpperCase(),
// //                         style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
// //                       ),
// //                     ),
// //                     title: Text(
// //                       user['name'],
// //                       style: const TextStyle(fontWeight: FontWeight.bold),
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                     subtitle: Text("$age years | ${user['city']}",
// //                         style: const TextStyle(color: Colors.grey)),
// //                     trailing: IconButton(
// //                       icon: Icon(
// //                         user['isFavourite'] == 1 ? Icons.favorite : Icons.favorite_border,
// //                         color: user['isFavourite'] == 1 ? Colors.red : Colors.grey,
// //                       ),
// //                       onPressed: () => toggleFavorite(user),
// //                     ),
// //
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:matrimony3/userDetail.dart';
// import 'database_helper.dart';
//
// class FavouriteUser extends StatefulWidget {
//   final List<Map<String, dynamic>> favoriteUsers;
//   final Function(List<Map<String, dynamic>>) onFavoriteUpdate;
//
//   const FavouriteUser({super.key, required this.favoriteUsers, required this.onFavoriteUpdate});
//
//   @override
//   _FavouriteUserState createState() => _FavouriteUserState();
// }
//
// class _FavouriteUserState extends State<FavouriteUser> {
//   late List<Map<String, dynamic>> favoriteUsers; // ✅ Use List instead of Set
//
//   @override
//   void initState() {
//     super.initState();
//     favoriteUsers = List<Map<String, dynamic>>.from(widget.favoriteUsers); // ✅ Ensure mutability
//   }
//
//   void toggleFavorite(Map<String, dynamic> user) async {
//     Map<String, dynamic> updatedUser = Map<String, dynamic>.from(user);
//     updatedUser['isFavourite'] = (updatedUser['isFavourite'] == 1) ? 0 : 1;
//
//     print("Toggling favorite in favoriteUser.dart for: ${updatedUser['name']} (ID: ${updatedUser['id']})");
//
//     await DatabaseHelper.instance.updateUser(updatedUser);
//
//     setState(() {
//       favoriteUsers = List.from(favoriteUsers); // ✅ Ensure mutable before modifying
//       favoriteUsers.removeWhere((u) => u['id'] == updatedUser['id']);
//       if (updatedUser['isFavourite'] == 1) {
//         favoriteUsers.add(updatedUser);
//       }
//     });
//
//     print("Updated favorite users in favoriteUser.dart: $favoriteUsers");
//
//     widget.onFavoriteUpdate(favoriteUsers);
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Favourite Users"),
//         backgroundColor: Color(0xFFB24592),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: favoriteUsers.isEmpty
//                 ? const Center(child: Text("No Favorite Users"))
//                 : ListView.builder(
//               itemCount: favoriteUsers.length,
//               itemBuilder: (context, index) {
//                 final user = favoriteUsers[index]; // ✅ Use list indexing
//                 int age = calculateAge(user['dob']); // Calculate age
//
//                 return Card(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.pink,
//                       child: Text(
//                         user['name'][0].toUpperCase(),
//                         style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     title: Text(
//                       user['name'],
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     subtitle: Text("$age years | ${user['city']}",
//                         style: const TextStyle(color: Colors.grey)),
//                     trailing: IconButton(
//                       icon: Icon(
//                         user['isFavourite'] == 1 ? Icons.favorite : Icons.favorite_border,
//                         color: user['isFavourite'] == 1 ? Colors.red : Colors.grey,
//                       ),
//                       onPressed: () => toggleFavorite(user),
//                     ),
//                     onTap: () {
//                       // ✅ Navigate to UserDetail on tap
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UserDetail(
//                             user: user,
//                             onUserUpdated: (updatedUser) {
//                               setState(() {
//                                 favoriteUsers.removeWhere((u) => u['id'] == updatedUser['id']);
//                                 if (updatedUser['isFavourite'] == 1) {
//                                   favoriteUsers.add(updatedUser);
//                                 }
//                               });
//                               widget.onFavoriteUpdate(favoriteUsers);
//                             },
//                           ),
//                         ),
//                       );
//                     },
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



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony3/userDetail.dart';
import 'database_helper.dart';

class FavouriteUser extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteUsers;
  final Function(List<Map<String, dynamic>>) onFavoriteUpdate;

  const FavouriteUser({super.key, required this.favoriteUsers, required this.onFavoriteUpdate});

  @override
  _FavouriteUserState createState() => _FavouriteUserState();
}

class _FavouriteUserState extends State<FavouriteUser> {
  late List<Map<String, dynamic>> favoriteUsers;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    favoriteUsers = List<Map<String, dynamic>>.from(widget.favoriteUsers);
    filteredUsers = List<Map<String, dynamic>>.from(favoriteUsers);
  }

  void searchName(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = List.from(favoriteUsers);
      } else {
        filteredUsers = favoriteUsers.where((user) {
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

  void toggleFavorite(Map<String, dynamic> user) async {
    Map<String, dynamic> updatedUser = Map<String, dynamic>.from(user);
    updatedUser['isFavourite'] = (updatedUser['isFavourite'] == 1) ? 0 : 1;

    print("Toggling favorite in favoriteUser.dart for: ${updatedUser['name']} (ID: ${updatedUser['id']})");

    await DatabaseHelper.instance.updateUser(updatedUser);

    setState(() {
      favoriteUsers.removeWhere((u) => u['id'] == updatedUser['id']);
      filteredUsers.removeWhere((u) => u['id'] == updatedUser['id']);
      if (updatedUser['isFavourite'] == 1) {
        favoriteUsers.add(updatedUser);
        filteredUsers.add(updatedUser);
      }
    });

    print("Updated favorite users in favoriteUser.dart: $favoriteUsers");

    widget.onFavoriteUpdate(favoriteUsers);
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

  void viewUserDetail(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetail(
          user: Map<String, dynamic>.from(user),
          onUserUpdated: (updatedUser) {
            setState(() {
              int index = favoriteUsers.indexWhere((u) => u['id'] == updatedUser['id']);
              if (index != -1 && updatedUser['isFavourite'] == 1) {
                favoriteUsers[index] = updatedUser;
                int filteredIndex = filteredUsers.indexWhere((u) => u['id'] == updatedUser['id']);
                if (filteredIndex != -1) {
                  filteredUsers[filteredIndex] = updatedUser;
                }
              } else if (updatedUser['isFavourite'] == 0) {
                favoriteUsers.removeWhere((u) => u['id'] == updatedUser['id']);
                filteredUsers.removeWhere((u) => u['id'] == updatedUser['id']);
              }
            });
            widget.onFavoriteUpdate(favoriteUsers);
          },
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Users', style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Color(0xFFB24592),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sort, color: Colors.white),
            onPressed: () {
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
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color(0xFFB24592),
              Color(0xFFF3E5F5),
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
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onChanged: searchName,
                ),
              ),
            ),
            // User list
            Expanded(
              child: filteredUsers.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Color(0xFFB24592).withOpacity(0.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "No Favourite Users",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB24592),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Add users to favorites from the main list",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: filteredUsers.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  int age = calculateAge(user['dob']);
                  String gender = user['gender'] ?? 'Unknown';
                  String location = user['city'] ?? 'Unknown';

                  return GestureDetector(
                    onTap: () => viewUserDetail(user),
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
                                                  : Icons.female,
                                              size: 16,
                                              color: gender.toLowerCase() == 'male'
                                                  ? Colors.blue
                                                  : Colors.pink,
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
                            // Button row
                            Row(
                              children: [
                                // View Details button
                                Expanded(
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.visibility, color: Color(0xFFB24592)),
                                    label: Text("View Details",
                                        style: TextStyle(color: Color(0xFFB24592))),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFF3E5F5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                    ),
                                    onPressed: () => viewUserDetail(user),
                                  ),
                                ),
                                SizedBox(width: 12),
                                // Remove from favorites button
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFEBEE),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
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