import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/blocs/login_bloc.dart';
import 'package:untitled/common_widgets/full_color_button.dart';
import 'package:untitled/pages/otp_page.dart';
import 'package:untitled/resources/colors.dart';
import 'package:untitled/utils/extensions.dart';

import '../resources/dimens.dart';
import '../resources/strings.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                    size: BACK_BUTTON_SIZE,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              Container(
                padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      WELCOME_TEXT,
                      style: TextStyle(
                          color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                          fontSize: 30,
                          fontFamily: 'YorkieDemo',
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    Text(
                      LOG_IN_TO_CONTINUE_TEXT,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  child: Image.asset("assets/images/login_logo.png"),
                ),
              ),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Consumer<LoginBloc>(
                      builder: (context, bloc, child) => Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'YorkieDemo',
                          ),
                          decoration: InputDecoration(
                            hintText: ENTER_PHONE_NO_TEXT,
                            label: Text(ENTER_PHONE_NO_TEXT,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                          onChanged: (email) {
                            bloc.onEmailChanged(email);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM,
                    ),
                    Consumer<LoginBloc>(
                      builder: (context, bloc, child) => Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'YorkieDemo',
                          ),
                          decoration: InputDecoration(
                            hintText: ENTER_PASSWORD_TEXT,
                            label: Text(
                              ENTER_PASSWORD_TEXT,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          onChanged: (password) {
                            bloc.onPasswordChanged(password);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM,
                    ),
                    GestureDetector(
                      child: Container(
                        child: Text(
                          FORGOT_PASSWORD_TEXT,
                          style: TextStyle(
                              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                                  GoogleFonts.notoSansMyanmar().fontFamily),
                        ),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Consumer<LoginBloc>(
                builder: (context, bloc, child) => Center(
                  child: FullColorButton(
                      name: SPLASH_SCREEN_LOG_IN_TEXT,
                      onTapAction: () {
                        bloc.onTapLogin().then(
                              (_) => navigateToScreen(
                                context,
                                OtpPage(),
                              ),
                            );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
