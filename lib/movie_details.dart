import 'package:flutter/material.dart';

import 'genres_and_movies.dart';

class MovieDetailsScreen extends StatelessWidget {
  //const MovieDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/moviedetails';
  final String imagePath;
  final String director;
  final String imdb;
  final String movieStars;
  final String movieName;
  final String movieRatings;
  final String movieRuntime;

  const MovieDetailsScreen({
    super.key,
    required this.movieName,
    required this.imagePath,
    required this.director,
    required this.imdb,
    required this.movieStars,
    required this.movieRatings,
    required this.movieRuntime
});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold
    );

    //final PassInfo args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(movieName),
        backgroundColor: Color.fromRGBO(137,34,53,1),
      ),
      body: Center(
          child: SizedBox(
            width: 230,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(20)),
                Text("director: $director", style: style),
                Padding(padding: EdgeInsets.all(30)),
                Text("movie stars: $movieStars", style: style),
                Padding(padding: EdgeInsets.all(30)),
                Text("movie runtime: $movieRuntime", style: style),
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(30)),
                      Text("movie ratings: \n\n $movieRatings", style: style)
                    ]
                  )
              )
            ]
          )
          )
      )
    );

  }
}