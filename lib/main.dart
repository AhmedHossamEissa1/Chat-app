import 'package:chat_app1/Screens/chat_page.dart';
import 'package:chat_app1/Screens/signUp_page.dart';
import 'package:chat_app1/Screens/signin_page.dart';
import 'package:chat_app1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SigninPage.id: (context) =>  SigninPage(),
        SignupPage.id: (context) =>  SignupPage(),
        ChatPage.id: (context) =>  ChatPage(),
      },
      initialRoute: SigninPage.id,
    );
  }
}