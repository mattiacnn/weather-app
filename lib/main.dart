import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'JONATHAN '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://i.pinimg.com/564x/4e/22/57/4e2257ce54d1359137c6f15b0d16b3ec.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 60.0, left: 40.0),
                        child: Row(
                          children: const [
                            Text(
                              "Tuscany",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.normal),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white70,
                                size: 20.0,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30.0, left: 30.0),
                      child: const Text(
                        "23°",
                        style: TextStyle(
                            fontSize: 140,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 250,
                          padding: EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Weather today",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Column(
                                            children: [
                                              Icon(Icons.sunny,
                                                  color: Colors.yellow.shade700,
                                                  size: 40.0),
                                              Text("05:00 AM",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors
                                                          .grey.shade400)),
                                              Text("16°",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Column(
                                            children: [
                                              Icon(Icons.cloud,
                                                  color: Colors.grey.shade500,
                                                  size: 40.0),
                                              Text("08:00 AM",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors
                                                          .grey.shade400)),
                                              Text("14°",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Column(
                                            children: [
                                              Icon(Icons.thunderstorm,
                                                  color: Colors.grey.shade500,
                                                  size: 40.0),
                                              Text("10:00 AM",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors
                                                          .grey.shade400)),
                                              Text("16°",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            )));
  }
}
