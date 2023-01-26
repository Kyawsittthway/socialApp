import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/data/vo/group_vo.dart';
import 'package:untitled/data/vo/message_vo.dart';
import 'package:untitled/data/vo/moment_vo.dart';
import 'package:untitled/network/wechat_data_agent.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../data/vo/user_vo.dart';

/// Collections
const usersCollection = "users";
const momentCollection = "moments";
const fileUploadRef = "uploads";

class CloudFireStoreDataAgentImpl extends WeChatDataAgent {
  /// FireStore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  final firebaseStorage = FirebaseStorage.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

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
    return _fireStore
        .collection(usersCollection)
        .doc(newUser.id.toString())
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
    return _fireStore
        .collection(momentCollection)
        .doc(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return _fireStore
        .collection(momentCollection)
        .doc(postId.toString())
        .delete();
  }

  @override
  Stream<List<MomentVO>> getMoments() {
    return _fireStore
        .collection(momentCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<MomentVO>((document) {
        return MomentVO.fromJson(document.data());
      }).toList();
    });
  }

  Stream<List<UserVO>> getCurrentUserContacts(String currentUserId){
    _fireStore.clearPersistence();
    print("current user id from data agent :: ${currentUserId}");
    print(_fireStore.collection(usersCollection).doc(currentUserId).collection("contacts").path);
    _fireStore.settings = Settings(persistenceEnabled: false);

    return _fireStore
  .collection(usersCollection)
  .doc(currentUserId)
        .collection("contacts")
        .snapshots()
        .map((querySnapshot){
          return querySnapshot.docs.map<UserVO>((document){
            return UserVO.fromJson(document.data());
          }).toList();
    });
}

  @override
  Stream<UserVO> getUserById(String id) {
    return _fireStore
        .collection(usersCollection)
        .doc(id)
        .get()
        .asStream()
        .where((documentSnapshot) => documentSnapshot.data() != null)
        .map((documentSnapshot) => UserVO.fromJson(documentSnapshot.data()!));
  }

  @override
  Stream<MomentVO> getMomentById(int newsFeedId) {
    return _fireStore
        .collection(momentCollection)
        .doc(newsFeedId.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) => MomentVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return FirebaseStorage.instance
        .ref(fileUploadRef)
        .child("${DateTime
        .now()
        .millisecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Future<List<String>> uploadFiles(List<File> images) async {
    print("upload Files input images :: ${images.length}");
    // List<String> imageUrls = [];
    var imageUrls =
    await Future.wait(images.map((image) => uploadFileToFirebase(image)));
    // uploadFileToFirebase(imageUrls[0])

    // print("upload files :: ${imageUrls.length}");
    return imageUrls;
  }

  @override
  Future<void> addMutualContacts(String userId, String exposedUserId) async {
    UserVO? currentUser;
    UserVO? exposedUser;
    getUserById(userId).first.then((user) {
      currentUser = user;
      getUserById(exposedUserId).first.then((user) {
        exposedUser = user;
        print("Current user :: ${currentUser?.toJson()}");
        print("Exposed user :: ${exposedUser?.toJson()}");
        // currentUser?.contact = [exposedUser!];
        // exposedUser?.contact = [currentUser!];
        print("Current user after :: ${currentUser?.toJson()}");
        print("Exposed user after:: ${exposedUser?.toJson()}");
        _fireStore.collection(usersCollection).doc(currentUser?.id).collection("contacts").doc(exposedUser?.id).set(exposedUser!.toJson());
        _fireStore.collection(usersCollection).doc(exposedUser?.id).collection("contacts").doc(currentUser?.id).set(currentUser!.toJson());
        // _addNewUser(currentUser!);
        // _addNewUser(exposedUser!);
      });
    });
  }

  @override
  Stream<List<MessageVO>> getCurrentUserMessages(String currentUserId,String peerId) {
    // TODO: implement getCurrentUserMessages
    throw UnimplementedError();
  }

  @override
  Future<void> sendNewPeerMessage(MessageVO message,String currentUserId,String peerId) {
    // TODO: implement sendNewPeerMessage
    throw UnimplementedError();
  }

  @override
  Future<void> receiveNewPeerMessage(MessageVO message, String currentUserId, String peerId) {
    // TODO: implement receiveNewPeerMessage
    throw UnimplementedError();
  }

  @override
  Future<void> addNewGroup(GroupVO newGroup) {
    // TODO: implement addNewGroup
    throw UnimplementedError();
  }

  @override
  Stream<List<GroupVO>> getGroups() {
    // TODO: implement getGroups
    throw UnimplementedError();
  }

  @override
  Future<void> sendNewGroupMessage(MessageVO message, String groupId) {
    // TODO: implement sendNewGroupMessage
    throw UnimplementedError();
  }

  @override
  Stream<List<MessageVO>> getGroupMessage(String groupId) {
    // TODO: implement getGroupMessage
    throw UnimplementedError();
  }
}
