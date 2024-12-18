import 'package:chat_app1/Screens/chat_page.dart';
import 'package:chat_app1/Screens/signUp_page.dart';
import 'package:chat_app1/Widgets/custom_Button.dart';
import 'package:chat_app1/Widgets/custom_textField.dart';
import 'package:chat_app1/constants.dart';
import 'package:chat_app1/cubits/signInCubit/signIn_cubit.dart';
import 'package:chat_app1/cubits/signInCubit/signIn_states.dart';
import 'package:chat_app1/helper/snakebarfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SigninPage extends StatelessWidget {
  static String id = 'SigninPage';
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInStates>(
      listener: (context, state) async {
        if (state is LoadingSignIn) {
          isloading = true;
        } else if (state is SuccessSignIn) {
          isloading = false;
          showSnackbar(context, 'Success', Colors.green);
          await Future.delayed(await Duration(milliseconds: 200));
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
        } else if (state is FailSignIn) {
          isloading = false;
          showSnackbar(context, state.msg, Colors.red);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: SingleChildScrollView(
            // Wrap in SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 70),
                        Image.asset(kLogo),
                        const Text(
                          "Scholar Chat",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 105),
                  Form(
                    
                    key: globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: CustomTextFormfield(
                            onChanged: (value) {
                              email = value;
                            },
                            input: "Email",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: CustomTextFormfield(
                            obSecureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            input: "Password",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onTab: () async {
                              if (globalKey.currentState!.validate()) {
                                BlocProvider.of<SignInCubit>(context)
                                    .SignFunction(
                                        email: email, password: password);
                              }
                            },
                            txt: "Sign In",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Dont have account?  ",
                                    style: TextStyle(color: Colors.white)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignupPage();
                                    }));
                                  },
                                  child: const Text("Sign Up",
                                      style:
                                          TextStyle(color: Color(0xffC7EDE6))),
                                )
                              ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
