import 'package:chat_app1/Screens/chat_page.dart';
import 'package:chat_app1/Widgets/custom_Button.dart';
import 'package:chat_app1/Widgets/custom_textField.dart';
import 'package:chat_app1/constants.dart';
import 'package:chat_app1/helper/snakebarfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  static String id = 'SignupPage';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? email;
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
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
                          "Sign Up",
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onTab: () async {
                            if (globalKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                );

                                // Show success Snackbar after a slight delay

                                isLoading = false;
                                setState(() {});
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  showSnackbar(
                                      context, 'Success', Colors.green);
                                });
                                await Future.delayed(Duration(seconds: 1));

                                Navigator.pushNamed(context, ChatPage.id);
                              } on FirebaseAuthException catch (e) {
                                String message;
                                if (e.code == 'weak-password') {
                                  message = 'Weak password';
                                } else if (e.code == 'email-already-in-use') {
                                  message = 'Email already exists';
                                } else {
                                  message = 'Error: ${e.message}';
                                }
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  showSnackbar(context, message, Colors.red);
                                });
                              } catch (e) {
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  showSnackbar(
                                      context, e.toString(), Colors.red);
                                });
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          txt: "Sign Up",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?  ",
                                style: TextStyle(color: Colors.white)),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Sign In",
                                  style: TextStyle(color: Color(0xffC7EDE6))),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
