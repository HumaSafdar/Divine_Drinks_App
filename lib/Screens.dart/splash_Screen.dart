
import 'package:divine/Screens.dart/splash_screen_services.dart';
import 'package:flutter/material.dart';



import 'Re_use_able_classes.dart/BackGroundImage.dart';

class splashScreen extends StatefulWidget {
 const  splashScreen({super.key});
  static const pageName="/splashScreen";

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  splashServices Splashscreen = splashServices();
  @override
  void initState() {
    
    Splashscreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Center(
            child: Image.asset(
              'assets/images/splashimage.png',
            ),
          )
        ],
      ),
    );
  }
}
