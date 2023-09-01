import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import 'Re_use_able_classes.dart/Color.dart';

import 'Re_use_able_classes.dart/BackGroundImage.dart';
import 'Re_use_able_classes.dart/IconBack.dart';

class Signup extends StatefulWidget {
 const Signup({super.key});
  static const pageName = "/Signup";

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  
  TextEditingController phoneController = TextEditingController();
  final _db = FirebaseFirestore.instance.collection('users');

  bool checkboxvalue = false;

  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
         const BackgroundImage(),
         
          Form(
            key: formstate,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(width: width * 0.3, child: SizedBox
                      
                      (
                        height: height*0.16,
                        child: const IconBack()))),
                  Register(height, width),
                  SizedBox(
                    height: height * 0.04,
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
                  TextField(height * 0.1, width * 0.8, 'Password', 'Password',
                      true, passwordController, 'Password cannot be empty'),
                  TextField1(
                    height * 0.1,
                    width * 0.8,
                    'Username',
                    'Username',
                    false,
                    usernameController,
                    'Username cannot be empty',
                  ),
               
                  TextField2(
                    height * 0.1,
                    width * 0.8,
                    'Phone',
                    'Phone',
                    phoneController,
                    'Number cannot be empty',
                  ),
                  CreateButton(height, width, () async {
                    if (formstate.currentState!.validate()) {
                      _auth
                          .createUserWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString(),
                          )
                          .then((value) {
                            Utils().toastMessage('Account Created SuccessFully');
                           

                          })
                          .onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                      });
                      await _db.doc(emailController.text).set({
                        'email':emailController.text,
                        'Username': usernameController.text,
                        'password': passwordController.text,
                        'PhoneNumber': phoneController.text,
                      });
                 
                    }
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget TextField(
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
          obscureText: _obsecureText,
       
          style: TextStyle(color: TextColor.withOpacity(0.9)),
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: FocusedColor)),
            suffixIcon: IconButton(
              icon: _obsecureText
                  ? const Icon(Icons.visibility)
                  : const Icon(
                      Icons.visibility_off,
                    ),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _obsecureText = !_obsecureText;
                });
              },
            ),
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
              borderSide: const BorderSide(width: 2, color: borderSidecolor),
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
              borderSide: BorderSide(color: FocusedColor)),
          labelText: Text,
          hintText: HintText,
          hintStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelStyle: TextStyle(
              color: TextColor.withOpacity(0.9), fontWeight: FontWeight.w500),
          filled: true,
          fillColor: FillColor.withOpacity(0.1),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2, color: borderSidecolor),
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

Widget TextField2(double height, double width, String Text, String HintText,
    TextEditingController controller, String ValidationText) {
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(
        controller: controller,
        cursorColor: CursorColor,
        style: TextStyle(color: TextColor.withOpacity(0.9)),
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: FocusedColor)),
          labelText: Text,
          hintText: HintText,
          hintStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelStyle: TextStyle(
              color: TextColor.withOpacity(0.9), fontWeight: FontWeight.w500),
          filled: true,
          fillColor: FillColor.withOpacity(0.1),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2, color: borderSidecolor),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ValidationText;
          }
          return null;
        },
        keyboardType: TextInputType.phone),
  );
}

Widget CreateButton(double height, double width, Function onTap) {
  return SizedBox(
      height: height * 0.08,
      width: width * 0.8,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: yellow,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.5, color: Colors.white),
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () {
            onTap();
          },
          child: const Text(
            'Create',
            style: TextStyle(
                color: TextColor, fontWeight: FontWeight.w800, fontSize: 16),
          )));
}

Widget Register(
  double height,
  double width,
) {
  return SizedBox(
      height: height * 0.06,
      width: width * 0.4,
      child: const Center(
        child: Text(
          'Register',
          style: TextStyle(
              fontSize: 30, color: yellow, fontWeight: FontWeight.w800),
        ),
      ));
}


