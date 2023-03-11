import 'dart:ui';

import 'package:flutter/material.dart';
import 'movie_model.dart';
import 'profile_page.dart';
import 'search_page.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<MovieModel> _movies = [
    MovieModel("La la land", "2016", 8, "assets/llland.png"),
    MovieModel("Inception", "2010", 8.8, "assets/inception.png"),
    MovieModel("Silence of the Lambs", "1991", 8.6, "assets/silenceLambs.png"),
    MovieModel("Incendies", "2010", 8.3, "assets/Incendies.png")
  ];
  int _currentIndex = 0;

  void _incrementIndex() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _movies.length;
    });
  }

  void _decrementIndex() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % _movies.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 5,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: Container(
                width: 65,
                height: 65,
                color: Colors.transparent,
                child: Image.asset(
                  'assets/profile-icon.png',
                  width: 65.0,
                  height: 65.0,
                ),
              ),
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
            right: 170,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
              child: Container(
                width: 65,
                height: 65,
                color: Colors.transparent,
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 5,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  _currentIndex - 1 < 0
                    ? _movies[_movies.length - 1].moviePoster
                    : _movies[_currentIndex - 1].moviePoster,
                  width: 120,
                  height: 170,
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: 5,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(

                  _currentIndex + 1 == _movies.length
                    ?_movies[0].moviePoster
                    :_movies[_currentIndex + 1].moviePoster,

                  width: 120,
                  height: 170,
                ),
              ),
            ),
          ),



          Center(
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity! > 0) {
                  _decrementIndex();
                } else if (details.primaryVelocity! < 0) {
                  _incrementIndex();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(_movies[_currentIndex].moviePoster),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Text(
                          _movies[_currentIndex].movieTitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15, top: 15),
                        child: Text(
                          _movies[_currentIndex].movieReleaseYear,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          )
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      _movies[_currentIndex].rating.toString(),
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
