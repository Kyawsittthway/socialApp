import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:untitled/common_widgets/full_color_button.dart';
import 'package:untitled/pages/moments_page.dart';
import 'package:untitled/resources/dimens.dart';
import 'package:untitled/utils/extensions.dart';

import '../resources/colors.dart';
import '../resources/strings.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
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
                    HI_TEXT,
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
                    CREATE_A_NEW_ACCOUNT,
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
                width: 300,
                height: 300,
                child: Image.asset("assets/images/otp.png"),
              ),
            ),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text(ENTER_PHONE_NO_TEXT),
                    ),
                  ),
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                FullColorButton(name: GET_OTP_TEXT, onTapAction: () {}),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  child: OtpTextField(
                    showFieldAsBox: true,
                    numberOfFields: 4,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(NO_OTP_TEXT,style: TextStyle(
                      color: Colors.grey
                    ),),
                    SizedBox(
                      width: MARGIN_SMALL,
                    ),
                    GestureDetector(
                      child: Text(RESEND_CODE,style: TextStyle(
                      color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                        fontWeight: FontWeight.w700,
                      ),),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: MARGIN_MEDIUM_3,),
            Center(
              child: FullColorButton(name: VERIFY_TEXT, onTapAction: (){
                navigateToScreen(context,MomentsPage());
              }),
            )
          ],
        ),
      ),
    );
  }
}
