
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled/data/model/add_contact_model.dart';
import 'package:untitled/data/model/add_contact_model_impl.dart';
import 'package:untitled/data/model/authentication_model.dart';
import 'package:untitled/data/model/authentication_model_impl.dart';
import 'package:untitled/data/model/message_model_impl.dart';

import '../data/model/message_model.dart';
import '../data/vo/message_vo.dart';

class ConversationBloc extends ChangeNotifier{

  List<MessageVO> messages = [];
  bool isLoading = false;
  bool isDisposed = false;
  String currentUserId = "";
  String peerId = "";

  File? selectedFile;
  String selectedFileType = "";

  ///Send State
  String message = "";
  String senderProfileImage = "";


  ///Models
  final MessageModel messageModel = MessageModelImpl();
  final AddContactModel contactModel = AddContactModelImpl();
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  ConversationBloc({String? peerId}){
    this.peerId = peerId ?? "";
    currentUserId = _mAuthenticationModel.getLoggedInUser().id ?? "";
    messageModel.getCurrentUserMessages(currentUserId,peerId ?? "").listen((event) {
      print("event from bloc :: ${event}");
      messages = event;
      messages.sort((a,b)=>a.timeStamp!.compareTo(b.timeStamp!));
      print("conversation bloc messagessss :: ${event[0].senderName}");
      _notifySafely();
    });

    contactModel.getUserById(currentUserId).listen((user) {
      senderProfileImage  = user.profileImage ?? "";
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

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
  Future onSendAction(){
    _showLoading();
    return messageModel.sendNewPeerMessage(message, currentUserId, peerId, senderProfileImage, selectedFile,selectedFileType).then((value) => _hideLoading());
  }
  void onMessageTextFieldChanged(String newMessage){
    this.message = newMessage;
    _notifySafely();
  }

  void onSelectFileChanged(File newFile){
    selectedFile = newFile;
    _notifySafely();
  }
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}