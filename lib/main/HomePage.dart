import 'package:flutter/material.dart';
import 'package:netflix_clone/beans/Movie.dart';

import '../http_requests.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Movie>> futureTopRated;

  @override
  void initState() {
    super.initState();
    futureTopRated = topRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return test(futureTopRated);
  }
}

Widget horizontalListView(List<Widget> children) {
  return SliverToBoxAdapter(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      height: 200,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: children,
      ),
    ),
  );
}

Widget test(Future<List<Movie>> futureTopRated) {
  return FutureBuilder(
    future: futureTopRated,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        List<Movie> movies = snapshot.requireData;

        List<Widget> gridChildren =
            movies.map((movie) => listElement(movie)).toList();

        return CustomScrollView(slivers: [

          SliverToBoxAdapter(
            child: headerStack(),
          ),

          SliverToBoxAdapter(
              child: midButtons()),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                "Continue Watching",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          horizontalListView(gridChildren),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                "Action Tv",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          horizontalListView(gridChildren),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                "Trending Now",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          horizontalListView(gridChildren),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                "Watch Again",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          horizontalListView(gridChildren),
        ]);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget listElement(Movie movie) {
  return Image.network("https://image.tmdb.org/t/p/w500${movie.poster_path}");
}

Widget headerStack() {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      FutureBuilder(
        future: fetchMovie(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Movie movie =snapshot.requireData;
            return Image.network(
              "https://image.tmdb.org/t/p/w500${movie.poster_path}",
              width: double.infinity,
              fit: BoxFit.cover,
            );
          } else
            return CircularProgressIndicator();
        },
      ),
      Wrap(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16),
              child: Text("Fantasy Anime",style: TextStyle(fontSize: 11,
                color: Colors.white,),),),


          Container(
            margin: EdgeInsets.only(left: 16),
            child: Text("Supernatural",style: TextStyle(fontSize: 11,
              color: Colors.white,),),),


          Container(
            margin: EdgeInsets.only(left: 16),
            child: Text("Japanese",style: TextStyle(fontSize: 11,
              color: Colors.white,),),),


          Container(
            margin: EdgeInsets.only(left: 16),
            child: Text("Shounen",style: TextStyle(fontSize: 11,
              color: Colors.white,),),),

          Container(
            margin: EdgeInsets.only(left: 16),
            child: Text("TV",style: TextStyle(fontSize: 11,
              color: Colors.white,),),),
        ],
      )
    ],
  );
}


Widget midButtons(){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              IconButton(icon: Icon(Icons.add),color: Colors.white, onPressed: ()=>print("My list")),
              Container(child: Text("My List",style: TextStyle(color:Colors.white38,fontSize: 11)),)
            ],
          ),
        ),

       ElevatedButton.icon(
         style: ElevatedButton.styleFrom(
           primary: Colors.white,
           onPrimary: Colors.black
         ),
          onPressed: ()=>print("Play"),
         icon: Icon(Icons.play_arrow, size: 18),
         label: Text("Play",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              IconButton(icon: Icon(Icons.info_outline),color: Colors.white, onPressed: ()=>print("My list")),
              Container(child: Text("info",style: TextStyle(color:Colors.white38,fontSize: 11),),)
            ],
          ),
        ),
      ],
    ),
  );
}
