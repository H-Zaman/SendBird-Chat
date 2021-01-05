import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:splashscreentest/model/chatMessageModel.dart';
import 'package:splashscreentest/repository/sendBirdRepo.dart';

import '../view_model/ViewModel.dart';

class ChattingScreen extends StatefulWidget {

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final scrollController = ScrollController();
  final messageBoxController = TextEditingController();

  bool initLoad = true;

  @override
  void initState() {
    getData();
    super.initState();
  }


  Timer timer;

  getData() async{


    timer = Timer.periodic(Duration(seconds: 1), (timer) async{
      await SendBirdRepo.getMessages();
    });

    setState(() {
      initLoad = false;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            SendBirdRepo.toChatUser.nickname.camelCase,
          ),
          actions: [
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              onSelected: (value){
                if(value == 1){
                  SendBirdRepo.getMessages();
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                      'Clear chat'
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                      'Block user'
                  ),
                ),
              ],
            ),
          ],
        ),
        body:initLoad ? SpinKitCubeGrid(color: Colors.amber,) : Column(
          children: [
            Expanded(
              flex: 8,
              child: Obx(()=>ListView.builder(
                shrinkWrap: true,
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                itemCount: ViewModel.chatMessage.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  ChatMessageModel message = ViewModel.chatMessage[index];
                  bool isSender = SendBirdRepo.currentUser.userId == message.user.userId;
                  return CustomMessageWidget(
                    content: message.message,
                    ownerType: isSender ? SenderType.sender : SenderType.receiver,
                    ownerName: isSender ? SendBirdRepo.currentUser.nickname : SendBirdRepo.toChatUser.nickname,
                    image: message.user.profileUrl,
                  );
                },
              )),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                height: 70,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    // IconButton(
                    //   icon: Icon(Icons.photo),
                    //   iconSize: 25,
                    //   color: Theme.of(context).primaryColor,
                    //   onPressed: () {},
                    // ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Send a message..',
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        controller: messageBoxController,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: Colors.grey
                              )
                          )
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        iconSize: 25,
                        color: Theme.of(context).primaryColor,
                        onPressed: () async{
                          if(messageBoxController.text.length>0){
                            bool messageSent = await SendBirdRepo.sendMessage(messageBoxController.text);
                            if(messageSent){
                              messageBoxController.clear();
                            }else{
                              Get.snackbar('Error', 'Message not sent');
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}

class CustomMessageWidget extends StatefulWidget {
  final String content;
  final SenderType ownerType;
  final String ownerName;
  final String image;

  CustomMessageWidget(
      {this.content,
        this.ownerType,
        this.image,
        this.ownerName
      });

  @override
  _CustomMessageWidgetState createState() => _CustomMessageWidgetState();
}

class _CustomMessageWidgetState extends State<CustomMessageWidget>
    implements IMessageWidget {
  String get senderInitials {
    if (widget.ownerName == null || widget.ownerName.isEmpty) return 'ME';

    try {
      if (widget.ownerName.lastIndexOf(' ') == -1) {
        return widget.ownerName[0];
      } else {
        var lastInitial =
        widget.ownerName.substring(widget.ownerName.lastIndexOf(' ') + 1);

        return widget.ownerName[0] + lastInitial[0];
      }
    } catch (e) {
      print(e);
      return 'ME';
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.ownerType) {
      case SenderType.receiver:
        return buildReceiver();
      case SenderType.sender:
      default:
        return buildSender();
    }
  }

  @override
  Widget buildReceiver() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildCircleAvatar(),
        Flexible(
          child: Bubble(
              margin: BubbleEdges.fromLTRB(10, 10, 30, 0),
              stick: true,
              nip: BubbleNip.leftTop,
              color: Color.fromRGBO(233, 232, 252, 10),
              alignment: Alignment.topLeft,
              child: _buildContentText(TextAlign.left)),
        ),
      ],
    );
  }

  @override
  Widget buildSender() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Flexible(
          child: Bubble(
              margin: BubbleEdges.fromLTRB(30, 10, 10, 0),
              stick: true,
              nip: BubbleNip.rightTop,
              color: Colors.white,
              alignment: Alignment.topRight,
              child: _buildContentText(TextAlign.right)),
        ),
        _buildCircleAvatar()
      ],
    );
  }

  Widget _buildContentText(TextAlign align) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
/*        widget.receipt == null ? SizedBox() :
          GestureDetector(
            onTap: (){
              Get.to(AcceptReceiptScreen());
            },
            child: AspectRatio(
            aspectRatio: 1.5,
              child: CachedNetworkImage(imageUrl: widget.receipt)
        ),
          ),
        widget.order == null ? SizedBox() :
          GestureDetector(
            onTap: (){
              Get.to(OrderDetailsScreen());
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                spacing: 3,
                runSpacing: 5,
                children: widget.order.map((e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      color: AppConst.teal,
                      size: 14,
                    ),
                    Text(
                        ' ' + e
                    ),
                  ],
                )).toList(),
        ),
              ),
            ),
          ),
        widget.receipt == null && widget.order == null ? SizedBox() : SizedBox(height: 5,),*/
        Text(
          widget.content,
          textAlign: align,
          style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontFamily: DefaultTextStyle.of(context).style.fontFamily),
        )
      ],
    );
  }

  Widget _buildCircleAvatar() {
    return CircleAvatar(
      radius: 12,
      /*backgroundImage: CachedNetworkImageProvider(
        widget.image
      ),*/
      child: Text(
        senderInitials.toUpperCase()
      ),
    );
  }
}

abstract class IMessageWidget {
  Widget buildReceiver();
  Widget buildSender();
}

enum SenderType { receiver, sender }