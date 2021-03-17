import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:netflix_clone/beans/Movie.dart';

import '../http_requests.dart';
import 'package:http/http.dart' as http;

class DownloadPage extends StatefulWidget {
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          child: TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.white38
            ),
            onPressed: ()=> print("smart downloads"),
            icon: Icon(Icons.settings,),
            label: Text("Smart Downloads"),
          ),
        ),

        Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            width: double.infinity,
            child: Text(
              "Introducing Downloads for You",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,),
              textAlign: TextAlign.start,
            ),),
        Text(
          "We'll download a personalized selection of movies and shows for you, so there's always something to watch on your phone",
          style: TextStyle(color: Colors.white38),
        ),
        Center(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 32),
              width: 200,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.white38,
                    ),
                  ),
                  Positioned(
                    right: 100,
                    child: imageChild(125,"669"),
                  ),
                  Positioned(
                    left: 100,
                    child: imageChild(-125,"25"),
                  ),
                  Positioned(
                    child: imageChild(0,"665"),
                  ),

                ],
              ),
            ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: ElevatedButton(
              onPressed: () => print("Setup"),
              child: Text("Set up".toUpperCase())),
        ),

        Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF242323),
              ),
                onPressed: () => print("find something to download"),
                child: Text("find something to download"))),
      ],
    );
  }

  Widget imageChild(double angle,String movieId) {
    return Center(
      child: FutureBuilder(
        future: fetchMovieStack(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Movie movie = snapshot.requireData;
            return Transform.rotate(
              angle: angle,
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500${movie.poster_path}",
                  width: 120,
                ),
              ),
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}

Future<Movie> fetchMovieStack(String movieId) async{

  http.Response response = await http.get(Uri.https(DOMAIN, "3/movie/$movieId",{
    "api_key":API_KEY,
    "language=":"en-US",
  }));
  try{
    if(response.statusCode == 200){
      String jsonBody = response.body;

      Movie movie = Movie.fromJson(jsonDecode(jsonBody));

      return movie;
    }else{
      print(response.body);
    }
  } on HttpException catch(e){
    print(e);
  }
}
