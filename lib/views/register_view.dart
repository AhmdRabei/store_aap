// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_test/views/home_view.dart';
import 'package:store_test/widgets/custom_botton.dart';
import 'package:store_test/widgets/custom_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email, password, fristName, lastName;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('user');
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: 'frist name',
                          validatorText: 'validatorText',
                          onChanged: (value) {
                            fristName = value;
                          },
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 16),
                      Expanded(
                        child: CustomTextField(
                          label: 'last name',
                          validatorText: 'validatorText',
                          onChanged: (value) {
                            lastName = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  CustomTextField(
                    validatorText: 'invalid email',
                    label: 'email',
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  CustomTextField(
                    obscureText: true,
                    validatorText: 'wrong password',
                    label: 'password',
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  CustomButton(
                    title: 'Register',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await registerUser();

                          await userCollection.add({
                            'frist_name': fristName,
                            'lastName': lastName,
                            'email': email,
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Success'),
                            ),
                          );
                          Navigator.pushNamed(context, HomeView.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Week password'),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('email already in use'),
                              ),
                            );
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          'already have an account ?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
