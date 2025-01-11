import 'package:flutter/material.dart';

class Layout5 extends StatelessWidget {
  const Layout5({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
    body:Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children:<Widget> [
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.green)),
                  Expanded(child: Container(color: Colors.blue))

                ],
              )

            ),
            Expanded(
              child: Column(
                children:<Widget> [
                  Expanded(flex:2,child: Container(color: Colors.brown)),
                  Expanded(flex:2,child: Container(color: Colors.lightBlueAccent)),
                  Expanded(child: Container(color: Colors.purple))
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container(color: Colors.black)),
                  Expanded(flex:3,child: Container(color: Colors.redAccent)),
                  Expanded(flex:2,child: Container(color: Colors.orangeAccent))
                ],
              ),
            )

        ],
      )
      );
  }
}

