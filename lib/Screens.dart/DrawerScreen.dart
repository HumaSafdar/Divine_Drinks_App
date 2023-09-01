import 'package:divine/BottomNavigationBarScreens.dart/ItemPage.dart';
import 'package:divine/Screens.dart/MyAccount.dart';

import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'package:divine/Screens.dart/ContactUs.dart';
import 'package:divine/Screens.dart/SignUp.dart';

import 'package:divine/Screens.dart/signin.dart';
import 'package:divine/googledata.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'Re_use_able_classes.dart/BackGroundImage.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});
  static const pageName = "/DrawerScreen";

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isGoogleLogin = FirebaseAuth.instance.currentUser!.providerData
      .any((element) => element.providerId == 'google.com');
  bool isEmailLogin = FirebaseAuth.instance.currentUser!.providerData
      .any((element) => element.providerId == 'password');
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
          SizedBox(
            height: height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.85,
                        height: height * 0.01,
                      ),
                      InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: const ItemPage(), withNavBar: true);
                          },
                          child: IconMenu()),
                    ],
                  ),
                ),
                ContactUs(height, width, 'Contact Us', () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: const ContactUsDetails(), withNavBar: true);
                }),
                ContactUs(height, width, 'My Account', () {
                  if (isGoogleLogin) {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const GoogleData(), withNavBar: true);
                  } else if (isEmailLogin) {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const MyAccount(), withNavBar: true);
                  }
                }),
                ContactUs(height, width, 'Logout', () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: yellow,
                      title: const Center(
                          child: Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, color: boxcolor),
                      )),
                      content: const Text(
                        'Are you sure you want to logout then press Ok',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      actions: <Widget>[
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: lightColor.withOpacity(0.8)),
                              onPressed: () {
                                //
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    SignIn.pageName, (route) => false);
                              },
                              child: InkWell(
                                onTap: () {
                                  FirebaseAuth.instance.signOut();
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                              )),
                        )
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget IconMenu() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SizedBox(
      child: InkWell(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(context,
                screen: const ItemPage(), withNavBar: true);
          },
          child: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          )),
    );
  }

  Widget ContactUs(
    double height,
    double width,
    String value,
    Function onTap,
  ) {
    return SizedBox(
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ContactUsDetails.pageName);
          },
          child: Center(
            child: InkWell(
              onTap: () {
                onTap();
              },
              child: Container(
                height: height * 0.08,
                width: width * 0.85,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(15),
                    color: lightColor.withOpacity(0.6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        value,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_sharp,
                          size: 30,
                          color: yellow,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<SignIn> _signOut() async {
    await FirebaseAuth.instance.signOut();

    return const SignIn();
  }
}
