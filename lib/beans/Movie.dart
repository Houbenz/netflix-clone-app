
class Movie{
  int id;
  String original_title;
  String origin_country;
  bool adult;
  List<String> spokenLanguages;
  String overview;
  double popularity;
  String status;
  String poster_path;

  Movie(
      {
        this.id,
        this.original_title,
        this.origin_country,
        this.adult,
        this.spokenLanguages,
        this.overview,
        this.popularity,
        this.status,
        this.poster_path});


  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
        id: json["id"],
        original_title: json["original_title"],
        origin_country: json["origin_country"],
        adult: json["adult"],
        spokenLanguages: json["spokenLanguages"],
        overview: json["overview"],
        popularity: json["popularity"],
        status: json["status"],
        poster_path : json["poster_path"]
    );
  }



  @override
  String toString() {
    return 'Movie{id: $id,poster_path: $poster_path, original_title: $original_title, origin_country: $origin_country, adult: $adult, spokenLanguages: $spokenLanguages, overview: $overview, popularity: $popularity, status: $status}';
  }
}