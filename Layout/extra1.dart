import 'package:flutter/material.dart';

class Layout4 extends StatelessWidget {
  const Layout4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: Container(color: Colors.pink)), // changed to pink
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(child: Container(color: Colors.amber)), // changed to amber
                            Expanded(child: Container(color: Colors.cyan)) // changed to cyan
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(child: Container(color: Colors.deepOrange)), // changed to deep orange
                            Expanded(child: Container(color: Colors.lime)) // changed to lime
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: Container(color: Colors.indigo)), // changed to indigo
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(child: Container(color: Colors.brown)), // changed to brown
                            Expanded(child: Container(color: Colors.purpleAccent)), // changed to purpleAccent
                            Expanded(child: Container(color: Colors.greenAccent)) // changed to greenAccent
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(flex: 2, child: Container(color: Colors.orange)), // changed to orange
                            Expanded(flex: 2, child: Container(color: Colors.tealAccent)), // changed to tealAccent
                            Expanded(child: Container(color: Colors.blueGrey)) // changed to blueGrey
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(child: Container(color: Colors.blue)), // changed to blue
                            Expanded(flex: 3, child: Container(color: Colors.purple)), // changed to purple
                            Expanded(flex: 2, child: Container(color: Colors.yellowAccent)) // changed to yellowAccent
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container(color: Colors.green)) // changed to green
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: Container(color: Colors.teal)), // changed to teal
                Expanded(child: Container(color: Colors.red)), // changed to red
                Expanded(child: Container(color: Colors.lightGreen)) // changed to lightGreen
              ],
            ),
          ),
        ],
      ),
    );
  }
}
