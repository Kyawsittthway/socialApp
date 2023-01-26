
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NavigationUtility on Widget{
  void navigateToScreen(BuildContext context, Widget nextScreen){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>nextScreen),
    );

  }
  void navigateToScreenWithRemove(BuildContext context,Widget nextScreen){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>nextScreen), (Route<dynamic>route) => route == nextScreen);
  }
}