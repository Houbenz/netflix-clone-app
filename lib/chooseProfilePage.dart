import 'package:flutter/material.dart';

import 'main/mainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primaryColor: Colors.black,
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.black,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white
        )
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "mainPage":(context)=>MainPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Image(image: AssetImage("assets/netflix_logo.png"),height: 50,),
        actions: [
          IconButton(icon: Icon(Icons.edit,color: Colors.white,), onPressed: ()=> print("edit"))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16),
                child: Text("Who's Watching?",style: TextStyle(color: Colors.white,fontSize: 20),),),
            GridView.count(crossAxisCount: 2,
            shrinkWrap: true,
            children: [
                  profileElement("amine", "assets/blue.PNG"),
                  profileElement("amine", "assets/red.PNG"),
                  profileElement("amine", "assets/green.PNG"),
                  profileElement("amine", "assets/yellow.PNG"),
                  addProfileElement("Add Profile", Icons.add)
            ],)
          ],
        ),
      ),
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget profileElement(String title,String imageURL){
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "mainPage"),
      splashColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage(imageURL),width: 125,height: 125,),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text(title,style: TextStyle(color: Colors.white,fontSize: 14),),
          )
        ],
      ),
    );

  }

  Widget addProfileElement(String title,IconData iconData){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            color: Colors.white,
            width: 75,
            height: 75,
            child: IconButton(
              icon: Icon(iconData),
              color: Colors.black,iconSize: 50,onPressed: () => print("add"),),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Text(title,style: TextStyle(color: Colors.white,fontSize: 14),),
        )
      ],
    );
  }
}
