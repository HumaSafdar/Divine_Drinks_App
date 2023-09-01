import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  void toastMessage(String Message){
   Fluttertoast.showToast(
        msg: Message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: boxcolor,
        textColor: Colors.white,
        fontSize: 18,
        
    );
  }
}