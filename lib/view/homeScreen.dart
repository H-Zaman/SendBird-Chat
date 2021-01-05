import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreentest/repository/sendBirdRepo.dart';
import 'package:splashscreentest/view/chattingScreen.dart';
import 'package:splashscreentest/widgets/screeLoader.dart';

import '../model/userModel.dart';
import '../view_model/ViewModel.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchBarController = TextEditingController();
Timer timer;
@override
  void initState() {
  getData();
    super.initState();
  }

  getData(){
  timer = Timer.periodic(Duration(seconds: 1), (timer) async{
    await SendBirdRepo.getAllUsers();
  });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffbde0fe),
        appBar: AppBar(
          backgroundColor: Color(0xffcdb4db),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: 'logo',
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                    'assets/Circular-Logos.png'
                ),
              ),
            ),
          ),
          title: Text(
            'M-Vinx Designs',
            style: TextStyle(
                fontSize: 24,
                letterSpacing: 2
            ),
          ),
          bottom: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffcdb4db),
            title: Column(
              children: [
                TextField(
                  controller: searchBarController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                          Icons.search
                      ),
                      fillColor: Color(0xffffc8dd),
                      filled: true,
                      hintText: 'Search for user...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        body: Obx(()=>ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: ViewModel.users.length,
          itemBuilder: (_,index){
            UserModel user = ViewModel.users[index];
            return Card(
              elevation: 10,
              child: ListTile(
                onTap: (){
                  SendBirdRepo.toChatUser = user;
                  Get.to(ChattingScreen());
                },
                title: Text(
                    user.nickname.camelCase
                ),
              ),
            );
          },
        ))
    );
  }
}
