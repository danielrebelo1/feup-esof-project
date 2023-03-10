import 'package:flutter/material.dart';
import 'profile-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // set to false to remove debug banner
      home: Scaffold(
        body: MyHomePage(title: "myApp"),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 5,
          left: 0,
          child: Image.asset(
            'assets/profile-icon.png',
            width: 65.0,
            height: 65.0,
          ),
        ),
        Positioned(
          bottom: -5,
          right: -15,
          child: Image.asset(
            'assets/logo.png',
            width: 90.0,
            height: 90.0,
          ),
        ),
        Positioned(
          bottom: 5,
          left: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: Container(
              width: 65,
              height: 65,
              color: Colors.transparent,
            ),
          ),
        ),
      ],
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
        backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
        body:
            ImageWidget() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
