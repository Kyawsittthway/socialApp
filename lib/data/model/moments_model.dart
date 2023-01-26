import 'dart:io';

import 'package:untitled/data/vo/moment_vo.dart';

abstract class MomentModel{
  Stream<List<MomentVO>> getMoments();
  Stream<MomentVO> getMomentById(int momentId);
  Future<void> addNewPost(String description, List<File>? imageFiles,String profilePicture);
  Future<void> editPost(MomentVO moment, List<File>? imageFile);
  Future<void> deletePost(int momentId);
}