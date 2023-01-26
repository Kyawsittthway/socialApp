import 'dart:io';

import '../vo/group_vo.dart';
import '../vo/message_vo.dart';

abstract class GroupModel {
  Future<void> addNewGroup(String groupName, List<String> userIds);

  Future<void> sendNewGroupMessage(
      String message,
      String currentUserId,
      String senderProfileImage,
      File? chosenFile,
      String fileType,
      String groupId);

  Stream<List<GroupVO>> getGroups();
  Stream<List<MessageVO>> getGroupMessage(String groupId);
}
