import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'movie_full_image.dart';
import 'genres_and_movies.dart';
import 'movie_details.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Project 2",
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) =>  MyHomePage(),
        //MovieDetailsScreen.routeName: (context) => MovieDetailsScreen()
      },
        // settings for pushing data arguments
      onGenerateRoute: (settings) {
        if(settings.name == MovieDetailsScreen.routeName) {
          final args = settings.arguments as PassInfo;

          return MaterialPageRoute(
            builder: (context) {
              return MovieDetailsScreen(
                movieName: args.movieName,
                imagePath: args.imagePath,
                director: args.director,
                imdb: args.imdb,
                movieStars: args.movieStars,
                movieRatings: args.movieRatings,
                movieRuntime: args.movieRuntime,
              );
            }
          );
       }

        if(settings.name == MovieFullImageScreen.routeName) {
          final args = settings.arguments as PassInfo;

          return MaterialPageRoute(
              builder: (context) {
                return MovieFullImageScreen(
                    movieName: args.movieName,
                    imagePath: args.imagePath,
                    director: args.director,
                    imdb: args.imdb,
                    movieStars: args.movieStars
                );
              }
          );
        }
     }
    )
  );
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // function to create sliver list
  List<Widget> _sliverList() {
    var count = 0;
    var widgetList = <Widget>[]; // initialize empty widget list

    widgetList.add(
      SliverAppBar(
        pinned: true,
        backgroundColor: Color.fromRGBO(137,34,53,1),
        expandedHeight: 160,
        flexibleSpace: FlexibleSpaceBar(
          title: const Text('Popular Movies By Genre',
            style: TextStyle(
              shadows: <Shadow>[
                Shadow(
                  blurRadius: 15,
                  color: Colors.black,
                )
              ]
            )),
          background: Image.asset('images/movies.png', fit: BoxFit.fill),

        )
      )
    );

    for(var i = 0; i < 5; i++) { // loop 5 times for each genre
      //print("\ni = $i");
      widgetList.add(
          SliverAppBar(
              backgroundColor: Color.fromRGBO(137,34,53,1),
              title: Text(movieGenres[i],
                  style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 15,
                          color: Colors.black,
                        )
                      ]
                  )),
              pinned: true
              )
          );
          widgetList.add(
            SliverToBoxAdapter(
              child: Container(
                color: Colors.grey,
                height: 120,
                width: 200,
                child: ListView.builder(
                  padding: EdgeInsets.all(2),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: EdgeInsets.all(10),
                        
                        height: 100,
                        width: 300,
                        child:
                                GestureDetector(
                                    child: Card(

                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                  leading: Image.asset(
                                                      listOfMovies[i][index][0]),
                                                  title: Text(
                                                      listOfMovies[i][index][1], style: TextStyle(fontSize: 18)),
                                                  subtitle: Text(
                                                      listOfMovies[i][index][2])
                                              )
                                            ]
                                        )

                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          '/moviefullimage',
                                          arguments: PassInfo(
                                              listOfMovies[i][index][1], //movie name
                                              listOfMovies[i][index][0], //image path
                                              listOfMovies[i][index][2], //director
                                              listOfMovies[i][index][3], //imdb
                                              listOfMovies[i][index][5], //movie stars
                                              listOfMovies[i][index][7], //ratings
                                              listOfMovies[i][index][4] //runtime
                                      ));
                                   },
                                   onLongPress: () {
                                      RelativeRect position = RelativeRect.fromLTRB(150,250,150,150); // center of screen
                                      showMenu(
                                        context: context,
                                        position: position,
                                        items: [
                                          PopupMenuItem(
                                            child: Text("Movie Details"),
                                            onTap: () async {
                                              print("\nmovie details item pressed");
                                              final navigator = Navigator.of(context);
                                              await Future.delayed(Duration.zero); // pop item, delay, then push route
                                              navigator.pushNamed(
                                                  '/moviedetails',
                                                  arguments: PassInfo(
                                                      listOfMovies[i][index][1], //movie name
                                                      listOfMovies[i][index][0], //image path
                                                      listOfMovies[i][index][2], //director
                                                      listOfMovies[i][index][3], //imdb
                                                      listOfMovies[i][index][5], //movie stars
                                                      listOfMovies[i][index][7], //ratings
                                                      listOfMovies[i][index][4] //runtime
                                                  ));
                                            }
                                          ),
                                          PopupMenuItem(
                                            child: Text("Wikipedia"),
                                            onTap: () {
                                              _launchURL() async {
                                                Uri _url = Uri.parse(listOfMovies[i][index][6]);
                                                if (await canLaunchUrl(_url)) {
                                                  await launchUrl(_url);
                                                } else {
                                                  throw 'Could not launch ${listOfMovies[i][index][6]}';
                                                }
                                                }
                                              _launchURL();
                                          }

                                          ),
                                          PopupMenuItem(
                                            child: Text("IMDb"),
                                            onTap: () {
                                              _launchURL() async {
                                                Uri _url = Uri.parse(listOfMovies[i][index][3]);
                                                if (await canLaunchUrl(_url)) {
                                                  await launchUrl(_url);
                                                } else {
                                                  throw 'Could not launch ${listOfMovies[i][index][3]}';
                                                }
                                              }
                                              _launchURL();
                                            }
                                          )
                                        ]
                                      );
                                   }
                                )
                    );
                  }
              )
              )
            )
          );
    }

    widgetList.add(
      SliverPadding( // padding to fix aesthetic of bottom list not closing
        padding: EdgeInsets.all(43),

      )
    );

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white60,
      body: CustomScrollView(
        slivers: _sliverList(),
      )
    );
  }
}
