import 'package:flutter/material.dart';
import 'package:untitled/data/model/authentication_model_impl.dart';

import '../data/model/authentication_model.dart';

class RegisterBloc extends ChangeNotifier {
  bool isLoading = false;
  String email = "";
  String password = "";
  String userName = "";
  String birthDate = "";
  String gender = "";
  String day = "";
  String month = "";
  String year = "";
  bool agreeChecked = false;
  bool isDisposed = false;

  final AuthenticationModel _model = AuthenticationModelImpl();

  Future onTapRegister() {
    _showLoading();
    return _model
        .register(email, userName, password, gender, dateToString(),[])
        .whenComplete(() => _hideLoading());
  }
  void _showLoading(){
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading(){
    isLoading = false;
    _notifySafely();
  }


  void onEmailChanged(String email) {
    this.email = email;
  }

  void onUsernameChanged(String userName) {
    this.userName = userName;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  void onGenderChanged(String gender) {
    this.gender = gender.toLowerCase();
  }

  void onDayChanged(String day) {
    this.day = day;
  }

  void onMonthChanged(String month) {
    this.month = month;
  }

  void onYearChanged(String year) {
    this.year = year;
  }

  void onAgreeChanged(bool status) {
    agreeChecked = status;
    _notifySafely();
  }

  String dateToString() {
    return "${day}/${month}/${year}";
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
