import 'dart:convert';

import 'package:splashscreentest/constants.dart';
import 'package:http/http.dart';
import 'package:splashscreentest/view_model/ViewModel.dart';

import 'model/userModel.dart';

class SendBirdRepo{

  static const SENDBIRDBASEURL = 'https://api-${Constants.SEND_APPID}.sendbird.com/v3';
  static var REQUESTHEADER = {
    'Api-Token' : Constants.SEND_TOKEN,
  };

  static UserModel currentUser;

  static init(){
    try{
      print('INITIALIZING SENDBIRD');

      print('SEND BIRD INITIALIZED');
    }catch(e){
      print('Send Bird Init failed : ${e.toString()}');
    }
  }

  static createOrLoginUser(String userId) async{

    // String uidGenerator = 'https://www.uuidgenerator.net/api/version1';

    /// getting all users
    Response response = await get(SENDBIRDBASEURL+'/users',headers: REQUESTHEADER);


    for(var temp in jsonDecode(response.body)['users']){
      ViewModel.users.add(UserModel.fromJson(temp));
    }

    bool userExist = checkUserExist(userId);

    if(userExist){
      print('user exist');
    }else{
      /// creating new user
      print('user does not exist');


      UserModel newUser = UserModel(
        userId: userId,
        nickname: userId,
        profileUrl: "",
        createdAt: 123213123,
        phoneNumber: "123123213213",
        isActive: true,
        isOnline: true,
        lastSeenAt: 123123213
      );

      Response response = await post(
        SENDBIRDBASEURL+'/users',
        headers: REQUESTHEADER,
        body: {'user_id': userId,'profile_url': ''});
      print(response.body);

    }

  }

  static checkUserExist(String userId){
    bool check = false;
    ViewModel.users.forEach((user) {
      if(userId == user.userId){
        check = true;
      }
    });
    return check;
  }
}