import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreentest/widgets/screeLoader.dart';
import 'repository/sendBirdRepo.dart';
import 'view/homeScreen.dart';

void main() {
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


  TextEditingController textEditingController = TextEditingController();

  bool screenLoading =false;

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

    Get.dialog(Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textEditingController,
          ),
          RaisedButton(
            onPressed: ()async{
              if(textEditingController.text.length > 2){
                Get.back();
                setState(() {
                  screenLoading = true;
                });
                await SendBirdRepo.getAllUsers();
                await SendBirdRepo.createOrLoginUser(textEditingController.text);
                Get.offAll(HomeScreen());
              }
            },
            child: Text(
              'Log in'
            ),
          )
        ],
      ),
    ),barrierDismissible: false);
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1),forward);
  }
  @override
  Widget build(BuildContext context) {
    return IsScreenLoading(
      screenLoading: screenLoading,
      child: Scaffold(
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
      ),
    );
  }
}

const Color color = Color(0xffED4E2F);