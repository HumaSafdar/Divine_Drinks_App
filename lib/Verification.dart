import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/BottomNavigationBar.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class VerifyCode extends StatefulWidget {
  final String VerificationId;
  const VerifyCode({required this.VerificationId, super.key});
  static const pageName = "/VerifyCode";

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  //key for validation
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  //TextField Controller
  TextEditingController verifyController = TextEditingController();
  //provides an instance of the FirebaseAuth class. 
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
                      Text1(context, 'Enter verification code', height * 0.08, width),
                ),
                TextField1(
                  height * 0.1,
                  width * 0.8,
                  'Verify',
                  'VerificationCode',
                  false,
                  verifyController,
                  'Code cannot be empty',
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
          cursorColor: yellow,
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
          onPressed: () async {
            final credential = PhoneAuthProvider.credential(
                verificationId: widget.VerificationId,
                smsCode: verifyController.text.toString());
               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                               return   bottomNavigation();
                             },));
            try {
              await auth.signInWithCredential(credential);
            } catch (e) {}
          },
          child: const Text(
            'Verify ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )),
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
