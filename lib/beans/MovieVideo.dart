class MovieVideo{
  String id;
  String iso_639_1;
  String iso_3166_1;
  String key;
  String name;
  String site;
  String type;
  int size;

  MovieVideo(
      {this.id,
      this.iso_639_1,
      this.iso_3166_1,
      this.key,
      this.name,
      this.site,
      this.type,
      this.size});


  factory MovieVideo.fromJson(Map<String,dynamic> json){

    return MovieVideo(
        id : json['id'],
      iso_639_1 : json['iso_639_1'],
      iso_3166_1 : json['iso_3166_1'],
      key : json['key'],
      name : json['name'],
      site : json['site'],
      type : json['type'],
      size : json['size'],
    );

  }
}