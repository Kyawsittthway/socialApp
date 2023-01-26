import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class ProfileStatusViewItem extends StatelessWidget {
  const ProfileStatusViewItem(
      {Key? key,
      required this.isActive,
      required this.isConversation,
      required this.profileImage,
      required this.profileName})
      : super(key: key);

  final bool isActive;
  final bool isConversation;
  final String profileImage;
  final String profileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(MARGIN_MEDIUM),
          height: isConversation == true ? 60 : 80,
          width: isConversation == true ? 60 : 80,
          child: Stack(
            children: [
              Positioned.fill(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      profileImage),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: MARGIN_MEDIUM),
                  child: isActive
                      ? Container(
                          height: isConversation ? 25 : 30,
                          width: isConversation ? 25 : 30,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(90),
                              border: Border.all(
                                  color: PRIMARY_BACKGROUND_COLOR, width: 5.0)),
                        )
                      : Container(
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Text(
                              "15 mins",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 9,
                                  fontFamily: "Inter"),
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Visibility(
          visible: !isConversation,
          child: Container(
            child: Text(
              profileName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
                fontSize: 9,
              ),
            ),
          ),
        )
      ],
    );
  }
}
