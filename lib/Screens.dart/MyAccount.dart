import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:divine/Screens.dart/DrawerScreen.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Utils.dart';

import 'package:divine/Screens.dart/signin.dart';
import 'package:divine/updateScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'ContactUs.dart';
import 'Re_use_able_classes.dart/Color.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});
  static const pageName = "/MyAccount";

  @override
  State<MyAccount> createState() => _MyAccountState();
}

Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
  return await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .get();
}

class _MyAccountState extends State<MyAccount> {
  Future<void> deleteUser()async{
    try{
      //Delte User data from Firestore
      String userEmail=FirebaseAuth.instance.currentUser!.email!;
      await FirebaseFirestore.instance.collection('users').doc(userEmail).delete();
      //Delete User data from Firebase Authentication
      User user=FirebaseAuth.instance.currentUser!;
      await user.delete();
      Utils().toastMessage('User Deleted SuccessFully');
    }catch(e){
      Utils().toastMessage(e.toString());
    }

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
          SizedBox(
            height: height * 0.55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: IconMenu1(),
                      ),
                      IconMenu(),
                    ],
                  ),
                ),
const SizedBox(
                  
                ),
                ContactUs2(height, width, "Email"),
                ContactUs3(height, width, "Username"),
                ContactUs4(height, width, "Password"),
                ContactUs5(height, width, "PhoneNumber"),
                ContactUs(height, width, 'Proceed if you want to delete')
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget IconMenu() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return const SizedBox(
       
        child: Text(
          'My Account',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
        ));
  }

  Widget IconMenu1() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SizedBox(
    
      child: IconButton(
          onPressed: () {
            PersistentNavBarNavigator.pushNewScreen(context,
                screen: const DrawerScreen(), withNavBar: true);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          )),
    );
  }

  Widget ContactUs2(
    double height,
    double width,
    String value1,
  ) {
    return SizedBox(
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ContactUsDetails.pageName);
          },
          child: Center(
            child: Container(
              height: height * 0.08,
              width: width * 0.85,
              decoration: BoxDecoration(color: lightColor.withOpacity(0.6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          SizedBox(
                              width: width * 0.4,
                              child: Text(value1,
                                  style: const TextStyle(
                                    color: yellow,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ))),
                          FutureBuilder(
                            future: getData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data!.data();
                                  return Text(
                                    data!['email'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.white),
                                  );
                                } else {
                                  return const Text('no data');
                                }
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(color: boxcolor,));
                              } else {
                                return const Text('Something went wrong');
                              }
                            },
                          )
                        ])),
                  ),
                  IconButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: const UpdateScreen(), withNavBar: false);
                      },
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: yellow,
                        size: 33,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ContactUs3(
    double height,
    double width,
    String value1,
  ) {
    return SizedBox(
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ContactUsDetails.pageName);
          },
          child: Center(
            child: Container(
              height: height * 0.08,
              width: width * 0.85,
              decoration: BoxDecoration(color: lightColor.withOpacity(0.6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          SizedBox(
                              width: width * 0.4,
                              child: Text(value1,
                                  style: const TextStyle(
                                    color: yellow,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ))),
                          FutureBuilder(
                            future: getData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data!.data();

                                  return Text(
                                    data!['Username'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.white),
                                  );
                                } else {
                                  return const Text('no data');
                                }
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(color: boxcolor,));
                              } else {
                                return const Text('Something went wrong');
                              }
                            },
                          )
                        ])),
                  ),
                  IconButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: const UpdateScreen(), withNavBar: false);
                      },
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: yellow,
                        size: 33,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ContactUs4(
    double height,
    double width,
    String value1,
  ) {
    return SizedBox(
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ContactUsDetails.pageName);
          },
          child: Center(
            child: Container(
              height: height * 0.08,
              width: width * 0.85,
              decoration: BoxDecoration(color: lightColor.withOpacity(0.6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          SizedBox(
                              width: width * 0.4,
                              child: Text(value1,
                                  style: const TextStyle(
                                    color: yellow,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ))),
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            future: getData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data!.data();

                                  return Text(
                                    data!['password'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.white),
                                  );
                                } else {
                                  return const Text('no data');
                                }
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(color: boxcolor,));
                              } else {
                                return const Text('Something went wrong');
                              }
                            },
                          )
                        ])),
                  ),
                  IconButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: const UpdateScreen(), withNavBar: false);
                      },
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: yellow,
                        size: 33,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ContactUs5(
    double height,
    double width,
    String value1,
  ) {
    return SizedBox(
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ContactUsDetails.pageName);
          },
          child: Center(
            child: Container(
              height: height * 0.08,
              width: width * 0.85,
              decoration: BoxDecoration(color: lightColor.withOpacity(0.6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          SizedBox(
                              width: width * 0.4,
                              child: Text(value1,
                                  style: const TextStyle(
                                    color: yellow,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ))),
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            future: getData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data!.data();
                                  //log('${data!['email']}');
                                  return Text(
                                    data!['PhoneNumber'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.white),
                                  );
                                } else {
                                  return const Text('no data');
                                }
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(color: boxcolor,));
                              } else {
                                return const Text('Something went wrong');
                              }
                            },
                          )
                        ])),
                  ),
                  IconButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: const UpdateScreen(), withNavBar: false);
                      },
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: yellow,
                        size: 33,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ContactUs(
    double height,
    double width,
    String value1,
  ) {
    return SizedBox(
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ContactUsDetails.pageName);
          },
          child: Center(
            child: Container(
              height: height * 0.07,
              width: width * 0.85,
              decoration: BoxDecoration(color: lightColor.withOpacity(0.6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Center(
                      child: SizedBox(
                        width: width * 0.6,
                        child: Text(
                          value1,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                       showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: yellow,
                      title: const Center(
                          child: Text(
                        'Delete',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, color: boxcolor),
                      )),
                      content: const Text(
                        'Are you sure you want to delete then press Ok',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
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
                                 deleteUser();
                                Navigator.of(context).pushNamedAndRemoveUntil(SignIn.pageName, 
                                
                                (route) => false);
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: yellow,
                        size: 30,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
