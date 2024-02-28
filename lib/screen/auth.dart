// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../widgets/user_image.dart';

final fireBase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var isSelectLogOrsing = true;
  var email = '';
  var username = '';
  var password = '';
  File? selectedimage;
  var isLoading = false;

  void submit() async {
    final valid = formkey.currentState!.validate();

    if (!valid) {
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      if (isSelectLogOrsing) {
        final UserCredential userCarden =
            await fireBase.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        final UserCredential userCarden =
            await fireBase.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final Reference storagefre = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${userCarden.user!.uid}.jpg');

        await storagefre.putFile(selectedimage!);

        final imageUrl = await storagefre.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('user')
            .doc(userCarden.user!.uid)
            .set({
          'username': username,
          'email': email,
          'imageUrl': imageUrl,
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication falied'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }

    formkey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(115, 94, 92, 92),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                  right: 20,
                  left: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        if (!isSelectLogOrsing)
                          ImagePic(
                            onPicImage: (File picImageFile) {
                              selectedimage = picImageFile;
                            },
                          ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email addres',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          onSaved: (value) => email = value!,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                        ),
                        if (!isSelectLogOrsing)
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            onSaved: (value) => username = value!,
                            validator: (value) {
                              if (value == null || value.trim().length < 4) {
                                return 'Please enter at least 4 charachters.';
                              }
                              return null;
                            },
                          ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          onSaved: (value) => password = value!,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be at least 6 charachters long.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        if (isLoading) const CircularProgressIndicator(),
                        if (!isLoading)
                          ElevatedButton(
                            onPressed: submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(
                              isSelectLogOrsing ? "Login" : "Signup",
                            ),
                          ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isSelectLogOrsing = !isSelectLogOrsing;
                            });
                          },
                          child: Text(
                            isSelectLogOrsing
                                ? "Creat an account"
                                : "I already have an account",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
