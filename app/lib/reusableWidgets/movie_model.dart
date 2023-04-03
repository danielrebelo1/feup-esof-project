import 'package:flutter/material.dart';

class MovieModel{
  String movieTitle;
  String movieReleaseYear;
  String moviePoster;
  String description;
  double? rating;

  MovieModel(this.movieTitle, this.movieReleaseYear, this.rating, this.moviePoster, this.description);
}