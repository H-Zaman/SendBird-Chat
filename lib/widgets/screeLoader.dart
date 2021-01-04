import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

class IsScreenLoading extends StatelessWidget {

  final bool screenLoading;
  final Widget child;
  IsScreenLoading({@required this.screenLoading, @required this.child});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: screenLoading,
      progressIndicator: SpinKitRing(
        color: Colors.pink,
      ),
      color: Colors.grey,
      child: WillPopScope(
          onWillPop: () async => screenLoading ? false : true,
          child: child
      ),
    );
  }
}