import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project/reusableWidgets/movie_model.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:http/http.dart' as http;
import 'utelly-api.dart';
import '../reusableWidgets/custom_nav_bar.dart';
import 'movie_page.dart';

class MyHomePage extends StatefulWidget {
  final String email;
  final String username;
  final String password;

  const MyHomePage({Key? key, required this.email, required this.username, required this.password})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> displayMovies = [];
  final String apikey = '51b20269b73105d2fd84257214e53cc3';
  final readAcessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MWIyMDI2OWI3MzEwNWQyZmQ4NDI1NzIxNGU1M2NjMyIsInN1YiI6IjY0MjdmZGU4OWNjNjdiMDViZjZlZWZmMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rXi6vsFhTtCqdUNv2UPukvqW5_D3wUbnTlamH8UzhA4';
  int page_number = 1;
  int _currentIndex = 0;
  String methodName = 'getTopRatedMovies';
  int _buttonPressedIndex = 1;

Future<String> getMediaType(String mediaName)async {
    final url =
        'https://api.themoviedb.org/3/search/multi?api_key=51b20269b73105d2fd84257214e53cc3&query=${mediaName}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data["results"][0];
      return results['media_type'];
    }
    return "";
  }

  String result = "";

  String updateString(String value) {
    if (value == "") {
      setState(() {
        result = "";
      });
    } else {
      getMediaType(value).then((results) {
        setState(() {
          result = results;
        });
      }).catchError((error) {
        print(error);
      });
    }
    return result;
  }

  void topRatedMoviesButton() {
    _currentIndex = 0;
    displayMovies.clear();
    page_number = 1;
    methodName = 'getTopRatedMovies';
    loadMovies(methodName);
  }

  void popularButton() {
    _currentIndex = 0;
    displayMovies.clear();
    page_number = 1;
    methodName = 'getPopular';
    loadMovies(methodName);
  }

  void topRatedSeriesButton() {
    _currentIndex = 0;
    displayMovies.clear();
    page_number = 1;
    methodName = 'getTopRatedSeries';
    loadMovies(methodName);
  }

  void _incrementIndex() {
    print(_currentIndex);
    setState(() {
      if (_currentIndex == displayMovies.length - 2) {
        loadMovies(methodName);
      }
      _currentIndex = (_currentIndex + 1) % displayMovies.length;
    });
  }

  void _decrementIndex() {
    print(_currentIndex);
    setState(() {
      _currentIndex = (_currentIndex - 1) % displayMovies.length;
    });
  }

  @override
  void initState() {
    loadMovies(methodName);
    super.initState();
  }

  loadMovies(String methodName) async {
    try {
      TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readAcessToken),
          logConfig: ConfigLogger(
            showLogs: true,
            showErrorLogs: true,
          ));
      switch (methodName) {
        case 'getTopRatedMovies':
          Map movieResults =
              await tmdbWithCustomLogs.v3.movies.getTopRated(page: page_number);
          page_number = page_number + 1;
          setState(() {
            displayMovies.addAll(movieResults['results']);
          });
          print(displayMovies);
          break;
        case 'getPopular':
          Map movieResults =
              await tmdbWithCustomLogs.v3.movies.getPopular(page: page_number);
          page_number = page_number + 1;
          setState(() {
            displayMovies.addAll(movieResults['results']);
          });
          break;
        case 'getTopRatedSeries':
          Map movieResults =
              await tmdbWithCustomLogs.v3.tv.getTopRated(page: page_number);
          page_number = page_number + 1;
          setState(() {
            displayMovies.addAll(movieResults['results']);
            print(movieResults);
          });
          break;

        default:
          print('Invalid method name: $methodName');
          break;
      }
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
          username: widget.username,
          password: widget.password,
        ),
        body: displayMovies.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _buttonPressedIndex = 1;
                            topRatedMoviesButton();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: _buttonPressedIndex == 1
                                ? Colors.white
                                : Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "Top rated movies",
                            style: TextStyle(
                              color: _buttonPressedIndex == 1
                                  ? Color.fromRGBO(6, 10, 43, 1)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _buttonPressedIndex = 2;
                            popularButton();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: _buttonPressedIndex == 2
                                ? Colors.white
                                : Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "Popular",
                            style: TextStyle(
                              color: _buttonPressedIndex == 2
                                  ? Color.fromRGBO(6, 10, 43, 1)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _buttonPressedIndex = 3;
                            topRatedSeriesButton();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: _buttonPressedIndex == 3
                                ? Colors.white
                                : Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "Top rated series",
                            style: TextStyle(
                              color: _buttonPressedIndex == 3
                                  ? Color.fromRGBO(6, 10, 43, 1)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.20,
                        left: 5,
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              _currentIndex - 1 < 0
                                  ? displayMovies.isEmpty
                                      ? ''
                                      : 'https://image.tmdb.org/t/p/w500' +
                                          displayMovies[displayMovies.length -
                                              1]['poster_path']
                                  : 'https://image.tmdb.org/t/p/w500' +
                                      displayMovies[_currentIndex - 1]
                                          ['poster_path'],
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.2,
                        right: 5,
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: displayMovies.isEmpty ||
                                    _currentIndex + 1 >= displayMovies.length
                                ? SizedBox.shrink()
                                : Image.network(
                                    'https://image.tmdb.org/t/p/w500' +
                                        displayMovies[_currentIndex + 1]
                                            ['poster_path'],
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
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
                                top: MediaQuery.of(context).size.height * 0.08),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute (
                                          builder: (context)  => MoviePage(
                                                email: widget.email,
                                                username: widget.username,
                                                password: widget.password,
                                                topRatedMovies: displayMovies,
                                                currentIndex: _currentIndex,
                                                mediaModel: MediaModel(
                                                    methodName == 'getTopRatedSeries'
                                                        ? displayMovies[
                                                                _currentIndex]
                                                            ['name']
                                                        : displayMovies[
                                                                _currentIndex]
                                                            ['title'],
                                                    updateString(methodName == 'getTopRatedSeries'
                                                        ? displayMovies[
                                                    _currentIndex]
                                                    ['name']
                                                        : displayMovies[
                                                    _currentIndex]
                                                    ['title']),
                                                    methodName ==
                                                            'getTopRatedSeries'
                                                        ? displayMovies[
                                                                _currentIndex]
                                                            ['first_air_date']
                                                        : displayMovies[
                                                                _currentIndex]
                                                            ['release_date'],
                                                    displayMovies[_currentIndex]
                                                        ['vote_average'],
                                                    'https://image.tmdb.org/t/p/w500' +
                                                        displayMovies[
                                                                _currentIndex]
                                                            ['poster_path'],
                                                    displayMovies[_currentIndex]
                                                        ['overview'],
                                                    displayMovies[_currentIndex]
                                                        ['id']),
                                              )),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: displayMovies.isNotEmpty
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      displayMovies[
                                                              _currentIndex]
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
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: displayMovies.isNotEmpty
                                            ? Text(
                                                methodName ==
                                                        'getTopRatedSeries'
                                                    ? displayMovies[
                                                        _currentIndex]['name']
                                                    : displayMovies[
                                                        _currentIndex]['title'],
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
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
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.008),
                                        child: Text(
                                          (displayMovies.isNotEmpty &&
                                                  (displayMovies[_currentIndex]
                                                          .containsKey(
                                                              'release_date') ||
                                                      displayMovies[
                                                              _currentIndex]
                                                          .containsKey(
                                                              'first_air_date')))
                                              ? (methodName ==
                                                      'getTopRatedSeries'
                                                  ? displayMovies[_currentIndex]
                                                          ['first_air_date']
                                                      .toString()
                                                      .substring(0, 4)
                                                  : displayMovies[_currentIndex]
                                                          ['release_date']
                                                      .toString()
                                                      .substring(0, 4))
                                              : '',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.0001),
                                  child: Text(
                                    displayMovies.isNotEmpty &&
                                            displayMovies[_currentIndex]
                                                .containsKey('vote_average')
                                        ? displayMovies[_currentIndex]
                                                ['vote_average']
                                            .toString()
                                        : '',
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.03,
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
                ],
              ));
  }
}
