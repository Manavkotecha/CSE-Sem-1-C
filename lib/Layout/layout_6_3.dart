import 'package:flutter/material.dart';

class Layout3 extends StatelessWidget {
  const Layout3({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
    body:Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children:<Widget> [
                  Expanded(child: Container(color: Colors.red))

                ],
              )

            ),
            Expanded(
              child: Row(
                children:<Widget> [
                  Expanded(
                    flex:2,
                    child: Column(
                      children: [
                        Expanded(child: Container(color: Colors.lightBlueAccent)),
                      ],
                    ),
                  ),
                  Expanded(child: Column(
                    children: <Widget>[
                     Expanded(child: Container(color: Colors.purple)),
                      Expanded(child: Container(color: Colors.white))
                    ],
                  ))
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
      )
      );
  }
}

