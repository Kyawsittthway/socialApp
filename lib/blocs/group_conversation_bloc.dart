import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled/data/model/group_model_impl.dart';

import '../data/model/add_contact_model.dart';
import '../data/model/add_contact_model_impl.dart';
import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/model/group_model.dart';
import '../data/vo/message_vo.dart';

class GroupConversationBloc extends ChangeNotifier{
  List<MessageVO> messages = [];
  bool isLoading = false;
  bool isDisposed = false;
  String currentUserId = "";
  String groupChatId = "";

  File? selectedFile;
  String selectedFileType = "";


  ///Send State
  String message = "";
  String senderProfileImage = "";


  ///Models
  final GroupModel groupModel = GroupModelImpl();
  final AddContactModel contactModel = AddContactModelImpl();
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  GroupConversationBloc({String? groupId}){
    groupChatId = groupId ?? "";
    currentUserId = _mAuthenticationModel.getLoggedInUser().id ?? "";
    contactModel.getUserById(currentUserId).listen((userInfo) {
      senderProfileImage = userInfo.profileImage ?? "";
    });

    groupModel.getGroupMessage(groupChatId).listen((fetchedMessages) {
      messages = fetchedMessages;
      messages.sort((a,b)=>a.timeStamp!.compareTo(b.timeStamp!));
      print("message from group conver bloc :: $messages");
      _notifySafely();
    });

  }

  void onSelectFileChanged(File newFile){
    selectedFile = newFile;
    _notifySafely();
  }

  Future onSendAction(){
    _showLoading();
    return groupModel.sendNewGroupMessage(message, currentUserId, senderProfileImage, selectedFile, selectedFileType, groupChatId).then((value) => _hideLoading());
  }
  void onMessageTextFieldChanged(String newMessage){
    this.message = newMessage;
    _notifySafely();
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}