import 'package:flutter/material.dart';
import 'package:netflix_clone/beans/Movie.dart';
import 'package:netflix_clone/beans/MovieVideo.dart';
import 'package:netflix_clone/http_requests.dart';
import 'package:video_player/video_player.dart';

class ComingSoonPage extends StatefulWidget {
  @override
  _ComingSoonPageState createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: topRatedMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Movie> movies = snapshot.requireData;

          return CustomScrollView(
            slivers: [

              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                          onPressed: () => print("Remind Me")),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Notifications",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () => print("chevron right"))
                    ],
                  ),
                ),
              ),

              SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                          child: Expanded(child: ComingSoonElement(movies[index])));
                    },
                    childCount: movies.length,
                  )),
            ],
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}

class ComingSoonElement extends StatefulWidget {
  final Movie movie;

  ComingSoonElement(this.movie);

  @override
  _ComingSoonElementState createState() => _ComingSoonElementState();
}

class _ComingSoonElementState extends State<ComingSoonElement> {
  Future<List<MovieVideo>> futureMovieVideo;

  @override
  void initState() {
    super.initState();
    futureMovieVideo = getMovieVideosLink(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureMovieVideo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {

          List<MovieVideo> list =snapshot.requireData;
          MovieVideo movieVideo;
          if(list.isNotEmpty) {
            movieVideo = list[0];

            return Container(
              width: 350,
              height: 600,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  VideoWidget(
                      "https://www.themoviedb.org/video/play?key=${movieVideo
                          .key}"),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image(
                              image: AssetImage("assets/netflix_logo.png"),
                              width: 100),
                          Column(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => print("Remind Me")),
                              Text(
                                "Remind Me",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white38),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => print("Info")),
                              Text(
                                "Info",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white38),
                              )
                            ],
                          ),
                        ],
                      ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(8),
                      child: Text(
                        widget.movie.original_title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(8),
                    child: Flexible(
                        child: Text(widget.movie.overview,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))),
                  ),
                  Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.all(4),
                        child: Text(
                          "Ominous",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4),
                        child: Text(
                          "Exciting",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4),
                        child: Text(
                          "Horror",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4),
                        child: Text(
                          "Teen",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4),
                        child: Text(
                          "Mystery",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4),
                        child: Text(
                          "Thriller",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          else return Container();
        } else
          return Container();
      },
    );
  }
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  VideoWidget(this.videoUrl);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;

  //TODO: if doesn't work change how you use the video (change the lib)
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
           //'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4'
      'https://cdn.videvo.net/videvo_files/video/free/2020-04/small_watermarked/200401_Medical%206_01_preview.webm'
    //    widget.videoUrl
    )
      ..initialize().then((_) {
        _controller.pause();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  void playVideo() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Stack(alignment: Alignment.center, children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
        IconButton(
          iconSize: 75,
          onPressed: playVideo,
          icon: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
