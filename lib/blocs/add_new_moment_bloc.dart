import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled/data/model/moments_model.dart';
import 'package:untitled/data/model/moments_model_impl.dart';
import 'package:untitled/network/wechat_data_agent.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/vo/moment_vo.dart';
import '../data/vo/user_vo.dart';

class AddNewMomentBloc extends ChangeNotifier {
  ///States
  String description = "";
  bool isAddNewPostError = false;
  bool isDisposed = false;
  bool isLoading = false;
  UserVO? _loggedInUser;

  /// Image
  List<File> chosenImageFiles = [];

  /// For Edit Mode
  bool isInEditMode = false;
  String userName = "";
  String profilePicture = "";
  MomentVO? moment;

  ///Models
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();
  final MomentModel _momentModel = MomentsModelImpl();

  AddNewMomentBloc({int? momentId}) {
    print("moment id is $momentId");
    _loggedInUser = _authenticationModel.getLoggedInUser();
    if (momentId != null) {
      isInEditMode = true;
      _prepopulateDataForEditMode(momentId);
    } else {
      _prepopulateDataForAddNewPost();
    }
  }

  void _prepopulateDataForAddNewPost() {
    userName = _loggedInUser?.userName ?? "";
    profilePicture = _loggedInUser?.profileImage ??
        "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
    _notifySafely();
  }

  //
  void _prepopulateDataForEditMode(int momentId) {
    _momentModel.getMomentById(momentId).listen((newMoment) {
      print("new moment :: $newMoment");
      userName = newMoment.userName ?? "Elon Prata";
      profilePicture = newMoment.profilePicture ??
          "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
      description = newMoment.description ?? "";
      moment = newMoment;
      _notifySafely();
    });
  }

  void onImageChosen(File imageFile) {
    chosenImageFiles.add(imageFile);
    _notifySafely();
  }

  void chosenImages(List<File> images){
    chosenImageFiles = images;
    _notifySafely();
  }

  void choosenImageRemoveAt(int index){
    chosenImageFiles.removeAt(index);
    _notifySafely();
  }

  // void onTapDeleteImage() {
  //   chosenImageFile = null;
  //   _notifySafely();
  // }
  //
  void onNewPostTextChanged(String newPostDescription) {
    this.description = newPostDescription;
  }

  Future onTapAddNewPost() {
    if (description.isEmpty) {
      isAddNewPostError = true;
      _notifySafely();
      return Future.error("Error");
    } else {
      isLoading = true;
      _notifySafely();
      isAddNewPostError = false;
      if (isInEditMode) {
        return _editMoment().then((value) {
          isLoading = false;
          _notifySafely();
        });
      } else {
        return _createNewNewsFeedPost().then((value) {
          isLoading = false;
          _notifySafely();
        });
      }
    }
  }

  Future<dynamic> _editMoment() {
    moment?.description = description;
    if (moment != null) {
      // return _model.editPost(mNewsFeed!, chosenImageFile);
      return _momentModel.editPost(moment!, chosenImageFiles);
    } else {
      return Future.error("Error");
    }
  }

  Future<void> _createNewNewsFeedPost() {
    return _momentModel.addNewPost(description, chosenImageFiles,profilePicture);
    // return _model.addNewPost(newPostDescription);
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }

    @override
    void dispose() {
      super.dispose();
      isDisposed = true;
    }
  }
}
