import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/blocs/contact_bloc.dart';
import 'package:untitled/network/real_time_database_data_agent_impl.dart';
import 'package:untitled/pages/create_new_group_page.dart';
import 'package:untitled/pages/group_conversation_page.dart';
import 'package:untitled/pages/qr_page.dart';
import 'package:untitled/pages/qr_scan_page.dart';
import 'package:untitled/resources/colors.dart';
import 'package:untitled/resources/dimens.dart';
import 'package:untitled/utils/extensions.dart';
import 'package:untitled/view_items/profile_status_view_item.dart';

import '../common_widgets/bottom_navigator.dart';
import '../data/vo/user_vo.dart';
import '../view_items/contact_az_list_view.dart';
import '../view_items/contact_view_section.dart';
import '../view_items/search_bar_view_section.dart';

class ContactPage extends StatelessWidget {
  ContactPage({
    int? index,
    this.exposedUserId,
    Key? key,
  }) : super(key: key);
  String? exposedUserId;
  @override
  Widget build(BuildContext context) {
    if(exposedUserId != null){
      print("Exposed user id from contact page :: $exposedUserId");
    }
    return ChangeNotifierProvider(
      create:(context)=>ContactBloc(exposedUserId: exposedUserId),
      child: Scaffold(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        appBar: AppBar(
          backgroundColor: PRIMARY_BACKGROUND_COLOR,
          centerTitle: false,
          title: AppBarTitle(),
          actions: [
            GestureDetector(
              child: Container(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.contacts,
                  color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                ),
              ),
              onTap: () {
                navigateToScreen(context, QrPage());
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarViewSection(),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Consumer<ContactBloc>(builder:(context,bloc,child)=> ContactsViews(contactList: bloc.contactLists,)),
              // SearchNotFoundView() /// to show when the searched contact or group is not found
            ],
          ),
        ),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Container(
        //     child: ListView.builder(
        //         itemCount: 26,
        //         shrinkWrap: true,
        //         scrollDirection: Axis.vertical,
        //         physics: NeverScrollableScrollPhysics(),
        //         itemBuilder: (context, index) {
        //           return GestureDetector(
        //             child: Text('A'),
        //           );
        //         }),
        //   ),
        // )
        bottomNavigationBar: BottomNavigator(
          currentIndex: 2,
        ),
      ),
    );
  }
}

class ContactsViews extends StatelessWidget {
   ContactsViews({
    Key? key,
     required this.contactList,
  }) : super(key: key);
  final List<UserVO> contactList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GroupsSection(),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        ContactsAZListView(
          isCreateGroupPage: false, contactLists: contactList,
        ),
      ],
    );
  }
}

class SearchNotFoundView extends StatelessWidget {
  const SearchNotFoundView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 300,
          width: 300,
          child: Image.asset("assets/images/contact_not_found.png"),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Container(
          child: Text(
            "No contact or group with name '' exist",
            style: TextStyle(
              fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class GroupsSection extends StatelessWidget {
  const GroupsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GroupTitleView(),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        GroupsViewSection()
      ],
    );
  }
}

class GroupTitleView extends StatelessWidget {
  const GroupTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: MARGIN_MEDIUM),
      child: Text(
        "Group(3)",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
        ),
      ),
    );
  }
}

class GroupsViewSection extends StatelessWidget {
  const GroupsViewSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactBloc>(
      builder:(context,bloc,child)=> Container(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          itemCount: bloc.groups.length+1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return PhysicalModel(
                color: Colors.white,
                elevation: 10,
                shadowColor: Colors.black45,
                borderRadius: BorderRadius.circular(5),
                child: (index == 0)
                    ? GroupViewItem(
                        isFirstItem: true,
                        onTapAction: () {
                          navigateToScreen(context, CreateNewGroupPage());
                        }, groupName: '',
                      )
                    : GroupViewItem(
                        isFirstItem: false,
                        onTapAction: () {
                          navigateToScreen(context, GroupConversationPage(groupId: bloc.groups[index-1].groupId ?? "", groupName: bloc.groups[index-1].groupName ?? "", groupImage: "https://t4.ftcdn.net/jpg/03/03/72/11/360_F_303721150_Uo6hxtfQVe7B9uxjwPLbgJ0eStClh0r2.jpg"));
                        }, groupName: bloc.groups[index-1].groupName ?? "",
                      ));
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: MARGIN_MEDIUM_2,
            );
          },
        ),
      ),
    );
  }
}

class GroupViewItem extends StatelessWidget {
  GroupViewItem(
      {Key? key, required this.isFirstItem,required this.groupName, required this.onTapAction})
      : super(key: key);
  final bool isFirstItem;
  final Function onTapAction;
  final String groupName;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: isFirstItem == true
                ? SPLASH_SCREEN_BUTTONS_BORDER_COLOR
                : Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              child: isFirstItem == true
                  ? Image.asset("assets/icons/add_group_icon.png")
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        "https://cdn.motor1.com/images/mgl/mrz1e/s3/coolest-cars-feature.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
            SizedBox(height: MARGIN_MEDIUM),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                child: isFirstItem == true
                    ? Text(
                        "Add New",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        groupName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              onTap: (){
                onTapAction();
              },
            ),
          ],
        ),
      ),
      onTap: () {
        onTapAction();
      },
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Contacts",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
        ),
        Text(
          "(5)",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }
}
