import 'package:flutter/material.dart';

class Layout6 extends StatelessWidget {
  const Layout6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(flex: 3, child: Container(color: Colors.red)),
                Expanded(child: Container(color: Colors.green[300])),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Expanded(child: Container(color: Colors.blue)),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: Container(color: Colors.purple)),
                                  Expanded(child: Container(color: Colors.orange)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: Container(color: Colors.pink)),
                                  Expanded(child: Container(color: Colors.teal)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container(color: Colors.amber)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Expanded(child: Container(color: Colors.black)),
                Expanded(child: Container(color: Colors.white)),
                Expanded(child: Container(color: Colors.black)),
                Expanded(child: Container(color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: Container(color: Colors.deepPurple)),
                                  Expanded(child: Container(color: Colors.lightBlue)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(child: Container(color: Colors.lightGreen)),
                                              Expanded(child: Container(color: Colors.yellowAccent)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(child: Container(color: Colors.cyanAccent)),
                                              Expanded(child: Container(color: Colors.indigoAccent)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container(color: Colors.green)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container(color: Colors.purpleAccent)),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(child: Container(color: Colors.blueGrey)),
                      Expanded(child: Container(color: Colors.deepOrange)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(child: Container(color: Colors.lightGreen)),
                                        Expanded(child: Container(color: Colors.yellowAccent)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(child: Container(color: Colors.cyanAccent)),
                                        Expanded(child: Container(color: Colors.indigoAccent)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container(color: Colors.orangeAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
