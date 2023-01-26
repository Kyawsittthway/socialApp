import 'package:flutter/material.dart';

import '../data/model/add_contact_model.dart';
import '../data/model/add_contact_model_impl.dart';
import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/vo/user_vo.dart';

class ChatBloc extends ChangeNotifier {
  List<UserVO> contactLists = [];
  bool isLoading = false;
  bool isDisposed = false;

  ///Models
  final AddContactModel contactModel = AddContactModelImpl();
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  ChatBloc() {
    contactModel
        .getCurrentUserContacts(
            _mAuthenticationModel.getLoggedInUser().id ?? "")
        .listen((value) {
      print(
          "Current logged in user id :: ${_mAuthenticationModel.getLoggedInUser().id}");
      contactLists = value;
      print(contactLists.toString());
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
