import 'dart:ui';
import 'package:flutter/material.dart';

import '../reusableWidgets/movie_model.dart';
import '../reusableWidgets/custom_nav_bar.dart';
import 'movie_page.dart';


class MyHomePage extends StatefulWidget {
  final String email;
  final String password;

  const MyHomePage({Key? key, required this.email, required this.password})
      : super(key: key);

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
      bottomNavigationBar: CustomNavBar(email: widget.email, password: widget.password,),
      body: Stack(
        children: <Widget>[

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
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.3,
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

                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.3,
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
              child: Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MoviePage(email: widget.email, password: widget.email,)),
                        );
                      },
                      child:Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(_movies[_currentIndex].moviePoster),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                          child: Text(
                            _movies[_currentIndex].movieTitle,
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, top: MediaQuery.of(context).size.height * 0.008),
                          child: Text(
                              _movies[_currentIndex].movieReleaseYear,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: MediaQuery.of(context).size.height * 0.02,
                              )
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0001),
                      child: Text(
                        _movies[_currentIndex].rating.toString(),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
