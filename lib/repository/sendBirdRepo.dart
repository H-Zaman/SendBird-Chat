import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:sendbird_chat/sendbird_chat.dart';
import 'package:splashscreentest/config/constants.dart';
import 'package:splashscreentest/model/chatChannelModel.dart';
import 'package:splashscreentest/model/chatMessageModel.dart';
import 'package:splashscreentest/view_model/ViewModel.dart';

import '../model/userModel.dart';
import '../view_model/ViewModel.dart';

class SendBirdRepo{

  static const SENDBIRDBASEURL = 'https://api-${Constants.SEND_APPID}.sendbird.com/v3';
  static  Map<String, String> REQUESTHEADER = {
    'Content-Type': 'application/json',
    'Api-Token' : Constants.SEND_TOKEN
  };

  static SendbirdChat sendbirdChat = SendbirdChat(
    applicationId: Constants.SEND_APPID,
    apiToken: Constants.SEND_TOKEN
  );

  static UserModel currentUser;
  static UserModel toChatUser;
  static ChatChannelModel currentChatChannel;


  static createOrLoginUser(String user) async{

    String UID = 'testUID-$user';

    /// check if current user is in the chat db
    bool userExist = checkUserExist(UID);

    if(userExist){
      /// user exists set the user
      print('USER FOUND');
      ViewModel.users.forEach((element) {
        if(element.userId == UID){
          currentUser = element;
        }
      });

    }else{
      /// creating new user
      print('USER NOT FOUND- CREATE NEW USER');

      Response response = await post(
        SENDBIRDBASEURL+'/users',
        headers: REQUESTHEADER,
        body: jsonEncode({
          'nickname' : user,
          'user_id' : UID,
          'profile_url': ''
        })
      );

      currentUser = UserModel.fromJson(jsonDecode(response.body));
    }

    ViewModel.users.remove(currentUser);

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

  static getAllUsers() async{
    Response response = await get(SENDBIRDBASEURL+'/users',headers: REQUESTHEADER);
    ViewModel.users.clear();
    for(var temp in jsonDecode(response.body)['users']){
      ViewModel.users.add(UserModel.fromJson(temp));
    }
    ViewModel.users.remove(currentUser);
  }

  static getMessages() async{

    String channelName = currentUser.userId+toChatUser.userId;

    /// getting existing channels
    ViewModel.chatChannels.clear();
    List<dynamic> openChannels = await sendbirdChat.listOpenChannels();
    for(var temp in openChannels){
      ViewModel.chatChannels.add(ChatChannelModel.fromJson(temp));
    }

    /// checking if these 2 user have a channel
    bool channelExists = false;
    ViewModel.chatChannels.forEach((channel) {
      if(channel.name.contains(currentUser.userId) && channel.name.contains(toChatUser.userId)){
        channelExists = true;
        currentChatChannel = channel;
      }
    });

    if(channelExists){
      print('CHANNEL EXIST');


    }else{
      print('CHANNEL DOES NOT EXIST > CREATING NEW CHANNEL');
      /// creating new channel
      var result = await sendbirdChat.createOpenChannel(
          name: channelName,
          userIds: [
            currentUser.userId,
            toChatUser.userId
          ]
      );
      currentChatChannel = ChatChannelModel.fromJson(result);
    }

    ///getting message of the channel
    List<dynamic> data = await sendbirdChat.getOpenChannelMessages(currentChatChannel.channelUrl);
    ViewModel.chatMessage.clear();
    for(var temp in data){
      ViewModel.chatMessage.add(ChatMessageModel.fromJson(temp));
    }
  }

  static sendMessage(String message) async{
    try{
      await sendbirdChat.sendOpenChannelMessage(
          channelUrl: currentChatChannel.channelUrl,
          originUserId: currentUser.userId,
          message: message
      );
      print('MESSAGE SENT');
      return true;
    }catch(e){
      print('MESSAGE NOT SENT');
      print(e.toString());
      return false;
    }
  }
}