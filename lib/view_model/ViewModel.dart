import 'package:get/get.dart';
import 'package:splashscreentest/model/chatChannelModel.dart';
import 'package:splashscreentest/model/chatMessageModel.dart';
import 'package:splashscreentest/model/userModel.dart';

class ViewModel{
  static var users = <UserModel>[].obs;

  static var chatChannels = <ChatChannelModel>[].obs;

  static var chatMessage = <ChatMessageModel>[].obs;
}