import 'package:flutter/material.dart';
import 'package:untitled/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import '../resources/dimens.dart';
import '../resources/network_images.dart';

class MomentView extends StatelessWidget {
  MomentView(
      {required this.momentId,
      required this.profileImage,
      required this.userName,
      required this.description,
      this.postImages,
      required this.onTapDelete,
      required this.onTapEdit,
      Key? key})
      : super(key: key);

  final int momentId;
  final String profileImage;
  final String userName;
  final String description;
  final List<String>? postImages;
  final Function(int) onTapDelete;
  final Function(int) onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ProfileImageView(
              profileImage: profileImage,
            ),
            SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            NameLocationAndTimeAgoView(
              userName: userName,
            ),
            Spacer(),
            MoreButtonView(
              onTapEdit: (){
                onTapEdit(momentId);
              },
              onTapDelete: (){
                onTapDelete(momentId);
              },
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        postImageChecker(postImages),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        PostDescriptionView(description: description),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: const [
            Icon(
              Icons.favorite_border,
              color: Colors.grey,
            ),
            SizedBox(
              width: MARGIN_SMALL,
            ),
            Text(
              "10",
              style: TextStyle(color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
            ),
            Spacer(),
            Icon(
              CupertinoIcons.text_bubble,
              color: Colors.grey,
            ),
            SizedBox(
              width: MARGIN_SMALL,
            ),
            Text(
              "10",
              style: TextStyle(color: SPLASH_SCREEN_BUTTONS_BORDER_COLOR),
            ),
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Icon(
              CupertinoIcons.bookmark,
              color: Colors.grey,
            )
          ],
        )
      ],
    );
  }

  postImageChecker(List<String>? postImageUrl) {
    if (postImageUrl == null) {
      print("it's here");
      return Container(
        height: 0,
      );
    } else {
      return Container(
        height: postImageUrl.isEmpty ? 0 : 230,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: postImageUrl?.length,
            itemBuilder: (context, index) {
              return Container(
                  width: 350,
                  margin: EdgeInsets.all(MARGIN_SMALL),
                  child: PostImageView(
                    postImage: postImageUrl?[index],
                  ));
            }),
      );
    }
  }
}

class PostDescriptionView extends StatelessWidget {
  PostDescriptionView({
    required this.description,
    Key? key,
  }) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        fontSize: TEXT_REGULAR,
        color: Colors.black,
      ),
    );
  }
}

class PostImageView extends StatelessWidget {
  PostImageView({
    this.postImage,
    Key? key,
  }) : super(key: key);
  final String? postImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
      child: postImage == null
          ? Container(
              height: 0,
            )
          : FadeInImage(
              height: 200,
              width: double.infinity,
              placeholder: NetworkImage(
                NETWORK_IMAGE_POST_PLACEHOLDER,
              ),
              image: NetworkImage(
                postImage ?? "",
              ),
              fit: BoxFit.fill,
            ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  const MoreButtonView(
      {Key? key, required this.onTapDelete, required this.onTapEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const Icon(
        Icons.more_horiz,
        color: Colors.grey,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text("Edit"),
          value: 1,
          onTap: () {
            onTapEdit();
          },
        ),
        PopupMenuItem(
          child: const Text("Delete"),
          value: 1,
          onTap: () {
            onTapDelete();
          },
        )
      ],
    );
  }
}

class ProfileImageView extends StatelessWidget {
  ProfileImageView({
    required this.profileImage,
    Key? key,
  }) : super(key: key);
  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        profileImage,
      ),
      radius: MARGIN_XLARGE,
    );
  }
}

class NameLocationAndTimeAgoView extends StatelessWidget {
  NameLocationAndTimeAgoView({
    required this.userName,
    Key? key,
  }) : super(key: key);
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              userName,
              style: TextStyle(
                fontSize: TEXT_REGULAR,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: MARGIN_SMALL,
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        const Text(
          "12 hrs ago",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
