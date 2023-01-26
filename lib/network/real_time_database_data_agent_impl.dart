import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/data/vo/moment_vo.dart';
import 'package:untitled/data/vo/user_vo.dart';
import 'package:untitled/network/wechat_data_agent.dart';

import '../data/vo/group_vo.dart';
import '../data/vo/message_vo.dart';

/// Database Paths
const usersPath = "users";
const contactAndMessagePath = "contactsAndMessages";
const groups = "groups";

/// File Upload Reference
const fileUploadRef = "uploads";

class RealTimeDatabaseDataAgentImpl extends WeChatDataAgent {
  static final RealTimeDatabaseDataAgentImpl _singleton =
      RealTimeDatabaseDataAgentImpl._internal();

  factory RealTimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealTimeDatabaseDataAgentImpl._internal();

  /// Database
  var databaseRef = FirebaseDatabase.instance.reference();

  ///Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  ///Storage
  var firebaseStorage = FirebaseStorage.instance;

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) =>
            credential.user?..updateDisplayName(newUser.userName))
        .then((user) {
      newUser.id = user?.uid ?? "";
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser) {
    return databaseRef
        .child(usersPath)
        .child(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
      id: auth.currentUser?.uid,
      email: auth.currentUser?.email,
      userName: auth.currentUser?.displayName,
    );
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Future<void> addNewPost(MomentVO newPost) {
    // TODO: implement addNewPost
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(int postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Stream<List<MomentVO>> getMoments() {
    // TODO: implement getNewsFeed
    throw UnimplementedError();
  }

  @override
  Stream<MomentVO> getMomentById(int newsFeedId) {
    // TODO: implement getNewsFeedById
    throw UnimplementedError();
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return firebaseStorage
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Future<List<String>> uploadFiles(List<File> images) {
    throw UnimplementedError();
  }

  @override
  Stream<UserVO> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<void> addMutualContacts(String userId, String exposedUserId) {
    // TODO: implement addMutualContacts
    throw UnimplementedError();
  }

  @override
  Stream<List<UserVO>> getCurrentUserContacts(String currentUserId) {
    // TODO: implement getCurrentUserContacts
    throw UnimplementedError();
  }

  @override
  Stream<List<MessageVO>> getCurrentUserMessages(
      String currentUserId, String peerId) {
    print("current user id :: $currentUserId");
    return databaseRef
        .child(contactAndMessagePath)
        .child(currentUserId)
        .child(peerId)
        .onValue
        .map((messages) {
      print("messages :: ${messages.snapshot.value}");
      return (messages.snapshot.value as Map<dynamic, dynamic>)
          .values
          .map<MessageVO>((element) {
        print("element is :: ${element}");
        return MessageVO.fromJson(Map<String, dynamic>.from(element));
      }).toList();
    });
  }

  @override
  Future<void> sendNewPeerMessage(
      MessageVO message, String currentUserId, String peerId) {
    print("peer id from sendNewPerrMessage :: $peerId");

    ///Render the data for the receiver layer
    receiveNewPeerMessage(message, currentUserId, peerId);

    return databaseRef
        .child(contactAndMessagePath)
        .child(currentUserId)
        .child(peerId)
        .child(message.timeStamp ?? "")
        .set(message.toJson());
  }

  @override
  Future<void> receiveNewPeerMessage(
      MessageVO message, String currentUserId, String peerId) {
    return databaseRef
        .child(contactAndMessagePath)
        .child(peerId)
        .child(currentUserId)
        .child(message.timeStamp ?? "")
        .set(message.toJson());
  }

  @override
  Future<void> addNewGroup(GroupVO newGroup) {
    return databaseRef
        .child(groups)
        .child(newGroup.groupId ?? "${DateTime.now().millisecondsSinceEpoch}")
        .set(newGroup.toJson());
  }

  @override
  Future<void> sendNewGroupMessage(MessageVO message, String groupId) {
    return databaseRef
        .child(groups)
        .child(groupId)
        .child("messages")
        .child(message.timeStamp ?? "")
        .set(message.toJson());
  }

  @override
  Stream<List<MessageVO>> getGroupMessage(String groupId) {
    return databaseRef
        .child(groups)
        .child(groupId)
        .child("messages")
        .onValue
        .map((messages) {
      print("messages :: ${messages.snapshot.value}");
      return (messages.snapshot.value as Map<dynamic, dynamic>)
          .values
          .map<MessageVO>((element) {
        print("element is :: ${element}");
        return MessageVO.fromJson(Map<dynamic, dynamic>.from(element));
      }).toList();
    });
  }

  @override
  Stream<List<GroupVO>> getGroups() {
    return databaseRef.child(groups).onValue.map((event) {
      print("Groups :: ${event.snapshot.value}");
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .map<GroupVO>((element) {
        return GroupVO.fromJson(Map<dynamic, dynamic>.from(element));
      }).toList();
    });
  }
}
