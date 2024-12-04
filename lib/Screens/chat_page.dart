import 'dart:convert';
import 'dart:developer';

import 'package:chat_app1/Widgets/chat_message.dart';
import 'package:chat_app1/constants.dart';
import 'package:chat_app1/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  static String id = 'chatpage';

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList =
              snapshot.data!.docs.map((doc) => Message.fromjson(doc)).toList();

          // **Ensure the scroll happens after the new data is loaded.**
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  const Text(
                    "Chat",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? chatMessage(
                              message: messagesList[index].message,
                            )
                          : chatMessageWithFriend(
                              message: messagesList[index].message);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      messages.add({
                        'message': value,
                        'createdAt': DateTime.now(),
                        'id': email
                      });
                      controller.clear();

                      // **Scroll to the top (latest message) after sending.**
                      if (scrollController.hasClients) {
                        scrollController.animateTo(
                          0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
