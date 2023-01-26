import 'dart:io';

import 'package:untitled/data/vo/moment_vo.dart';

import '../data/vo/group_vo.dart';
import '../data/vo/message_vo.dart';
import '../data/vo/user_vo.dart';

abstract class WeChatDataAgent {
  ///Authentication
  Future registerNewUser(UserVO newUser);

  Future login(String email, String password);

  bool isLoggedIn();

  UserVO getLoggedInUser();

  Future logOut();

  ///Moments
  Stream<List<MomentVO>> getMoments();

  Future<void> addNewPost(MomentVO newPost);

  Future<void> deletePost(int postId);

  Stream<MomentVO> getMomentById(int newsFeedId);

  Future<String> uploadFileToFirebase(File image);

  Future<List<String>> uploadFiles(List<File> images);

  ///Add contact
  Stream<UserVO> getUserById(String id);

  Future<void> addMutualContacts(String userId, String exposedUserId);

  Stream<List<UserVO>> getCurrentUserContacts(String currentUserId);

  ///Chat
  Stream<List<MessageVO>> getCurrentUserMessages(
      String currentUserId, String peerId);

  Future<void> sendNewPeerMessage(
      MessageVO message, String currentUserId, String peerId);

  Future<void> receiveNewPeerMessage(
      MessageVO message, String currentUserId, String peerId);

  ///Group Chat
  Future<void> addNewGroup(GroupVO newGroup);

  Future<void> sendNewGroupMessage(MessageVO message,String groupId);

  Stream<List<GroupVO>> getGroups();

  Stream<List<MessageVO>> getGroupMessage(String groupId);
}
