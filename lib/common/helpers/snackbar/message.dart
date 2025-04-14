import 'dart:ui';

import 'package:flutter/material.dart';

class AppMessage {
  static void ShowSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text('$message',style: const TextStyle(color: Colors.white),),backgroundColor: color,),
    );
  }
}
