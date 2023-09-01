import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Re_use_able_classes.dart/BackGroundImage.dart';
import 'Re_use_able_classes.dart/IconBack.dart';

class ContactUsDetails extends StatefulWidget {
  const ContactUsDetails({super.key});
  static const pageName = "/ContactUsDetails";

  @override
  State<ContactUsDetails> createState() => _ContactUsDetailsState();
}

GlobalKey<FormState> formstate = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController mobileController = TextEditingController();
TextEditingController subjectController = TextEditingController();
TextEditingController messageController = TextEditingController();
final _db = FirebaseFirestore.instance.collection('ContactUs');
final FirebaseAuth _auth = FirebaseAuth.instance;
_launchUrl(String url) async {
  Uri _url = Uri.parse(url);
  if (await canLaunchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Cannot Launch $_url';
  }
}

class _ContactUsDetailsState extends State<ContactUsDetails> {
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
            height: height*0.9,
            child: SingleChildScrollView(
              child: Center(
                  child: Form(
                key: formstate,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(width: width * 0.3, child: IconBack())),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text1(context, 'Contact Us', height * 0.03, width * 0.3),
                    Icon1(context, height * 0.1, width * 0.3),
                    Text1(context, 'Head Office', height * 0.05, width * 0.3),
                    Text2(context, 'Address: Garden Town,Yazman road',
                        height * 0.03, width * 0.7),
                    Text2(context, 'Email:humas6971@gmail.com', height * 0.03,
                        width * 0.6),
                    Icon2(context, height * 0.1, width * 0.3),
                    Text1(context, 'Customer Services Department', height * 0.05,
                        width * 0.8),
                    Text2(context, 'Contact:03027820436', height * 0.03,
                        width * 0.45),
                    Text2(context, 'Email:humas6971@gmail.com', height * 0.06,
                        width * 0.6),
                    Text1(
                        context, 'SEND US A MESSAGE', height * 0.05, width * 0.6),
                    TextField1(
                      height * 0.1,
                      width * 0.8,
                      'Email',
                      'Email',
                      false,
                      emailController,
                      'Email cannot be empty',
                    ),
                    TextField1(
                      height * 0.1,
                      width * 0.8,
                      'Name',
                      'Name',
                      false,
                      nameController,
                      'Name cannot be empty',
                    ),
                    TextField1(
                      height * 0.1,
                      width * 0.8,
                      'Mobile',
                      'Mobile',
                      true,
                      mobileController,
                      'Mobile cannot be empty',
                    ),
                    TextField1(
                      height * 0.1,
                      width * 0.8,
                      'Subject',
                      'Subject',
                      false,
                      subjectController,
                      'Subject cannot be empty',
                    ),
                    TextField1(
                      height * 0.1,
                      width * 0.8,
                      'Message',
                      'Message',
                      false,
                      messageController,
                      'Message cannot be empty',
                    ),
                    CreateButton(height, width, () async {
                      if (formstate.currentState!.validate()) {
                        showToast(context, height, width);
                      }
                      await _db.add({
                        'email': emailController.text,
                        'name': nameController.text,
                        'mobile': mobileController.text,
                        'subject': subjectController.text,
                        'Message': messageController.text,
                      });
                    }),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Text3(context, 'Follow Us On', height * 0.03, width * 0.25),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Instagram(height, width),
                          Facebook(height, width),
                          
                          Twitter(height, width),
                          Linkdin(height, width),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              ),
              
            ),
          ),
        ],
      ),
    ));
  }

  Widget Text1(
      BuildContext context, String Value, double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: Text(
        Value,
        style: const TextStyle(
            color: yellow, fontWeight: FontWeight.w700, fontSize: 20),
      ),
    );
  }
}

Widget Icon1(BuildContext context, double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: const Icon(
      Icons.location_on_outlined,
      size: 60,
      color: Colors.white,
    ),
  );
}

Widget Text2(BuildContext context, String Value, double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: Text(
      Value,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
    ),
  );
}

Widget Icon2(BuildContext context, double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: const Icon(
      Icons.headphones,
      size: 60,
      color: Colors.white,
    ),
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

Widget CreateButton(double height, double width, Function onTap) {
  return SizedBox(
      height: height * 0.07,
      width: width * 0.3,
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
            'Send',
            style: TextStyle(
                color: TextColor, fontWeight: FontWeight.w800, fontSize: 16),
          )));
}

void showToast(BuildContext context, double height, double width) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
      content: Container(
    color: yellow,
    child: Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'Message Sent SuccessFully',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    ),
  )));
}

Widget Instagram(double height, double width) {
  return SizedBox(
    height: height * 0.04,
    width: width * 0.12,
    child: InkWell(
      onTap: () {
        _launchUrl(
            'https://instagram.com/matto_hun_yar?utm_source=qr&igshid=MzNlNGNkZWQ4Mg%3D%3D');
      },
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/instagram.jpg'),
        radius: 10,
      ),
    ),
  );
}

Widget Facebook(double height, double width) {
  return SizedBox(
    height: height * 0.04,
    width: width * 0.12,
    child: InkWell(
      onTap: () {
        _launchUrl('https://www.facebook.com/huma.safdar.754');
      },
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/facebook.png'),
        radius: 10,
      ),
    ),
  );
}

Widget Twitter(double height, double width) {
  return SizedBox(
    height: height * 0.04,
    width: width * 0.12,
    child: InkWell(
      onTap: () {
        _launchUrl(
            'https://twitter.com/HumaSafdar436?t=LNV_dNGl5lFIynaEZXCzRQ&s=09');
      },
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/Twitter.png'),
        radius: 10,
      ),
    ),
  );
}

Widget Linkdin(double height, double width) {
  return SizedBox(
    height: height * 0.04,
    width: width * 0.11,
    child: InkWell(
      onTap: () {
        _launchUrl('https://www.linkedin.com/in/huma-safdar-34437427b/');
      },
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/Linkdin.png'),
        radius: 10,
      ),
    ),
  );
}

Widget Text3(BuildContext context, String Value, double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: Text(
      Value,
      style: const TextStyle(
          color: yellow, fontWeight: FontWeight.w800, fontSize: 15),
    ),
  );
}
