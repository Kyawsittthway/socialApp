import 'package:flutter/material.dart';

import '../data/model/add_contact_model.dart';
import '../data/model/add_contact_model_impl.dart';
import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/model/group_model.dart';
import '../data/model/group_model_impl.dart';
import '../data/vo/message_vo.dart';
import '../data/vo/user_vo.dart';

class CreateGroupBloc extends ChangeNotifier{
  ///States
  String groupName = "";
  List<UserVO> chosenUsers = [];
  List<UserVO> contactList = [];
  bool isLoading = false;
  bool isDisposed = false;
  UserVO? currentUser;

  ///Models
  final AddContactModel contactModel = AddContactModelImpl();
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();
  final GroupModel groupModel = GroupModelImpl();

  CreateGroupBloc() {
    contactModel.getUserById(_mAuthenticationModel.getLoggedInUser().id ?? "").listen((userInfo) {
      currentUser = userInfo;

    });
    // groupModel.sendNewGroupMessage(MessageVO(
    //
    //   file: "",
    //   fileType: "",
    //   message: "wassup",
    //   senderName: "",
    //   senderProfilePicture: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzZT0yxib02UjrDFRbFkI9ht4etmwqYAPWhSINCSFV&s",
    //   senderUserId: "TThEYVXAzmghTpNxbQw68R8wTfn2",
    //   timeStamp: "${DateTime.now().millisecondsSinceEpoch.toString()}",
    // ), "1673652822115");
    contactModel
        .getCurrentUserContacts(
        _mAuthenticationModel.getLoggedInUser().id ?? "")
        .listen((value) {
      contactList = value;

      _notifySafely();
    });
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void onGroupNameTextFieldChanged(String newGroupName){
    groupName = newGroupName;
    _notifySafely();
  }
  void addChosenUser(UserVO chosenContact){
    chosenUsers.add(chosenContact);
    _notifySafely();
  }

  void removeChosenUser(UserVO chosenContact){
    chosenUsers.remove(chosenContact);
    _notifySafely();
  }
  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  Future onCreateTap(){
    chosenUsers.add(currentUser!);
    return groupModel.addNewGroup(groupName, chosenUsers.map((e) => e.id ?? "").toList(),);
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}