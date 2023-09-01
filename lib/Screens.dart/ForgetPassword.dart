import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Utils.dart';
import 'package:divine/Screens.dart/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Re_use_able_classes.dart/Color.dart';

class forgetPassword extends StatelessWidget {
  forgetPassword({super.key});
  static const pageName = "/forgetPassword";
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
         const  BackgroundImage(),
          Form(
            key: formstate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text1(
                      context, 'Forgot your Password', height * 0.08, width),
                ),
                TextField1(
                  height * 0.1,
                  width * 0.8,
                  'Email',
                  'Email',
                  false,
                  emailController,
                  'Email cannot be empty',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ReterivePasswordButton(height, width, context, () async {
                  if (formstate.currentState!.validate()) {}
                }),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget TextField1(
      double height,
      double width,
      String Text,
      String HintText,
      bool isPasswordtype,
      TextEditingController controller,
      String ValidationText) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
          controller: controller,
          cursorColor: CursorColor,
          obscureText: isPasswordtype,
          enableSuggestions: !isPasswordtype,
          autocorrect: !isPasswordtype,
          style: TextStyle(color: TextColor.withOpacity(0.9)),
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),

            labelText: Text,

            hintText: HintText,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white),
            labelStyle: TextStyle(
                color: TextColor.withOpacity(0.9), fontWeight: FontWeight.w500),
            filled: true,
           
            fillColor: FillColor.withOpacity(0.1),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 4, color: Colors.white),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return ValidationText;
            }
            return null;
          },
          keyboardType: isPasswordtype
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress),
    );
  }

  Widget ReterivePasswordButton(
      double height, double width, BuildContext context, Function onTap) {
    return SizedBox(
        height: height * 0.07,
        width: width * 0.6,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: yellow,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.5, color: Colors.white),
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: yellow,
                    title: const Center(
                        child: Text(
                      'Info',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.white),
                    )),
                    content: const Text(
                      'Password reset request sent,you will receive a password recovery link in a few seconds.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    actions: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: lightColor.withOpacity(0.8)),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const SignIn();
                                },
                              ));
                            },
                            child: InkWell(
                              onTap: () {
                                auth
                                    .sendPasswordResetEmail(
                                        email: emailController.text.toString())
                                    .then((value) {
                                  Utils().toastMessage(
                                      'We have send to email to recover the password! Please check your Gmail');
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                });
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
            child: const Text(
              'Retrieve Password',
              style: TextStyle(
                  color: TextColor, fontWeight: FontWeight.w500, fontSize: 17),
            )));
  }

  Widget Text1(
      BuildContext context, String Value, double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: Text(
        Value,
        style:
            const TextStyle(color: yellow, fontWeight: FontWeight.w700, fontSize: 24),
      ),
    );
  }
}
