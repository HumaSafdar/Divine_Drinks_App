import 'package:divine/Screens.dart/ContactUs.dart';
import 'package:divine/Screens.dart/DrawerScreen.dart';
import 'package:divine/Screens.dart/ForgetPassword.dart';
import 'package:divine/Screens.dart/SignUp.dart';
import 'package:divine/Screens.dart/signin.dart';
import 'package:divine/Screens.dart/splash_Screen.dart';
import 'package:divine/Verification.dart';

import 'package:flutter/material.dart';

import '../MyAccount.dart';
import '../phoneAuthentication.dart';


Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == splashScreen.pageName) {
    return MaterialPageRoute(
      builder: (context) {
        return splashScreen();
      },
    );
  } else if (settings.name == Signup.pageName) {
    return SlideLeftTransition(page: Signup(), settings: settings);
  } else if (settings.name == SignIn.pageName) {
    return MaterialPageRoute(
      builder: (context) => const SignIn(),
    );
  } else if (settings.name == forgetPassword.pageName) {
    return MaterialPageRoute(builder: (context) => forgetPassword());
  } else if (settings.name == DrawerScreen.pageName) {
    return MaterialPageRoute(
      builder: (context) => DrawerScreen(),
    );
  } 
  else if (settings.name == MyAccount.pageName) {
    return MaterialPageRoute(
      builder: (context) =>const MyAccount(),
    );
  } else if (settings.name == PhoneAuthentication.pageName) {
    return MaterialPageRoute(
      builder: (context) =>const PhoneAuthentication(),
    );
  } 
  else if (settings.name == VerifyCode.pageName) {
    return MaterialPageRoute(
      builder: (context) => const VerifyCode(VerificationId: 'VerificationId',),
    );
  } 
   else {
    return MaterialPageRoute(
      builder: (context) => const ContactUsDetails(),
    );
  }
}

class SlideLeftTransition extends PageRouteBuilder {
  final Widget page;
  SlideLeftTransition({required this.page, RouteSettings? settings})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return page;
            },
            reverseTransitionDuration: const Duration(seconds: 1),
            transitionDuration: const Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                    parent: animation, curve: Curves.easeInSine)),
                child: child,
              );
            });
}
