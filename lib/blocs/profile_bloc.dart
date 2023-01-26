import 'package:flutter/material.dart';
import 'package:untitled/data/model/authentication_model.dart';
import 'package:untitled/data/model/authentication_model_impl.dart';

import '../data/model/add_contact_model.dart';
import '../data/model/add_contact_model_impl.dart';
import '../data/vo/user_vo.dart';

class ProfileBloc extends ChangeNotifier {
  ///States
  String newName = "";
  String newPhone = "";
  String newDateOfBirth = "";
  String newGender = "";
  bool isLoading = false;
  bool isDisposed = false;
  UserVO? currentUser;

  final AuthenticationModel _authModel = AuthenticationModelImpl();
  final AddContactModel _addContactModel = AddContactModelImpl();


  ProfileBloc(){
    currentUser = _authModel.getLoggedInUser();
    print(currentUser?.toJson());
    _addContactModel.getUserById(currentUser?.id ?? "").listen((value){
      currentUser?.profileImage = value.profileImage;
      currentUser?.password = value.password;
      currentUser?.contact = value.contact;
      currentUser?.gender = value.gender;
      currentUser?.dateOfBirth = value.dateOfBirth;
      if(!isDisposed){
        notifyListeners();
      }
    });
  }

  void onNameChanged(String newName) {
    this.newName = newName;
  }

  void onPhoneChanged(String newPhone) {
    this.newPhone = newPhone;
  }

  void onDateOfBirthChanged(String newDateOfBirth) {
    this.newDateOfBirth = newDateOfBirth;
  }

  void onGenderChanged(String newGender) {
    this.newGender = newGender;
  }

  void _showLoading(){
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading(){
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
