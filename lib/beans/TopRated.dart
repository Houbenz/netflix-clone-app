import 'Movie.dart';

class TopRated{
  int page;
  List<String> results;
  TopRated({this.page, this.results});

  factory TopRated.fromJson(Map<String,dynamic> json){


    return TopRated(
      page: json["page"],
      results:json["results"],
    );
  }

  List<Movie> decodeMovies(List<Map<String,dynamic>> jsonList){

    return jsonList.map((e) => Movie.fromJson(e));

  }

  @override
  String toString() {
    return 'TopRated{$results}';
  }
}