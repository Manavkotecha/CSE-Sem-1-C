import 'package:flutter/material.dart';

class TabList extends StatelessWidget {
  const TabList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Title"),
          bottom: const TabBar(
            tabs: [
              Tab(child: Text("First")),
              Tab(child: Text("Second")),
              Tab(child: Text("Third")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.cyan[600],
                  child: const Center(child: Text(' A')),
                ),
                Container(
                  height: 50,
                  color: Colors.cyan[500],
                  child: const Center(child: Text(' B')),
                ),
                Container(
                  height: 50,
                  color: Colors.cyan[300],
                  child: const Center(child: Text(' C')),
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.green[600],
                  child: const Center(child: Text(' 1')),
                ),
                Container(
                  height: 50,
                  color: Colors.green[500],
                  child: const Center(child: Text(' 2')),
                ),
                Container(
                  height: 50,
                  color: Colors.green[300],
                  child: const Center(child: Text(' 3')),
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text(' T')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text(' M')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[300],
                  child: const Center(child: Text(' Z')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
