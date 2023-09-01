import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'Screens.dart/Re_use_able_classes.dart/Utils.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

// TextFiels Controllers
TextEditingController emailController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController phoneController = TextEditingController();
//to declare and initialize an empty Map object
Map<String, dynamic> userdata = {};
//the function's return type declaration. It indicates that the function will return a Future
// containing a DocumentSnapshot object. A DocumentSnapshot represents a document in Firestore, 
//and it contains the data and metadata associated with that document.
Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
  return await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .get();
}
// This method is used to update the user's details and then
// show the toast message that user data updated successfully
updateUserDetails() {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .update({
    'Username': usernameController.text,
    'PhoneNumber': phoneController.text.toString(),
    'email': emailController.text,
    'password': passwordController.text,
  }).then((value) => Utils().toastMessage('Data Updated SuccessFully'));
}

class _UpdateScreenState extends State<UpdateScreen> {
  //This is the function definition. It's marked as async because it contains
  // asynchronous operations and returns a Future<void>.
  Future<void> loadUserdata() async {
    //This line calls the getData() function (which likely retrieves user data from Firestore) 
    //and awaits its result.
    // The result is a DocumentSnapshot containing user data.
    DocumentSnapshot<Map<String, dynamic>> snapshot = await getData();
    if (snapshot.exists) {
      //This line extracts the data from the DocumentSnapshot into a local Map variable named data.
      Map<String, dynamic> data = snapshot.data()!;
      setState(() {
        //This line sets the text value of a UI controller named usernameController 
        //to the value stored in the Username field of the retrieved data.
        usernameController.text = data['Username'];
        phoneController.text = data['PhoneNumber'];
        passwordController.text = data['password'];
        emailController.text = data['email'];
        // This line updates the userdata variable with the data from the DocumentSnapshot
        userdata = snapshot.data()!;
      });
    }
  }
 //used to perform one-time initialization tasks when a
 // widget is first created and inserted into the widget tree. 
  @override
  void initState() {
    
    super.initState();
    loadUserdata();
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
            height: height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 26,
                  color: Colors.yellow,
                )),
          ),
          Center(
            child: SizedBox(
              height: height * 0.65,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Column(children: [
                    const Text(
                      'UPDATE PERSONAL DETAILS',
                      style: TextStyle(
                          fontSize: 18,
                          color: yellow,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Center(
                      child: SizedBox(
                        width: width * 0.9,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'You can acess and modify your personal details(name,billing address,telephone number etc) in order to facilitate your purchase and to notify us of  any change in your contact detail',
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    userNameUpdateField(
                      height * 0.08,
                      width * 0.9,
                      // is to retrieve the value associated with the key
                      // 'Username' from the userdata map and convert it to a string. 
                      userdata['Username'].toString(),
                      usernameController,
                    ),
                    SizedBox(
                      height: height * 0.08,
                      child: PhoneNumberUpdateField(height * 0.08, width * 0.9,
                          userdata['PhoneNumber'].toString(), phoneController),
                    ),
                    EmailUpdateField(height * 0.08, width * 0.9,
                        userdata['email'].toString(), emailController),
                    PassowrdUpdateField(
                      height * 0.08,
                      width * 0.9,
                      userdata['password'].toString(),
                      passwordController,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    UpdateButton(height, width, () {
                      updateUserDetails();
                    })
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget UpdateButton(double height, double width, Function onTap) {
    return SizedBox(
        height: height * 0.08,
        width: width * 0.7,
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
              'Update',
              style: TextStyle(
                  color: TextColor, fontWeight: FontWeight.w800, fontSize: 16),
            )));
  }

  Widget userNameUpdateField(
    double height,
    double width,
    String value,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const UnderlineInputBorder(),
            labelText: 'Username',
            labelStyle: const TextStyle(
              fontSize: 15,
              color: yellow,
              fontWeight: FontWeight.w900,
            ),
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900),
            hintText: value,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }

  Widget EmailUpdateField(
    double height,
    double width,
    String value,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const UnderlineInputBorder(),
            labelText: 'Email',
            labelStyle: const TextStyle(
              fontSize: 15,
              color: yellow,
              fontWeight: FontWeight.w900,
            ),
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900),
            hintText: value,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget PassowrdUpdateField(
    double height,
    double width,
    String value,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const UnderlineInputBorder(),
            labelText: 'Password',
            labelStyle: const TextStyle(
              fontSize: 15,
              color: yellow,
              fontWeight: FontWeight.w900,
            ),
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900),
            hintText: value,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }

  Widget PhoneNumberUpdateField(
    double height,
    double width,
    String value,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const UnderlineInputBorder(),
            labelText: 'PhoneNumber',
            labelStyle: const TextStyle(
              fontSize: 15,
              color: yellow,
              fontWeight: FontWeight.w900,
            ),
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900),
            hintText: value,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        keyboardType: TextInputType.phone,
      ),
    );
  }
}
