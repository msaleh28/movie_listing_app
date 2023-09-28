import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';




class MovieFullImageScreen extends StatelessWidget {
  //const MovieDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/moviefullimage';
  final String imagePath;
  final String director;
  final String imdb;
  final String movieStars;
  final String movieName;

  const MovieFullImageScreen({
    super.key,
    required this.movieName,
    required this.imagePath,
    required this.director,
    required this.imdb,
    required this.movieStars,
  });

  @override
  Widget build(BuildContext context) {

    //final PassInfo args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(movieName),
          backgroundColor: Color.fromRGBO(137,34,53,1),
        ),
        body: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover
              )
            )
          ),
          onTap: () {
            _launchURL();
           }
        )
        );

  }

  _launchURL() async {
    Uri _url = Uri.parse(imdb);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $imdb';
    }
  }

}

