import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:untitled/blocs/profile_bloc.dart';
import 'package:untitled/resources/dimens.dart';
import '../common_widgets/bottom_navigator.dart';
import '../data/vo/user_vo.dart';
import '../resources/colors.dart';
import '../view_items/moments_view.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({int? index, Key? key}) : super(key: key);

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String? gender;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_BACKGROUND_COLOR,
          centerTitle: false,
          title: Text(
            "Me",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
              fontSize: 34,
            ),
          ),
          actions: [
            Container(
              height: 30,
              width: 65,
              padding: EdgeInsets.all(MARGIN_MEDIUM),
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          Center(
                            child: Material(
                              child: Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.75,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.9,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    EditInfoTextField(
                                      textFieldName: 'Name',
                                    ),
                                    SizedBox(
                                      height: MARGIN_SMALL,
                                    ),
                                    EditInfoTextField(
                                      textFieldName: 'Phone Number',
                                    ),
                                    SizedBox(
                                      height: MARGIN_MEDIUM_2,
                                    ),
                                    DateOfBirthAndGenderSection(
                                        items: items,
                                        dropdownvalue: dropdownvalue,
                                        gender: gender),
                                    SizedBox(
                                      height: MARGIN_MEDIUM_2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                side: BorderSide(
                                                    width: 2.0,
                                                    color:
                                                    SPLASH_SCREEN_BUTTONS_BORDER_COLOR)),
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color:
                                                  SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
                child: Icon(
                  Icons.edit,
                  size: 20,
                ),
                style: ElevatedButton.styleFrom(
                    primary: SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePictureSection(),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: Text(
                  "Bookmarked Moments",
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Container(
                color: PRIMARY_BACKGROUND_COLOR,
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: MARGIN_LARGE, horizontal: MARGIN_LARGE),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // return MomentView();
                      return Container();
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: MARGIN_XLARGE,
                      );
                    },
                    itemCount: 3),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigator(
          currentIndex: 3,
        ),
      ),
    );
  }
}

class DateOfBirthAndGenderSection extends StatelessWidget {
  const DateOfBirthAndGenderSection({
    Key? key,
    required this.items,
    required this.dropdownvalue,
    required this.gender,
  }) : super(key: key);

  final List<String> items;
  final String dropdownvalue;
  final String? gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Text(
            "Date of Birth",
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                decoration: TextDecoration.none),
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Row(
            children: [
              DropdownButton(
                onChanged: (value) {
                  print(value);
                },
                items: items.map((items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                value: dropdownvalue,
              ),
              SizedBox(
                width: MARGIN_MEDIUM_2,
              ),
              DropdownButton(
                onChanged: (value) {
                  print(value);
                },
                items: items.map((items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                value: dropdownvalue,
              ),
              SizedBox(
                width: MARGIN_MEDIUM_2,
              ),
              DropdownButton(
                onChanged: (value) {
                  print(value);
                },
                items: items.map((items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                value: dropdownvalue,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        GenderSection(gender: gender)
      ],
    );
  }
}

class GenderSection extends StatelessWidget {
  const GenderSection({
    Key? key,
    required this.gender,
  }) : super(key: key);

  final String? gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("Gender",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.none)),
          ),
          RadioListTile(
            title: Text("Male"),
            value: "male",
            groupValue: gender,
            onChanged: (value) {
              print(value);
            },
          ),
          RadioListTile(
            title: Text("Female"),
            value: "female",
            groupValue: gender,
            onChanged: (value) {
              print(value);
            },
          ),
          RadioListTile(
            title: Text("Other"),
            value: "other",
            groupValue: gender,
            onChanged: (value) {
              print(value);
            },
          )
        ],
      ),
    );
  }
}

class EditInfoTextField extends StatelessWidget {
  EditInfoTextField({Key? key, required this.textFieldName}) : super(key: key);
  final String textFieldName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: MARGIN_MEDIUM_2),
            child: Text(
              textFieldName,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          Container(
            child: TextFormField(),
          )
        ],
      ),
    );
  }
}

class ProfilePictureSection extends StatelessWidget {
  const ProfilePictureSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBloc>(
      builder: (context, bloc, child) =>
          Container(
            margin: EdgeInsets.all(MARGIN_MEDIUM_2),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ProfilePictureView(user: bloc.currentUser!),
          ),
    );
  }
}

class ProfilePictureView extends StatelessWidget {
  final UserVO user;

  const ProfilePictureView({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ProfileImageView(
          userId: user.id.toString(), profileImage: user.profileImage ?? "",),
        ProfilePictureInfoView(gender: user?.gender ?? "",userName: user?.userName ?? "",dateOfBirth: user?.dateOfBirth ?? "",)
      ],
    );
  }
}

class ProfileImageView extends StatelessWidget {
  final String profileImage;
  final String userId;

  ProfileImageView({
    required this.profileImage,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 140,
              width: 140,
              child: CircleAvatar(
                backgroundImage: NetworkImage(profileImage),
              ),
            ),
          ),
          GestureDetector(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    margin: EdgeInsets.only(
                        bottom: MARGIN_MEDIUM, right: MARGIN_MEDIUM_2),
                    height: 50,
                    width: 50,
                    child: QrImage(
                      data: userId,
                      version: QrVersions.auto,
                      size: 50.0,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.all(4),
                    )),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      Center(
                        child: Material(
                          child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.4,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.85,
                            color: Colors.transparent,
                            child: QrImage(
                              data: userId,
                              version: QrVersions.auto,
                              size: 10.0,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                );
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: IconButton(
              icon: Icon(
                Icons.photo,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}

class ProfilePictureInfoView extends StatelessWidget {
  const ProfilePictureInfoView({
    required this.userName,
    required this.dateOfBirth,
    required this.gender,
    Key? key,
  }) : super(key: key);
  final String userName;
  final String dateOfBirth;
  final String gender;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            ProfileInfoViewItem(
              icon: Icons.phone_android,
              info: '09 123123123',
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            ProfileInfoViewItem(
              icon: Icons.calendar_today,
              info: dateOfBirth,
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            ProfileInfoViewItem(
              icon: Icons.transgender,
              info: gender.toUpperCase(),
            )
          ]),
    );
  }
}

class ProfileInfoViewItem extends StatelessWidget {
  ProfileInfoViewItem({
    required this.info,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 25,
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          info,
          style: TextStyle(
            fontSize: 14,
            fontFamily: GoogleFonts
                .notoSansMyanmar()
                .fontFamily,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
