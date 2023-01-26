import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/blocs/chat_bloc.dart';
import 'package:untitled/pages/conversation_page.dart';
import 'package:untitled/resources/colors.dart';
import 'package:untitled/resources/dimens.dart';
import 'package:untitled/resources/strings.dart';
import 'package:untitled/utils/extensions.dart';

import '../common_widgets/bottom_navigator.dart';
import '../utils/read_status_enum.dart';
import '../view_items/profile_status_view_item.dart';

class ChatPage extends StatelessWidget {
  ChatPage({int? index, Key? key}) : super(key: key);
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatBloc(),
      child: Scaffold(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: false,
          title: Text(
            "Chats",
            style: TextStyle(
              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
              fontWeight: FontWeight.w600,
              fontSize: 34,
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MARGIN_MEDIUM_3, vertical: 10),
              child: ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.search),
                style: ElevatedButton.styleFrom(
                  primary: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Text(
                  ACTIVE_NOW,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Consumer<ChatBloc>(
                builder: (context, bloc, child) => Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bloc.contactLists.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: ProfileStatusViewItem(
                              isActive: isActive,
                              isConversation: false,
                              profileImage:
                                  bloc.contactLists[index].profileImage ?? "",
                              profileName:
                                  bloc.contactLists[index].userName ?? "",
                            ),
                            onTap: () {
                              navigateToScreen(
                                  context,
                                  ConversationPage(
                                      peer: bloc.contactLists[index]));
                            });
                      }),
                ),
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Consumer<ChatBloc>(
                builder: (context, bloc, child) => Container(
                  // height: MediaQuery.of(context).size.height * 0.75,
                  // width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: bloc.contactLists.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM,
                                vertical: MARGIN_SMALL),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white10,
                                  blurRadius: 1,
                                  offset: Offset(4, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProfileStatusViewItem(
                                  isActive: isActive,
                                  isConversation: true,
                                  profileName: '',
                                  profileImage: bloc.contactLists[index].profileImage ?? "",
                                ),
                                // SizedBox(width: MARGIN_MEDIUM,),
                                NameAndSendView(
                                  profileName:
                                      bloc.contactLists[index].userName ?? "",
                                ),
                                SizedBox(
                                  width: MARGIN_MEDIUM,
                                ),
                                SentDateAndReadStatusView(
                                  sentTimeStatus: "5mins ago",
                                  status: ReadStatus.read,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            navigateToScreen(
                                context,
                                ConversationPage(
                                    peer: bloc.contactLists[index]));
                          },
                        );
                      }),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigator(
          currentIndex: 1,
        ),
      ),
    );
  }
}

class NameAndSendView extends StatelessWidget {
  const NameAndSendView({
    Key? key,
    required this.profileName,
  }) : super(key: key);
  final String profileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Text(
              profileName,
              style: TextStyle(
                fontSize: 16,
                fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Container(
            child: Text("You sent a message"),
          )
        ],
      ),
    );
  }
}

class SentDateAndReadStatusView extends StatelessWidget {
  const SentDateAndReadStatusView(
      {Key? key, required this.sentTimeStatus, required this.status})
      : super(key: key);
  final String sentTimeStatus;
  final ReadStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          child: Text("5 mins"),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Container(
          height: 30,
          width: 30,
          child: respectiveIcon(status),
        )
      ],
    );
  }

  respectiveIcon(ReadStatus status) {
    if (status == ReadStatus.read) {
      return Image.asset(
        "assets/icons/read_icon.png",
      );
    } else if (status == ReadStatus.mute) {
      return Image.asset("assets/icons/mute_icon.png");
    } else {
      return Image.asset("assets/icons/sent_icon.png");
    }
  }
}
