import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/blocs/add_new_moment_bloc.dart';
import 'package:untitled/common_widgets/full_color_button.dart';
import 'package:untitled/resources/dimens.dart';
import 'dart:io';
import '../common_widgets/loading_view.dart';
import '../resources/colors.dart';

class AddNewMomentPage extends StatelessWidget {
  final int? momentId;

  AddNewMomentPage({this.momentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewMomentBloc(momentId:  momentId),
      child: Stack(
        children: [Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_BACKGROUND_COLOR,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "New Moment",
              style: TextStyle(
                color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            actions: [
              Consumer<AddNewMomentBloc>(
                builder: (context, bloc, child) => Container(
                    padding: EdgeInsets.all(MARGIN_MEDIUM),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                      ),
                      onPressed: () {
                        print("reached here");
                        bloc.onTapAddNewPost().then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Create"),
                    )),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<AddNewMomentBloc>(
                  builder: (context, bloc, child) => Container(
                    padding: EdgeInsets.all(MARGIN_MEDIUM_3),
                    child: ProfileView(
                      userName: bloc.userName,
                      profileImgUrl: bloc.profilePicture,
                    ),
                  ),
                ),
                Consumer<AddNewMomentBloc>(
                  builder: (context, bloc, child) => Container(
                    padding: EdgeInsets.all(MARGIN_MEDIUM_3),
                    child: TextFormField(
                      maxLines: 10,
                      onFieldSubmitted: (value) {
                        bloc.onNewPostTextChanged(value);
                      },
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
                      ),
                      decoration: InputDecoration(
                          hintText: "What's on your mind?",
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                Consumer<AddNewMomentBloc>(
                  builder: (context, bloc, child) => Container(
                    height: 110,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: bloc.chosenImageFiles.length + 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              child: Container(
                                margin: EdgeInsets.all(MARGIN_SMALL),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                                      width: 5.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                  color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                                ),
                              ),
                              onTap: () async {
                                final ImagePicker _picker = ImagePicker();
                                List<File> chosenFiles = [];
                                final List<XFile> pickedFileList =
                                    await _picker.pickMultiImage();
                                if (pickedFileList.isNotEmpty) {
                                  chosenFiles = pickedFileList
                                      .map((e) => File(e.path))
                                      .toList();
                                  bloc.chosenImages(chosenFiles);
                                  print(
                                      "added images :: ${bloc.chosenImageFiles.length}");
                                }
                              },
                            );
                          } else {
                            return Container(
                              height: 110,
                              width: 110,
                              child: Stack(children: [
                                Container(
                                  margin: EdgeInsets.all(MARGIN_SMALL),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Image.file(
                                    bloc.chosenImageFiles[index - 1],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    child: GestureDetector(
                                      child: Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                        size: 35,
                                      ),
                                      onTap: () {
                                        bloc.choosenImageRemoveAt(index - 1);
                                      },
                                    ),
                                  ),
                                )
                              ]),
                            );
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
          Consumer<AddNewMomentBloc>(
            builder:(context,bloc,child)=> Visibility(
              visible: bloc.isLoading,
              child: Container(
                color: Colors.black12,
                child: const Center(
                  child: LoadingView(),
                ),
              ),
            ),
          )
    ]
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  ProfileView({
    Key? key,
    required this.userName,
    required this.profileImgUrl,
  }) : super(key: key);
  final String userName;
  final String profileImgUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            profileImgUrl,
          ),
          radius: MARGIN_XLARGE,
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Text(
          userName,
          style: TextStyle(
              color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
