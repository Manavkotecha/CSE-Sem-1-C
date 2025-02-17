import 'package:matrimony/database_helper.dart';
import 'userDetail.dart';
import 'addUser.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/database_helper.dart';


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
        // Reset the list to the latest loaded users
        filteredUsers = List.from(widget.users);
      } else {
        filteredUsers = widget.users.where((user) {
          int age = calculateAge(user['dob']);
          return user['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort), // Sort icon
            onSelected: (value) {
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
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: "name_asc", child: Text("Sort by Name (A-Z)")),
              PopupMenuItem(value: "name_desc", child: Text("Sort by Name (Z-A)")),
              PopupMenuItem(value: "age_asc", child: Text("Sort by Age (Youngest First)")),
              PopupMenuItem(value: "age_desc", child: Text("Sort by Age (Oldest First)")),
              PopupMenuItem(value: "city_asc", child: Text("Sort by City (A-Z)")),
              PopupMenuItem(value: "city_desc", child: Text("Sort by City (Z-A)")),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search according to your need",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.pink[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: searchName,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                int age = calculateAge(user['dob']);
                bool isFavorite = widget.favoriteUsers.contains(user);

                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Text(user['name'][0].toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(
                      user['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text("$age years | ${user['city']}",
                        style: const TextStyle(color: Colors.grey)),
                    onTap: () {
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
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            user['isFavourite'] == 1 ? Icons.favorite : Icons.favorite_border,
                            color: user['isFavourite'] == 1 ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => toggleFavorite(user),
                        ),

                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () => editUser(user),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteUser(user['id']), // Ensure it passes the user ID
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}