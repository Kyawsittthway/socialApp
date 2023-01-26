import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/blocs/create_group_bloc.dart';
import 'package:untitled/pages/contact_page.dart';
import 'package:untitled/resources/colors.dart';
import 'package:untitled/resources/dimens.dart';
import 'package:untitled/utils/extensions.dart';
import 'package:untitled/view_items/contact_az_list_view.dart';
import 'package:untitled/view_items/profile_status_view_item.dart';
import 'package:untitled/view_items/search_bar_view_section.dart';

import '../data/vo/user_vo.dart';

class CreateNewGroupPage extends StatelessWidget {
  CreateNewGroupPage({ Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateGroupBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_BACKGROUND_COLOR,
          title: Text(
            "New Group",
            style: TextStyle(
                fontSize: 24, color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: BACK_BUTTON_SIZE,
              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Consumer<CreateGroupBloc>(
              builder:(context,bloc,child)=> Container(
                height: 50,
                width: 100,
                padding: EdgeInsets.only(
                    right: MARGIN_MEDIUM_2,
                    top: MARGIN_SMALL,
                    bottom: MARGIN_SMALL),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
                    onPressed: () {
                      bloc.onCreateTap();
                      navigateToScreen(context,ContactPage());
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(),
                    )),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GroupNameSection(),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              SearchBarViewSection(),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              ChosenPeopleViewSection(),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Consumer<CreateGroupBloc>(
                  builder:(context,bloc,child)=> ContactsAZListView(
                isCreateGroupPage: true,
                contactLists: bloc.contactList,
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ChosenPeopleViewSection extends StatelessWidget {
  const ChosenPeopleViewSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateGroupBloc>(
      builder:(context,bloc,child)=> Visibility(
        visible:  bloc.chosenUsers.isEmpty ? false : true,
        child: Container(
          height: 200,
          child: ListView.builder(
              itemCount: bloc.chosenUsers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ChosenPeopleView(
                  chosenUserImage: bloc.chosenUsers[index].profileImage ?? "",
                  chosenUserName: bloc.chosenUsers[index].userName ?? "", removeAction: (){
                    bloc.removeChosenUser(bloc.chosenUsers[index]);
                },
                );
              }),
        ),
      ),
    );
  }
}

class ChosenPeopleView extends StatelessWidget {
   ChosenPeopleView({
    Key? key,
    required this.chosenUserName,
    required this.chosenUserImage,
     required this.removeAction,
  }) : super(key: key);
 final  String chosenUserName;
 final  String chosenUserImage;
 final Function removeAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: Stack(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            shadowColor: Colors.black45,
            borderRadius: BorderRadius.circular(5),
            child: Container(
                height: 160,
                padding: EdgeInsets.all(MARGIN_MEDIUM_2),
                child: ProfileStatusViewItem(
                  isActive: true,
                  isConversation: false,
                  profileImage: chosenUserImage,
                  profileName: chosenUserName,
                ),
              ),

          ),
          Padding(
            padding: EdgeInsets.only(left: 100, bottom: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                  ),
                  onPressed: () {
                    removeAction();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GroupNameSection extends StatelessWidget {
  const GroupNameSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateGroupBloc>(
      builder:(context,bloc,child)=> Container(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Group Name",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                decoration: InputDecoration(),
                onFieldSubmitted: (value){
                  bloc.onGroupNameTextFieldChanged(value.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
