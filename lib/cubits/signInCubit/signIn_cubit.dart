import 'package:chat_app1/cubits/signInCubit/signIn_states.dart';
import 'package:chat_app1/helper/snakebarfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit(super.InitailState);

  Future<void> SignFunction({required email, required password}) async {
    emit(LoadingSignIn());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SuccessSignIn());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(FailSignIn(msg: 'No user found for that email'));
      } else if (e.code == 'wrong-password') {
        emit(FailSignIn(msg: 'wrong password'));
      } else {
        emit(FailSignIn(msg: 'somthing went wrong'));
      }
    }
  }
}
