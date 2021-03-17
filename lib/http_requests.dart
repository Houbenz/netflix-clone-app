import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/beans/TopRated.dart';
import 'beans/Movie.dart';

 const String API_KEY ="0ccbf2dab700f54911df768a72781699";
 const String DOMAIN = "api.themoviedb.org";

Future<Movie> fetchMovie() async{
  
  http.Response response = await http.get(Uri.https(DOMAIN, "3/movie/755",{
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

Future<List<Movie>> topRatedMovies() async{

  http.Response response = await http.get(Uri.https(DOMAIN, "3/movie/top_rated",{
    "api_key":API_KEY,
    "language=":"en-US",
    "page": "1",
  }));

  if(response.statusCode == 200){

    Map<String,dynamic> jsonObjects = jsonDecode(response.body);

    List<dynamic> results = jsonObjects["results"];

    List<Movie> movies = results.map<Movie>((movieJson ) => Movie.fromJson(movieJson)).toList();

    return movies;
  }
  else{
    print(response.body);
  }

}

void main(){
  //fetchMovie().then((value) => print(value));
  topRatedMovies().then((value) => print(value));
}