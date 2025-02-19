import 'package:flutter/material.dart';
import 'aboutUs.dart';
import 'favoriteUser.dart';
import 'addUser.dart';
import 'userList.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Map<String, dynamic>> users = [];
  final List<Map<String, dynamic>> favoriteUsers = [];

  void updateFavorites(List<Map<String, dynamic>> updatedFavorites) {
    setState(() {
      favoriteUsers.clear();
      favoriteUsers.addAll(updatedFavorites);
    });
    print("Dashboard updated favorite users: $favoriteUsers");
  }

  void addUser(Map<String, dynamic> newUser) {
    setState(() {
      users.add(newUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB24592), Color(0xFFF15F79)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Column(
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100), // Circular Image
                      child: Image.asset(
                        'assets/images/heart.jpeg',
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover, // Ensures image fits properly
                      ),
                    ),
                    const SizedBox(height: 12), // Spacing
                    const Text(
                      'Forever Together',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black45,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Find your perfect match with us',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Main Content Section
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      buildCard(Icons.person_add, 'Add Profile', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddUser(onSaveUser: addUser),
                          ),
                        );
                      }),
                      buildCard(Icons.list, 'Browse Profiles', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserList(
                              users: users,
                              favoriteUsers: favoriteUsers,
                              onFavoritesUpdated: updateFavorites,
                            ),
                          ),
                        );
                      }),
                      buildCard(Icons.favorite, 'Favorites', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavouriteUser(
                              favoriteUsers: favoriteUsers,
                              onFavoriteUpdate: updateFavorites,
                            ),
                          ),
                        );
                      }),
                      buildCard(Icons.info, 'About Us', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Aboutus(),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Method to Build Cards for Navigation
  Widget buildCard(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFFAFAFA),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: const Color(0xFFB24592)),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
