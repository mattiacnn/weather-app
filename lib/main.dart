import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/setUpPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weather app",
        theme: ThemeData(primaryColor: Colors.red),
        home: SetUpPage(),
      );
}
