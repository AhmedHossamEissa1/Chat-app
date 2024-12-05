import 'package:chat_app1/Screens/chat_page.dart';
import 'package:chat_app1/Screens/signUp_page.dart';
import 'package:chat_app1/Screens/signin_page.dart';
import 'package:chat_app1/cubits/signInCubit/signIn_cubit.dart';
import 'package:chat_app1/cubits/signInCubit/signIn_states.dart';
import 'package:chat_app1/cubits/signUpCubit/signUp_cubit.dart';
import 'package:chat_app1/cubits/signUpCubit/signUp_states.dart';
import 'package:chat_app1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInCubit(InitailSignIn()),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(InitailSignUp()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SigninPage.id: (context) => SigninPage(),
          SignupPage.id: (context) => SignupPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: SigninPage.id,
      ),
    );
  }
}
