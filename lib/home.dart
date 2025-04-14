import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: 
    ZegoUIKitPrebuiltCall(
      appID: 12,
      appSign: "",
      callID: "54321",
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      userID: "4567",
      userName: "Hegde",
      )),);
  }
}
