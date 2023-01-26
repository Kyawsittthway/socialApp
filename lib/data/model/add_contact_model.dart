import '../vo/user_vo.dart';

abstract class AddContactModel{
  Stream<UserVO> getUserById(String userId);
  Future<void> addContactsMutals(String userId,String exposedUserId);
  Stream<List<UserVO>> getCurrentUserContacts(String currentUserId);
}