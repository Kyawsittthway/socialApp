import 'package:flutter/material.dart';
import 'package:untitled/data/model/authentication_model.dart';
import 'package:untitled/data/model/authentication_model_impl.dart';

class LoginBloc extends ChangeNotifier{
  bool isLoading = false;
  bool isDisposed = false;
  String email = "";
  String password = "";

  final AuthenticationModel _model = AuthenticationModelImpl();

  Future onTapLogin(){
    _showLoading();
    return _model.login(email, password).whenComplete(() => _hideLoading());
  }

  void onEmailChanged(String email){
    this.email = email;
  }

  void onPasswordChanged(String password){
    this.password = password;
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