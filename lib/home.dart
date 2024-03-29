import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rempahsis/camera_screen.dart';
import 'package:rempahsis/image_scan_screen.dart';
import 'package:rempahsis/list_rempah.dart';
import 'package:rempahsis/landing_page.dart';
import 'package:rempahsis/about_page.dart';



class MyHomePage extends StatefulWidget{
  MyHomePage({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  State<StatefulWidget> createState(){
    return _MyHomePageState( title: "RempahSIS",);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({ required this.title,});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  
  final String title;
  int _currentIndex=0;
  final List<Widget> _children = [
    LandingPage(),
    RempahListPage(),
    ChooseImagePage(),
    AboutPage(),
  ];


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        
        currentIndex: _currentIndex,
        unselectedItemColor: Color(0xffCE8D51),
        type: BottomNavigationBarType.fixed,
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Beranda"  
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: "Daftar"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera),
          label: "Scan"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_vert),
          label: "Lainnya"
        ),         
      ]),   
    );
  }

  void onTabTapped(int index){
    if(false) Navigator.push(context, MaterialPageRoute(builder: (context) => RempahScannerScreen()));
    else{
      setState(() {
      _currentIndex = index;
    });
    }
  }
}