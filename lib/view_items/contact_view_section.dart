import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/chat_page.dart';
import 'package:untitled/pages/conversation_page.dart';
import 'package:untitled/utils/extensions.dart';

import '../blocs/contact_bloc.dart';
import '../blocs/create_group_bloc.dart';
import '../data/vo/user_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';

class ContactViewSection extends StatelessWidget {
  ContactViewSection({
    Key? key,
    required this.contactList,
    required this.isCreatePage,
  }) : super(key: key);
  final bool isCreatePage;
  final List<UserVO> contactList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            shadowColor: Colors.black45,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(MARGIN_MEDIUM),
              child: ListView.separated(
                itemCount: 1,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contacts",
                          style: TextStyle(
                            color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily:
                                GoogleFonts.notoSansMyanmar().fontFamily,
                          ),
                        ),
                        Container(
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding:
                                EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: contactList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: isCreatePage == true
                                    ? CreateGroupContactItemView(
                                        contact: contactList[index],
                                      )
                                    : GestureDetector(
                                        child: ContactItemView(
                                          profileImage:
                                              contactList[index].profileImage ??
                                                  "",
                                          profileName:
                                              contactList[index].userName ?? "",
                                        ),
                                        onTap: () {
                                          navigateToScreen(
                                              context,
                                              ConversationPage(
                                                peer: contactList[index]
                                              ));
                                        },
                                      ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: MARGIN_MEDIUM_2,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: MARGIN_LARGE,
                    color: PRIMARY_BACKGROUND_COLOR,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ContactItemView extends StatelessWidget {
  ContactItemView({
    required this.profileImage,
    required this.profileName,
    Key? key,
  }) : super(key: key);
  final String profileImage;
  final String profileName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          child: Stack(
            children: [
              Positioned.fill(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.only(bottom: MARGIN_SMALL),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: PRIMARY_BACKGROUND_COLOR, width: 3)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Text(
          profileName,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
              fontFamily: GoogleFonts.notoSansMyanmar().fontFamily),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
      ],
    );
  }
}

class CreateGroupContactItemView extends StatelessWidget {
  CreateGroupContactItemView({
    Key? key,
    required this.contact,
  }) : super(key: key);

final UserVO contact;


  @override
  Widget build(BuildContext context) {
    return Consumer<CreateGroupBloc>(
      builder:(context,bloc,child)=> GestureDetector(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              contact.profileImage ?? ""),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: EdgeInsets.only(bottom: MARGIN_SMALL),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: PRIMARY_BACKGROUND_COLOR, width: 3)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  contact.userName ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                      fontFamily: GoogleFonts.notoSansMyanmar().fontFamily),
                ),
              ],
            ),
            Container(
              height: 20,
              width: 20,
              child: showRespectiveIcon(bloc.chosenUsers.contains(contact)),
            )
          ],
        ),
        onTap: (){
          if(bloc.chosenUsers.contains(contact)) {
            bloc.removeChosenUser(contact);
          }
          else {
            bloc.addChosenUser(contact);

          }
        },
      ),
    );
  }

  showRespectiveIcon(bool isSelected) {
    if (isSelected == true) {
      return Image.asset("assets/icons/checked_icon.png");
    } else {
      return Image.asset("assets/icons/unchecked_icon.png");
    }
  }
}
