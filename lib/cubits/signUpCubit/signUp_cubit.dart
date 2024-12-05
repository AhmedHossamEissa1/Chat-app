import 'package:chat_app1/cubits/signInCubit/signIn_states.dart';
import 'package:chat_app1/cubits/signUpCubit/signUp_states.dart';
import 'package:chat_app1/helper/snakebarfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit(super.InitailState);

  Future<void> SignUpFunction({required email, required password}) async {
    emit(LoadingSignUp());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SuccessSignUp());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(FailSignUp(msg: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(FailSignUp(msg: 'email-already-in-use'));
      } else {
        emit(FailSignUp(msg: e.message.toString()));
      }
    }
    ;
  }
}
