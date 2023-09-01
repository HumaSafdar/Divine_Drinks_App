import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/BottomNavigationBar.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ConfirmedOrder extends StatefulWidget {
  const ConfirmedOrder({super.key});

  @override
  State<ConfirmedOrder> createState() => _ConfirmedOrderState();
}

class _ConfirmedOrderState extends State<ConfirmedOrder> {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconMenu1(),
              ),
              SizedBox(
                height: height * 0.04,
              ),
            const  Text(
                'ORDER PLACED',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Thank your for shoping at divine bahawalpur. Your Order has been palced and you will be notified with an order confirmation email with your detail shortly',
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              LoginButton(height, width, () {
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: bottomNavigation(), withNavBar: true);
              })
            ],
          )
        ],
      ),
    ));
  }

  Widget IconMenu1() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SizedBox(
      child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.check_circle,
            color: yellow,
            size: 50,
          )),
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
              'Continue Shoping',
              style: TextStyle(
                  color: TextColor, fontWeight: FontWeight.w800, fontSize: 16),
            )));
  }
}
