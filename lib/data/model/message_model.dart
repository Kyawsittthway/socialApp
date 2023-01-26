import 'dart:io';

import '../vo/message_vo.dart';

abstract class MessageModel{
  Stream<List<MessageVO>> getCurrentUserMessages(String currentUserId,String peerId);
  Future<void> sendNewPeerMessage(String message,String currentUserId,String peerId,String senderProfileImage,File? chosenFile,String fileType);
}