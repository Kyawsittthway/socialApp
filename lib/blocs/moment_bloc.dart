import 'package:flutter/material.dart';
import 'package:untitled/data/model/moments_model_impl.dart';

import '../data/model/authentication_model.dart';
import '../data/model/authentication_model_impl.dart';
import '../data/model/moments_model.dart';
import '../data/vo/moment_vo.dart';

class MomentBloc extends ChangeNotifier {
  List<MomentVO> moments = [];

  ///Models
  final MomentModel _momentModel = MomentsModelImpl();
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  bool isDisposed = false;

  MomentBloc(){
    _momentModel.getMoments().listen((fetchedMoments) {
      moments = fetchedMoments;
      if(!isDisposed){
        notifyListeners();
      }
    });
  }

  void onTapDeletePost(int momentId) async {
    await _momentModel.deletePost(momentId);
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
