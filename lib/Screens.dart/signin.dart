import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/BottomNavigationBar.dart';

import 'package:divine/Screens.dart/phoneAuthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Re_use_able_classes.dart/Color.dart';
import 'ForgetPassword.dart';

import 'Re_use_able_classes.dart/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static const pageName = "/SignIn";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool checkboxvalue = false;
  bool _obsecureText = true;
 Future<void> loaduserdata()async{
  SharedPreferences preferences= await SharedPreferences.getInstance();
  setState(() {
    emailController.text=preferences.getString('savedEmail') ?? '';
    passwordController.text=preferences.getString('savedPassword') ?? '';
  });


 }
 Future<void> saveduserdata()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if(checkboxvalue){
    preferences.setString('savedEmail', emailController.text);
    preferences.setString('savedPassword', passwordController.text);
  }else{
    preferences.remove('savedEmail');

    preferences.remove('savedPassword');
  }
 } 
 @override
  void initState() {
    loaduserdata();
    super.initState();
  }
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
          Center(
            child: Form(
              key: formstate,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    SizedBox(
                      height: height * 0.1,
                      width: width * 0.7,
                      child: FittedBox(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Divine',
                                speed: const Duration(milliseconds: 500),
                                textStyle: const TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w800,
                                  color: yellow,
                                ))
                          ],
                          repeatForever: true,
                          displayFullTextOnTap: true,
                          totalRepeatCount: 3,
                          pause: const Duration(milliseconds: 100),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
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
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextField(height * 0.1, width * 0.8, 'Password', 'Password',
                        true, passwordController, 'Password cannot be empty'),
                    SizedBox(
                      height: height * 0.016,
                    ),
                    LoginButton(height, width, () {
                      if (formstate.currentState!.validate()) {
                        _auth
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          Utils().toastMessage('User Login Successfully');
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return bottomNavigation();
                            },
                          ));
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                        });
                      
                      }
                    }),
                    SizedBox(
                      height: height * 0.016,
                    ),
                    ForgetPassword(height, width, context),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CheckBox(height, width, context),
                        RememberMe(height, width, context),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 2,
                          color: Colors.white,
                          indent: width * 0.170,
                          endIndent: width * 0.03,
                        )),
                        const Text("OR",
                            style: TextStyle(
                                color: TextColor, fontWeight: FontWeight.w800)),
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            color: Colors.white,
                            endIndent: width * 0.170,
                            indent: width * 0.03,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                      width: width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GoogleAuthentication(height, width, context),
                          EmailAuthentication(height, width, context),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dontHaveanAccount(height, width),
                        CreateNow(height, width, context),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                   
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget CheckBox(double height, double width, BuildContext context) {
    return SizedBox(
      height: height * 0.02,
      width: width * 0.02,
      child: Checkbox(
          value: checkboxvalue,
          activeColor: yellow,
          side: const BorderSide(color: yellow, width: 2),
          onChanged: (bool? newValue) {
            setState(() {
              checkboxvalue = newValue!;
            });
            saveduserdata();
          }), //Checkbox,
    );
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
          cursorColor: Colors.white,
          obscureText: _obsecureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
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
            labelStyle: const TextStyle(
              color: TextColor,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: FillColor.withOpacity(0.1),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 2, color: Colors.white),
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

Widget LoginButton(double height, double width, Function onTap) {
  return SizedBox(
      height: height * 0.07,
      width: width * 0.8,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: yellow,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.5, color: Colors.white),
                  borderRadius: BorderRadius.circular(15))),
          onPressed: () {
            onTap();
          },
          child: const Text(
            'LOG IN',
            style: TextStyle(
                color: TextColor, fontWeight: FontWeight.w800, fontSize: 16),
          )));
}

Widget ForgetPassword(double height, double width, BuildContext context) {
  return SizedBox(
    height: height * 0.03,
    width: width * 0.5,
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return forgetPassword();
          },
        ));
      },
      child: const Center(
          child: Text(
        'Forget  Password?',
        style: TextStyle(fontWeight: FontWeight.w800, color: TextColor),
      )),
    ),
  );
}

Widget RememberMe(double height, double width, BuildContext context) {
  return SizedBox(
    height: height * 0.03,
    width: width * 0.36,
    child: GestureDetector(
      child: const Center(
          child: Text(
        'Remember me',
        style: TextStyle(fontWeight: FontWeight.w800, color: TextColor),
      )),
    ),
  );
}

Widget Welcome(
  double height,
  double width,
) {
  return SizedBox(
    height: height * 0.06,
    width: width * 0.5,
    child: const Center(
      child: Text('Welcome!',
          style: TextStyle(
              fontSize: 35, color: yellow, fontWeight: FontWeight.w800)),
    ),
  );
}

Widget dontHaveanAccount(double height, double width) {
  return SizedBox(
    height: height * 0.02,
    width: width * 0.42,
    child: const Text(
      "Don't have an account?",
      style: TextStyle(fontWeight: FontWeight.w800, color: TextColor),
    ),
  );
}

Widget CreateNow(double height, double width, BuildContext context) {
  return SizedBox(
    height: height * 0.02,
    width: width * 0.25,
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Signup.pageName);
      },
      child: const Text(
        'CreateNow',
        style: TextStyle(
            color: yellow,
            fontWeight: FontWeight.w900,
            fontSize: 15,
            decoration: TextDecoration.underline,
            decorationColor: Colors.yellow),
      ),
    ),
  );
}

Widget DivineImage(double height, double width) {
  return SizedBox(
    height: height * 0.27,
    width: width * 0.6,
    child: Image.asset(
      'assets/images/SigninImage.gif',
      fit: BoxFit.fill,
      scale: 5,
      // color: Divinecolor,
    ),
  );
}

Widget GoogleAuthentication(double height, double width, BuildContext context) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> storeUserGoogleData(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user != null) {
      final users = FirebaseFirestore.instance.collection('GoogleUser');
      await users.doc(user.email).set({
        'email': user.email,
        'name': user.displayName,
        'image': user.photoURL,
        'PhoneNumber':user.phoneNumber.toString()
      });
    }
  }

  return SizedBox(
    height: height * 0.04,
    width: width * 0.1,
    child: InkWell(
      onTap: () async {
        try {
          final GoogleSignInAccount? googleSignInAccount =
              await GoogleSignIn().signIn();
          if (googleSignInAccount != null) {
            GoogleSignInAuthentication googleSignInAuthentication =
                await googleSignInAccount.authentication;
            final AuthCredential authCredential = GoogleAuthProvider.credential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken);
            final UserCredential userCredential =
                await _auth.signInWithCredential(authCredential);
            await storeUserGoogleData(userCredential);
          }
        } on FirebaseAuthException catch (e) {
          print(e.message);
          throw e;
        }
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return bottomNavigation();
          },
        ));
      },
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/google1.jpg'),
        radius: 10,
      ),
    ),
  );
}

Widget EmailAuthentication(double height, double width, BuildContext context) {
  return SizedBox(
    height: height * 0.04,
    width: width * 0.1,
    child: InkWell(
      onTap: () {
        var loading = true;
      },
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, PhoneAuthentication.pageName);
        },
        child: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/phone.jpeg'),
          radius: 10,
        ),
      ),
    ),
  );
}
}