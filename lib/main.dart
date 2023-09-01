


import 'package:divine/Screens.dart/Re_use_able_classes.dart/Controller.dart';
import 'package:divine/Screens.dart/splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



void main() async {
  //initialization of firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // app only in portrait 
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //for navigation 
      initialRoute: splashScreen.pageName,
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const  splashScreen()
    );
  }
}
