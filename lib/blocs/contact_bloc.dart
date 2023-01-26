import 'package:flutter/material.dart';
import 'package:untitled/data/model/add_contact_model.dart';
import 'package:untitled/data/model/add_contact_model_impl.dart';
import 'package:untitled/data/model/group_model.dart';
import 'package:untitled/data/model/group_model_impl.dart';
import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/vo/group_vo.dart';
import '../data/vo/message_vo.dart';
import '../data/vo/user_vo.dart';

class ContactBloc extends ChangeNotifier {
  List<UserVO> contactLists = [];
  List<GroupVO> groups = [];
  bool isLoading = false;
  bool isDisposed = false;

  ///Models
  final AddContactModel contactModel = AddContactModelImpl();
  final GroupModel groupModel = GroupModelImpl();
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();


  ContactBloc({String? exposedUserId}){

    if(exposedUserId != null){
      print("in contact bloc");
      print("Got Exposed User Id :: $exposedUserId");
      String currentUserId = _mAuthenticationModel.getLoggedInUser().id ?? "";
      contactModel.addContactsMutals(currentUserId, exposedUserId ?? "");
    }
   contactModel.getCurrentUserContacts(_mAuthenticationModel.getLoggedInUser().id ?? "").listen((value){
     print("Current logged in user id :: ${_mAuthenticationModel.getLoggedInUser().id}");
     contactLists = value;
     print(contactLists.toString());
     _notifySafely();
   });

    groupModel.getGroups().listen((fetchedGroups) {
      groups = fetchedGroups;
      groups.retainWhere((element){
        return element.userIds!.contains(_mAuthenticationModel.getLoggedInUser().id);
      });
      
      _notifySafely();
    });




  }


  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
