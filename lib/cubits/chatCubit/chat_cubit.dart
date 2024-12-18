import 'package:chat_app1/constants.dart';
import 'package:chat_app1/cubits/chatCubit/chat_states.dart';
import 'package:chat_app1/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  void sendMessage({required String message, required String email}) {
    messages.add({
      'message': message,
      'createdAt': DateTime.now(),
      'id': email,
    });
  }

  void getMessages() {
    messages.orderBy('createdAt', descending: true).snapshots().listen(
      (event) {
        List<Message> messagesList = event.docs.map((doc) {
          return Message.fromjson(doc.data() as Map<String, dynamic>);
        }).toList();
        emit(ChatSuccess(messagesList: messagesList));
      },
    );
  }
}
