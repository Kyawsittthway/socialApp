import 'dart:io';

import 'package:untitled/data/model/message_model.dart';
import 'package:untitled/network/cloud_firestore_data_agent_impl.dart';
import 'package:untitled/network/real_time_database_data_agent_impl.dart';

import '../../network/wechat_data_agent.dart';
import '../vo/message_vo.dart';
import 'authentication_model.dart';
import 'authentication_model_impl.dart';

class MessageModelImpl extends MessageModel {
  static final MessageModelImpl _singleton = MessageModelImpl._internal();

  factory MessageModelImpl() {
    return _singleton;
  }

  MessageModelImpl._internal();

  WeChatDataAgent mDataAgent = RealTimeDatabaseDataAgentImpl();

  ///Authentication Model
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  // /// wechat model
  // final WeChatDataAgent cloudFireDataAgent = CloudFireStoreDataAgentImpl();

  @override
  Stream<List<MessageVO>> getCurrentUserMessages(
      String currentUserId, String peerId) {
    return mDataAgent.getCurrentUserMessages(currentUserId, peerId);
  }


  @override
  Future<void> sendNewPeerMessage(String message,String currentUserId,String peerId,String senderProfileImage,File? chosenFile,String fileType){
    if(chosenFile != null){
      return mDataAgent
          .uploadFileToFirebase(chosenFile)
          .then((downloadUrl) => craftMessageVO(message, currentUserId, peerId, senderProfileImage,downloadUrl,fileType))
          .then((newMessage) => mDataAgent.sendNewPeerMessage(newMessage, currentUserId, peerId));
    }else{
      return craftMessageVO(message, currentUserId, peerId, senderProfileImage,"","").then((newMessage) => mDataAgent.sendNewPeerMessage(newMessage, currentUserId, peerId));
    }
  }

  Future<MessageVO> craftMessageVO(String message, String currentUserId,
      String peerId, String senderProfileImage,String fileUrl,String fileType) {
    var currentMilliSeconds = DateTime.now().millisecondsSinceEpoch;
    var newMessage = MessageVO(
      file: fileUrl,
      fileType: fileType,
      message: message,
      senderName: _authenticationModel.getLoggedInUser().userName,
      senderProfilePicture: senderProfileImage,
      senderUserId: _authenticationModel.getLoggedInUser().id,
      timeStamp: currentMilliSeconds.toString(),
    );

    return Future.value(newMessage);
  }
}
