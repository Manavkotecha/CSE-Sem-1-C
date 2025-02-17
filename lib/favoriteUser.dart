import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';

class FavouriteUser extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteUsers;
  final Function(List<Map<String, dynamic>>) onFavoriteUpdate;

  const FavouriteUser({super.key, required this.favoriteUsers, required this.onFavoriteUpdate});

  @override
  _FavouriteUserState createState() => _FavouriteUserState();
}

class _FavouriteUserState extends State<FavouriteUser> {
  late Set<Map<String, dynamic>> favoriteUsers;

  @override
  void initState() {
    super.initState();
    favoriteUsers = widget.favoriteUsers.toSet();
  }

  void _updateFavoriteUsers(List<Map<String, dynamic>> updatedFavorites) {
    setState(() {
      favoriteUsers = updatedFavorites.toSet();
    });
  }

  void toggleFavorite(Map<String, dynamic> user) async {
    Map<String, dynamic> updatedUser = Map<String, dynamic>.from(user);
    updatedUser['isFavourite'] = (updatedUser['isFavourite'] == 1) ? 0 : 1;

    print("Toggling favorite in favoriteUser.dart for: ${updatedUser['name']} (ID: ${updatedUser['id']})");

    await DatabaseHelper.instance.updateUser(updatedUser);

    setState(() {
      favoriteUsers.removeWhere((u) => u['id'] == updatedUser['id']);
      if (updatedUser['isFavourite'] == 1) {
        favoriteUsers.add(updatedUser);
      }
    });

    print("Updated favorite users in favoriteUser.dart: $favoriteUsers");

    widget.onFavoriteUpdate(favoriteUsers.toList());
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

  // ✅ **Remove the extra @override here**
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Users"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: favoriteUsers.isEmpty
                ? const Center(child: Text("No Favorite Users"))
                : ListView.builder(
              itemCount: favoriteUsers.length,
              itemBuilder: (context, index) {
                final user = favoriteUsers.elementAt(index);
                int age = calculateAge(user['dob']); // Calculate age

                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Text(
                        user['name'][0].toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      user['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text("$age years | ${user['city']}",
                        style: const TextStyle(color: Colors.grey)),
                    trailing: IconButton(
                      icon: Icon(
                        user['isFavourite'] == 1 ? Icons.favorite : Icons.favorite_border,
                        color: user['isFavourite'] == 1 ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => toggleFavorite(user),
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