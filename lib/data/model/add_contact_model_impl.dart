import 'package:untitled/data/model/add_contact_model.dart';
import 'package:untitled/data/vo/user_vo.dart';

import '../../network/cloud_firestore_data_agent_impl.dart';
import '../../network/wechat_data_agent.dart';
import 'authentication_model.dart';
import 'authentication_model_impl.dart';

class AddContactModelImpl extends AddContactModel{
  static final AddContactModelImpl _singleton = AddContactModelImpl._internal();

  factory AddContactModelImpl() {
    return _singleton;
  }

  AddContactModelImpl._internal();

  WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  ///Authentication Model
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();


  @override
  Stream<UserVO> getUserById(String userId) {
    return mDataAgent.getUserById(userId);
  }



  @override
  Future<void> addContactsMutals(String userId, String exposedUserId) {
    return mDataAgent.addMutualContacts(userId, exposedUserId);
  }
  @override
  Stream<List<UserVO>> getCurrentUserContacts(String currentUserId){
    return mDataAgent.getCurrentUserContacts(currentUserId);
  }






}