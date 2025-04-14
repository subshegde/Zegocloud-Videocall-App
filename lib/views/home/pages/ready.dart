import 'package:flutter/material.dart';
import 'package:flutter_video_call/common/helpers/configs/generate_unique_userId.dart';
import 'package:flutter_video_call/views/home/components/button.dart';
import 'package:flutter_video_call/views/home/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class JoinMeetingPage extends StatefulWidget {
  @override
  _JoinMeetingPageState createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  String _userEmail = '';
  final TextEditingController _inviteCodeController = TextEditingController();
  String userId = '';

  @override
  void initState() {
    super.initState();
    _loadEmailFromPrefs().then((_) {
      getUserId();
    });
  }

  void getUserId() {
   userId =  UniqueUserId.generateUniqueId(_userEmail);
   setState(() {});
  }

  Future<void> _loadEmailFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString("email") ?? "Unknown User";
    });
  }

  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  void joinMeeting(ZegoUIKitPrebuiltCallConfig config) {

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(userEmail: _userEmail,userId: userId,config: config,)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // 🌟 Blurred Avatar Overlay
              Positioned(
                top: 100,
                left: -30,
                child: Opacity(
                  opacity: 0.25,
                  child: Image.network(
                    'https://robohash.org/$_userEmail.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            _userEmail,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.network(
                              'https://robohash.org/$_userEmail.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                ),
                              ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Text(
                          "Ready to Connect?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Start your voice or video meeting by clicking one of the options below.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          GradientButton(
                            text: "Join Voice Call",
                            onTap: () {
                              joinMeeting(
                                ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          GradientButton(
                            text: "Join Video Call",
                            onTap: () {
                              joinMeeting(
                                ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          GradientButton(
                            text: "Group Voice Call",
                            onTap: () {
                              joinMeeting(
                                ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          GradientButton(
                            text: "Group Video Call",
                            onTap: () {
                              joinMeeting(
                                ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
