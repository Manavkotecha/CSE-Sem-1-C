import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(child: Container(color: Colors.red)),
                Expanded(child: Container(color: Colors.green)),
                Expanded(child: Container(color: Colors.blue))
              ],
            )),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: Container(color: Colors.brown)),
                  Expanded(child: Container(color: Colors.lightBlueAccent)),
                  Expanded(child: Container(color: Colors.purple))
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: Container(color: Colors.black)),
                  Expanded(child: Container(color: Colors.redAccent)),
                  Expanded(child: Container(color: Colors.orangeAccent))
                ],
              ),
            )
          ],
        ));
  }
}
