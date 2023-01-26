import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/account_register_page.dart';
import 'package:untitled/pages/login_page.dart';
import 'package:untitled/resources/colors.dart';
import 'package:untitled/resources/dimens.dart';
import 'package:untitled/resources/strings.dart';
import 'package:untitled/utils/extensions.dart';

import '../common_widgets/full_color_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SafeArea(child: Container()),
              Center(
                child: Image.asset("assets/images/img.png"),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                SPLASH_SCREEN_TEXT_1,
                style: TextStyle(
                  color: SPLASH_SCREEN_TEXT_1_COLOR,
                  fontWeight: FontWeight.w600,
                  fontFamily: "YorkieDemo",
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: MARGIN_SMALL,
              ),
              Text(
                SPLASH_SCREEN_TEXT_2,
                style: TextStyle(
                  color: SPLASH_SCREEN_TEXT_1_COLOR,
                ),
              ),
              SizedBox(
                height: MARGIN_XXLARGE,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        navigateToScreen(context, AccountRegisterPage());
                      },
                      child: Text(
                        SPLASH_SCREEN_SIGN_UP_TEXT,
                        style: TextStyle(
                          color: SPLASH_SCREEN_TEXT_1_COLOR,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(
                              width: 2.0,
                              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR)),
                    ),
                  ),
                  FullColorButton(
                    name: SPLASH_SCREEN_LOG_IN_TEXT,
                    onTapAction: () {
                      navigateToScreen(context, LoginPage());
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
