import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/strings.dart';

class FullColorButton extends StatelessWidget {
  final String name;
  final Function? onTapAction;
  FullColorButton({
    required this.name,
    required this.onTapAction,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
         if(onTapAction != null){
           onTapAction!();
         }else{
           null;
         }
        },
        style: ElevatedButton.styleFrom(
            primary: SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
        child: Text(name),
      ),
    );
  }
}