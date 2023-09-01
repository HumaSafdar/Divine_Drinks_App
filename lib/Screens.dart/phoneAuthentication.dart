import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';

import 'package:divine/Verification.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Re_use_able_classes.dart/Color.dart';
import 'Re_use_able_classes.dart/Utils.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});
  static const pageName = "/PhoneAuthentication";

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
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
          const BackgroundImage(),
          Form(
            key: formstate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child:
                      Text1(context, 'Enter Your Number', height * 0.08, width),
                ),
                TextField1(
                  height * 0.1,
                  width * 0.8,
                  'Phone',
                  '+923007720657',
                  false,
                  phoneController,
                  'Phone cannot be empty',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ReterivePasswordButton(height, width, context, () async {
                  if (formstate.currentState!.validate()) {}
                }),
              ],
            ),
          ),
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
          onPressed: () {
            
            auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) {},
              verificationFailed: (error) {
                Utils().toastMessage(error.toString());
              },
              codeSent: (verificationId, forceResendingToken) {
                Navigator.of(context).pushNamed(VerifyCode.pageName);
              },
              codeAutoRetrievalTimeout: (verificationId) {
                Utils().toastMessage(verificationId.toString());
              },
            );
          },
          child: const Text('Login ',style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
    );
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
