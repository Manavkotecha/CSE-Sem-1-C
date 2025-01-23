import 'package:flutter/material.dart';

class CRUD extends StatefulWidget {
  const CRUD({super.key});

  @override
  State<CRUD> createState() => _myCodeState();
}

class _myCodeState extends State<CRUD> {
  TextEditingController nameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<String> filterName = [];
  List<String> name = [];
  String? selectName;

  void createName() {
    if (nameController.text.isNotEmpty) {
      setState(() {
        name.add(nameController.text);
        filterName = List.from(name);
        nameController.clear();
      });
    }
  }

  void deleteName(String nameToRemove) {
    setState(() {
      name.remove(nameToRemove);
      filterName = List.from(name);
      if (selectName == nameToRemove) {
        selectName = null;
        nameController.clear();
      }
    });
  }

  void searchName(String query) {
    setState(() {
      if (query.isEmpty) {
        filterName = List.from(name);
      } else {
        filterName = name
            .where((name) => name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void showEditDialog(String selectedName) {
    final TextEditingController tempController =
    TextEditingController(text: selectedName);
    final index = name.indexOf(selectedName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Name"),
          content: TextField(
            controller: tempController,
            decoration: InputDecoration(
                labelText: "Enter New Name", border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without saving
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (tempController.text.isNotEmpty && index != -1) {
                  setState(() {
                    name[index] = tempController.text;
                    filterName = List.from(name); // Update filtered list
                  });
                }
                Navigator.pop(context); // Close the dialog after saving
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(String nameToRemove) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Name"),
          content: Text("Are you sure you want to delete \"$nameToRemove\"?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                deleteName(nameToRemove);
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MY CODE")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: "Enter Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                  labelText: "Search",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder()),
              onChanged: searchName,
            ),
            SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: createName, child: Text("ADD")),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filterName.length,
                itemBuilder: (context, index) {
                  final names = filterName[index];
                  return ListTile(
                    title: Text(names),
                    onTap: () {
                      setState(() {
                        selectName = names;
                        nameController.text = names;
                      });
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => showEditDialog(names),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => showDeleteDialog(names),
                        ),
                      ],
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
