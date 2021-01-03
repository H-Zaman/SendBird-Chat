import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreentest/sendBirdRepo.dart';
import 'homeScreen.dart';

void main() {
  SendBirdRepo.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SendBird Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'SendBird Chat'),
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

double top = 300;
double bottom = 300;
double left = 200;
double right = 200;
  forward(){
    setState(() {
      top = -1000;
      bottom = -1000;
      left = -1000;
      right = -1000;
    });
    Future.delayed(Duration(milliseconds: 1300),backward);
  }
  backward(){
    setState(() {
      top = 300;
      bottom = 300;
      left = 200;
      right = 200;
    });
    Future.delayed(Duration(milliseconds: 1700),nextPage);
  }
  nextPage(){
    Get.offAll(HomeScreen());
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1),forward);

    SendBirdRepo.createOrLoginUser('Nafee Walee');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            top: top,
            bottom: bottom,
            left: left,
            right: right,
            duration: Duration(seconds: 2),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(4,4),
                    blurRadius: 13.0,
                    spreadRadius: 8,
                    color: Colors.grey[300]
                  ),
                  BoxShadow(
                    offset: Offset(-4,4),
                    blurRadius: 13.0,
                    spreadRadius: 8,
                      color: Colors.grey[300]

                  ),
                  BoxShadow(
                    offset: Offset(4,-4),
                    blurRadius: 13.0,
                    spreadRadius: 8,
                      color: Colors.grey[300]

                  ),
                  BoxShadow(
                    offset: Offset(-4,-4),
                    blurRadius: 13.0,
                    spreadRadius: 8,
                      color: Colors.grey[300]

                  ),
                ]
              ),
            ),
          ),
          Center(
              child: Hero(
                tag: 'logo',
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                      'assets/Circular-Logos.png'
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}

const Color color = Color(0xffED4E2F);