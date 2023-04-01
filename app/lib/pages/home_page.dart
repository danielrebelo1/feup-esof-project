import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

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
  List topRatedMovies = [];
  final String apikey = '51b20269b73105d2fd84257214e53cc3';
  final readAcessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MWIyMDI2OWI3MzEwNWQyZmQ4NDI1NzIxNGU1M2NjMyIsInN1YiI6IjY0MjdmZGU4OWNjNjdiMDViZjZlZWZmMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rXi6vsFhTtCqdUNv2UPukvqW5_D3wUbnTlamH8UzhA4';


  int _currentIndex = 0;

  void _incrementIndex() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % topRatedMovies.length;
    });
  }

  void _decrementIndex() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % topRatedMovies.length;
    });
  }

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    try {
      TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readAcessToken),
          logConfig: ConfigLogger(
            showLogs: true,
            showErrorLogs: true,
          ));
      Map moviesResults = await tmdbWithCustomLogs.v3.movies.getTopRated();

      setState(() {
        topRatedMovies = moviesResults['results'];
      });
      print(topRatedMovies);
    } catch (e) {
      print('Error occurred while loading movies: $e');
    }
  }

  /*TESTE*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      bottomNavigationBar: CustomNavBar(
        email: widget.email,
        password: widget.password,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 5,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  _currentIndex - 1 < 0
                      ? topRatedMovies.isEmpty
                      ? ''
                      : 'https://image.tmdb.org/t/p/w500' +
                      topRatedMovies[topRatedMovies.length - 1]
                      ['poster_path']
                      : 'https://image.tmdb.org/t/p/w500' +
                      topRatedMovies[_currentIndex - 1]['poster_path'],
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
                child: topRatedMovies.isEmpty ||
                    _currentIndex + 1 >= topRatedMovies.length
                    ? SizedBox.shrink()
                    : Image.network(
                  'https://image.tmdb.org/t/p/w500' +
                      topRatedMovies[_currentIndex + 1]['poster_path'],
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
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoviePage(
                                email: widget.email,
                                password: widget.password,
                                topRatedMovies: topRatedMovies,
                                currentIndex: _currentIndex,
                              )),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: topRatedMovies.isNotEmpty
                              ? DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' +
                                    topRatedMovies[_currentIndex]
                                    ['poster_path']),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01),
                            child: topRatedMovies.isNotEmpty
                                ? Text(
                              topRatedMovies[_currentIndex]
                              ['original_title'],
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                MediaQuery.of(context).size.height *
                                    0.03,
                              ),
                            )
                                : SizedBox.shrink(),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 15,
                                top:
                                MediaQuery.of(context).size.height * 0.008),
                            child: Text(
                              topRatedMovies.isNotEmpty &&
                                  topRatedMovies[_currentIndex]
                                      .containsKey('release_date')
                                  ? topRatedMovies[_currentIndex]
                              ['release_date']
                                  .toString()
                                  .substring(0, 4)
                                  : '',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0001),
                      child: Text(
                        topRatedMovies.isNotEmpty &&
                            topRatedMovies[_currentIndex]
                                .containsKey('vote_average')
                            ? topRatedMovies[_currentIndex]['vote_average']
                            .toString()
                            : '',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
