import 'dart:async';

import 'package:divine/Screens.dart/Re_use_able_classes.dart/BottomNavigationBar.dart';
import 'package:divine/Screens.dart/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class splashServices {
  //this function is to check if a user is logged in and navigate to different screens accordingly.
  void isLogin(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      Timer(
          const Duration(seconds: 2),
          () =>Navigator.pushNamedAndRemoveUntil(context, bottomNavigation.pageName, (route) => false)
             );
    } else {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(context, SignIn.pageName, (route) => false));
    }
 
  }
}
