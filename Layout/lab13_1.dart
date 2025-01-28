import 'package:flutter/material.dart';

class BottomSheet2 extends StatefulWidget {
  const BottomSheet2({super.key});

  @override
  State<BottomSheet2> createState() => _BottomSheet2State();
}


class _BottomSheet2State extends State<BottomSheet2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Snack Bar"),),
      body: ModalBottomSheetDemo(),

    );
  }
}

class ModalBottomSheetDemo extends StatelessWidget {
  const ModalBottomSheetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          // when raised button is pressed
          // we display showModalBottomSheet
          showModalBottomSheet<void>(
            // context and builder are
            // required properties in this widget
            context: context,
            builder: (BuildContext context) {

              return const SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text('HELLO USERS'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}




