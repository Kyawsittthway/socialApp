import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/blocs/group_conversation_bloc.dart';
import 'package:untitled/resources/colors.dart';
import '../blocs/conversation_bloc.dart';
import '../common_widgets/loading_view.dart';
import '../data/vo/user_vo.dart';
import '../resources/dimens.dart';
import "package:cached_network_image/cached_network_image.dart";

class GroupConversationPage extends StatelessWidget {
  const GroupConversationPage({required this.groupId,required this.groupName,required this.groupImage, Key? key}) : super(key: key);
  final String groupId;
  final String groupName;
  final String groupImage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupConversationBloc(groupId: groupId),
      child: Stack(children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_BACKGROUND_COLOR,
            title: NameAndStatus(
              peerName: groupName,
              peerProfileImage: groupImage,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: BACK_BUTTON_SIZE,
                color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Consumer<GroupConversationBloc>(
                  builder: (context, bloc, child) => Container(
                      height: bloc.selectedFile == null
                          ? MediaQuery.of(context).size.height * 0.75
                          : MediaQuery.of(context).size.height * 0.5,
                      color: PRIMARY_BACKGROUND_COLOR,
                      child: ListView.separated(
                          padding: EdgeInsets.all(MARGIN_MEDIUM_2),
                          itemBuilder: (context, index) {
                            if (bloc.messages[index].senderUserId ==
                                bloc.currentUserId) {
                              if (bloc.messages[index].fileType == "image") {
                                return BubbleNormalImage(
                                  id: '',
                                  image: Container(
                                    constraints: BoxConstraints(
                                      minHeight: 20.0,
                                      minWidth: 20.0,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: bloc.messages[index].file ?? "",
                                      progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                );
                              } else {
                                return BubbleNormal(
                                  text: bloc.messages[index].message ?? "",
                                  isSender: true,
                                  color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }
                            } else {
                              if (bloc.messages[index].fileType == "image") {
                                return BubbleNormalImage(
                                  id: '',
                                  isSender: false,
                                  image: Container(
                                    constraints: BoxConstraints(
                                      minHeight: 20.0,
                                      minWidth: 20.0,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: bloc.messages[index].file ?? "",
                                      progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                );
                              } else {
                                return OtherUserChatView(
                                  messages: bloc.messages[index].message ?? "",
                                  currentIndex: index,
                                  profileView: bloc.messages[index]
                                      .senderProfilePicture ??
                                      "",
                                );
                              }
                            }
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: MARGIN_MEDIUM_2,
                            );
                          },
                          itemCount: bloc.messages.length)),
                ),
                TextBoxAndSendSection(),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                ItemsChoiceButtomSection(),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Consumer<GroupConversationBloc>(
                  builder: (context, bloc, child) => Visibility(
                    visible: bloc.selectedFile == null ? false : true,
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: bloc.selectedFile == null ? Container():Image.file(File(bloc.selectedFile?.path ?? "")),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Consumer<GroupConversationBloc>(
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
      ]),
    );
  }
}

class OtherUserChatView extends StatelessWidget {
  OtherUserChatView({
    Key? key,
    required this.currentIndex,
    required this.messages,
    required this.profileView,
  }) : super(key: key);
  final int currentIndex;
  final String messages;
  final String profileView;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(profileView),
        ),
        BubbleNormal(
          text: messages,
          textStyle: TextStyle(
            color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          color: OTHER_CHAT_BUBBLE_COLOR,
          isSender: false,
        ),
      ],
    );
  }
}

class ItemsChoiceButtomSection extends StatelessWidget {
  const ItemsChoiceButtomSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupConversationBloc>(
      builder: (context, bloc, child) => Container(
        color: PRIMARY_BACKGROUND_COLOR,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ItemChoiceIconView(
              iconPath: 'assets/icons/gallery_icon.png',
              onTapAction: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  bloc.onSelectFileChanged(File(image.path));
                  bloc.selectedFileType = "image";
                }
              },
            ),
            ItemChoiceIconView(
              iconPath: 'assets/icons/camera_icon.png',
              onTapAction: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image =
                await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  bloc.onSelectFileChanged(File(image.path));
                  bloc.selectedFileType = "image";
                }
              },
            ),
            ItemChoiceIconView(
              iconPath: 'assets/icons/gif_icon.png',
              onTapAction: () {},
            ),
            ItemChoiceIconView(
              iconPath: 'assets/icons/location_icon.png',
              onTapAction: () {},
            ),
            ItemChoiceIconView(
              iconPath: 'assets/icons/audio_icon.png',
              onTapAction: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class TextBoxAndSendSection extends StatelessWidget {
  const TextBoxAndSendSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
          Consumer<GroupConversationBloc>(
            builder: (context, bloc, child) => Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Type a message..."),
                  onFieldSubmitted: (message) {
                    bloc.onMessageTextFieldChanged(message);


                  },
                )),
          ),
          SizedBox(
            width: MARGIN_SMALL,
          ),
          Consumer<GroupConversationBloc>(
            builder: (context, bloc, child) => Container(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
              child: CircleAvatar(
                backgroundColor: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {

                    bloc.onSendAction();
                    bloc.selectedFile = null;
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

class ItemChoiceIconView extends StatelessWidget {
  final Function onTapAction;
  final String iconPath;

  ItemChoiceIconView({
    required this.iconPath,
    required this.onTapAction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: PhysicalModel(
        color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black45,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.all(MARGIN_SMALL),
          height: 40,
          width: 40,
          child: Image.asset(iconPath),
        ),
      ),
      onTap: () {
        onTapAction();
      },
    );
  }
}

class NameAndStatus extends StatelessWidget {
  const NameAndStatus({
    Key? key,
    required this.peerProfileImage,
    required this.peerName,
  }) : super(key: key);
  final String peerProfileImage;
  final String peerName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(peerProfileImage),
          ),
          SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  peerName,
                  style: TextStyle(
                    color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                    fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: MARGIN_SMALL,
              ),
              Container(
                child: Text(
                  "Online",
                  style: TextStyle(
                    color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR,
                    fontFamily: GoogleFonts.notoSansMyanmar().fontFamily,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
