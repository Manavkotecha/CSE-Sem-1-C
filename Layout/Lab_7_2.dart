
import 'package:flutter/material.dart';

class Lab7_2 extends StatelessWidget {
  const Lab7_2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Center(
          child:bText(
            m: "Manav Kotecha"
          )
        ),
    );
  }
}

Widget bText({required m}){
  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Text(m,style: TextStyle(
        color: Colors.yellowAccent,
        backgroundColor: Colors.black,
        fontSize: 21,
      ),),
    ),
  );
}
