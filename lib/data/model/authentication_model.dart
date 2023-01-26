import 'package:untitled/data/vo/user_vo.dart';

abstract class AuthenticationModel{
  Future<void> login(String email,String password);

  Future<void> register(String email,String userName,String password,String gender,String dateOfBirth,List<UserVO> contacts);

  bool isLoggedIn();

  UserVO getLoggedInUser();

  Future<void> logOut();
}