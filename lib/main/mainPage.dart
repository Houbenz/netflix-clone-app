import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/main/ComingSoon.dart';
import 'package:netflix_clone/main/HomePage.dart';

import 'DownloadPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

//0ccbf2dab700f54911df768a72781699

class _MainPageState extends State<MainPage> {

  int _currentindex=0;


  static List<Widget> _pagesOptions=[
    HomePage(),
    ComingSoonPage(),
    DownloadPage(),
  ];

  void _onTappedItem(int index){

    setState(() {
      _currentindex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,


      appBar: AppBar(
        leading: Container(width: 0,height: 0,),
        titleSpacing: -10,
        title: Container(
            child: Image(image: AssetImage("assets/n_logo.png"),width: 15,)),
        elevation: 0,
        backgroundColor: Colors.transparent,

        actions: [
          if(_currentindex == 0)
            Container(
            margin: EdgeInsets.only(right: 8),
            child: IconButton(
                icon: Icon(Icons.cast), onPressed: ()=> print("cast")),
          ),
          Container(
              margin: EdgeInsets.only(right: 8),
              child: IconButton(icon: Icon(Icons.search), onPressed: ()=> print("search"))),
          Container(
            margin: EdgeInsets.only(right: 16),
              child: InkWell(child: Image(image: AssetImage("assets/blue.PNG"),width: 24,),))
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.video_collection_outlined),label: "Coming soon"),
          BottomNavigationBarItem(icon: Icon(Icons.cloud_download_outlined),label: "Downloads"),
        ],
        onTap: _onTappedItem ,
      ),

      body: _pagesOptions[_currentindex],
    );
  }
}
