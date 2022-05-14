import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ceiba',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
    );
  }
}
