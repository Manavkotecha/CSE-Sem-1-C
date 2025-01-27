import 'package:flutter/material.dart';

class Toggle_date extends StatefulWidget {
  const Toggle_date({super.key});

  @override
  State<Toggle_date> createState() => _Toggle_dateState();
}

class _Toggle_dateState extends State<Toggle_date> {
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {

                isGridView = !isGridView;
              });
            },
            icon: Icon(Icons.change_circle_rounded),
          ),
        ],
        title: Text("Toggle View"),
      ),
      body: Container(
        child: isGridView
            ? GridView.builder(
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.yellowAccent,
              ),
            );
          },
        )
            : ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                color: Colors.yellowAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}
