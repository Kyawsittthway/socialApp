import 'dart:io';
import 'dart:math';

import 'package:untitled/data/model/moments_model.dart';
import 'package:untitled/data/vo/moment_vo.dart';
import 'package:untitled/network/cloud_firestore_data_agent_impl.dart';
import 'package:untitled/network/wechat_data_agent.dart';

import 'authentication_model.dart';
import 'authentication_model_impl.dart';

class MomentsModelImpl extends MomentModel {
  static final MomentsModelImpl _singleton = MomentsModelImpl._internal();

  factory MomentsModelImpl() {
    return _singleton;
  }

  MomentsModelImpl._internal();

  WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  ///Authentication Model
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  @override
  Future<void> addNewPost(String description, List<File>? imageFiles,String profilePicture) {
    if (imageFiles != null && imageFiles.isNotEmpty) {
      return mDataAgent
          .uploadFiles(imageFiles)
          .then((downloadUrls) => craftMomentVO(description, downloadUrls,profilePicture))
          .then((newMoment) => mDataAgent.addNewPost(newMoment));
    } else {
      return craftMomentVO(description, [],profilePicture)
          .then((newMoment) => mDataAgent.addNewPost(newMoment));
    }
  }

  Future<MomentVO> craftMomentVO(String description, List<String> imageUrls,String profilePicture) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newPost = MomentVO(
        id: currentMilliseconds,
        description: description,
        profilePicture: profilePicture,
        userName: _authenticationModel.getLoggedInUser().userName,
        postImages: imageUrls);

    print("downloadUrls :: ${newPost.postImages}");
    return Future.value(newPost);
  }

  @override
  Future<void> deletePost(int momentId) {
    return mDataAgent.deletePost(momentId);
  }

  @override
  Future<void> editPost(MomentVO moment, List<File>? imageFile) {
    return mDataAgent.addNewPost(moment);
  }

  @override
  Stream<MomentVO> getMomentById(int momentId) {
    return mDataAgent.getMomentById(momentId);
  }

  @override
  Stream<List<MomentVO>> getMoments() {
    return mDataAgent.getMoments();
  }
}
