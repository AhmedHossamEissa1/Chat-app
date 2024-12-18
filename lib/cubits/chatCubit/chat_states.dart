import 'package:chat_app1/models/message.dart';

abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class ChatSuccess extends ChatStates {
  List<Message> messagesList = [];
  ChatSuccess({required this.messagesList});
}
