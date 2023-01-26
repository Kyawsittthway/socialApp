import 'dart:io';

import 'package:untitled/data/model/group_model.dart';
import 'package:untitled/data/vo/group_vo.dart';
import 'package:untitled/data/vo/message_vo.dart';

import '../../network/real_time_database_data_agent_impl.dart';
import '../../network/wechat_data_agent.dart';
import 'authentication_model.dart';
import 'authentication_model_impl.dart';

class GroupModelImpl extends GroupModel {
  static final GroupModelImpl _singleton = GroupModelImpl._internal();

  factory GroupModelImpl() {
    return _singleton;
  }

  GroupModelImpl._internal();

  WeChatDataAgent mDataAgent = RealTimeDatabaseDataAgentImpl();

  ///Authentication Model
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  @override
  Future<void> addNewGroup(String groupName, List<String> userIds) {
    return craftGroupVO(groupName, userIds)
        .then((newGroup) => mDataAgent.addNewGroup(newGroup));
  }

  Future<GroupVO> craftGroupVO(String groupName, List<String> userIds) {
    var newGroup = GroupVO(
        groupName: groupName,
        groupId: DateTime.now().millisecondsSinceEpoch.toString(),
        userIds: userIds,
        messages: {});
    return Future.value(newGroup);
  }

  Future<MessageVO> craftMessageVO(
      String message,
      String currentUserId,
      String groupId,
      String senderProfileImage,
      String fileUrl,
      String fileType) {
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

  @override
  Stream<List<GroupVO>> getGroups() {
    return mDataAgent.getGroups();
  }

  @override
  Future<void> sendNewGroupMessage(
      String message,
      String currentUserId,
      String senderProfileImage,
      File? chosenFile,
      String fileType,
      String groupId) {
    if (chosenFile != null) {
      return mDataAgent
          .uploadFileToFirebase(chosenFile)
          .then((downloadUrl) => craftMessageVO(message, currentUserId, groupId,
              senderProfileImage, downloadUrl, fileType))
          .then((newMessage) =>
              mDataAgent.sendNewGroupMessage(newMessage, groupId));
    } else {
      print("it is here");
      return craftMessageVO(
              message, currentUserId, groupId, senderProfileImage, "", "")
          .then((newMessage) =>
              mDataAgent.sendNewGroupMessage(newMessage, groupId));
    }
  }

  @override
  Stream<List<MessageVO>> getGroupMessage(String groupId){
    return mDataAgent.getGroupMessage(groupId);
  }
}
