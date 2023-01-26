import 'package:untitled/network/cloud_firestore_data_agent_impl.dart';
import 'package:untitled/network/real_time_database_data_agent_impl.dart';
import 'package:untitled/network/wechat_data_agent.dart';

import '../vo/user_vo.dart';
import 'authentication_model.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  static final AuthenticationModelImpl _singleton =
  AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl() {
    return _singleton;
  }

  AuthenticationModelImpl._internal();

  WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();


  @override
  Future<void> login(String email, String password) {
    return mDataAgent.login(email, password);
  }

  @override
  Future<void> register(String email, String userName, String password,String gender,String dateOfBirth,List<UserVO> contacts) {
    return craftUserVO(email, password, userName,gender,dateOfBirth,contacts)
        .then((user) => mDataAgent.registerNewUser(user));
  }

  Future<UserVO> craftUserVO(String email, String password, String userName,String gender,String dateOfBirth,List<UserVO> contacts) {
    var newUser = UserVO(
      id: "",
      userName: userName,
      email: email,
      password: password,
      gender: gender,
      dateOfBirth: dateOfBirth,
      profileImage: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
      contact: contacts
    );
    return Future.value(newUser);
  }

  @override
  UserVO getLoggedInUser() {

    return mDataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return mDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
    return mDataAgent.logOut();
  }
}