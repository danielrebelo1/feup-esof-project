import 'package:flutter/material.dart';
import 'package:project/reusableWidgets/custom_nav_bar.dart';
import 'package:project/reusableWidgets/movie_model.dart';

class MoviePage extends StatefulWidget {
  final String email;
  final String password;
  final List topRatedMovies;
  final int currentIndex;
  final String path = 'https://image.tmdb.org/t/p/w500';
  final MovieModel? movieModel;

  const MoviePage(
      {Key? key,
      required this.email,
      required this.password,
      required this.topRatedMovies,
      required this.currentIndex,
      this.movieModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(
        email: widget.email,
        password: widget.password,
      ),
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Opacity(
                opacity: 0.4,
                child: widget.movieModel == null
                    ? Image.network(
                        widget.path +
                            widget.topRatedMovies[widget.currentIndex]
                                ['poster_path'],
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        alignment: const Alignment(0, 0.7),
                      )
                    : (widget.movieModel?.moviePoster != "null"
                        ? Image.network(
                            widget.movieModel?.moviePoster ?? "",
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            alignment: const Alignment(0, 0.7),
                          )
                        : Image.asset(
                            'assets/no-image.png',
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            alignment: const Alignment(0, 0.7),
                          ))),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: widget.movieModel == null
                                  ? Image.network(
                                      widget.path +
                                          widget.topRatedMovies[widget
                                              .currentIndex]['poster_path'],
                                      height: 220,
                                      width: 180)
                                  : (widget.movieModel?.moviePoster != "null"
                                      ? Image.network(
                                          widget.movieModel?.moviePoster ?? "",
                                          height: 220,
                                          width: 180)
                                      : Image.asset('assets/no-image.png',
                                          height: 220, width: 180))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Transform.translate(
                                offset: const Offset(0, 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/hbo-max.png",
                                    height: 55,
                                    width: 50,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Transform.translate(
                                offset: const Offset(0, 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/netflix.png",
                                      height: 55, width: 50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.movieModel == null
                                    ? widget.topRatedMovies[widget.currentIndex]
                                        ['original_title']
                                    : widget.movieModel?.movieTitle ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.02),
                            Text(
                              widget.movieModel == null
                                  ? widget.topRatedMovies[widget.currentIndex]
                                          ['release_date']
                                      .toString()
                                      .substring(0, 4)
                                  : widget.movieModel?.movieReleaseYear
                                          .toString() ??
                                      "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Text(
                              widget.movieModel == null
                                  ? widget.topRatedMovies[widget.currentIndex]
                                          ['vote_average']
                                      .toString()
                                  : widget.movieModel?.rating.toString() ?? "",
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.movieModel == null
                              ? widget.topRatedMovies[widget.currentIndex]
                                      ['overview']
                                  .toString()
                              : widget.movieModel?.description.toString() ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/user.png'),
                          radius: 15,
                          backgroundColor: Color.fromRGBO(6, 10, 43, 1),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "This is a great movie",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
