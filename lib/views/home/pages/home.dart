import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_call/common/secrete/secrets.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class HomePage extends StatefulWidget {
  final String userId;
  final String userEmail;
  final ZegoUIKitPrebuiltCallConfig config;
  const HomePage({super.key, required this.userId, required this.userEmail,required this.config});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ZegoUIKitPrebuiltCall(
        appID: AppSecret.appId, // your appId
        appSign: AppSecret.appSign, // your appSign
        callID: AppSecret.callID.toString(), // userId
        config: widget.config,
        userID: widget.userId,
        userName: widget.userEmail,
      )),
    );
  }
}
