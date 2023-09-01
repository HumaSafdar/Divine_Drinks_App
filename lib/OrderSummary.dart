import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'ConfirmedOrder.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key, required this.ShipingItemPrice});
  final num ShipingItemPrice;

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  //add total price and shipping price 
  num Add(num totalCartPrice, num ShipingItemPrice) {
    return totalCartPrice + ShipingItemPrice;
  }
  //decleration of data such as information retrived from firebase

  Map<String, dynamic>? data;
  //the function's return type declaration. It indicates that the function will return a Future
// containing a DocumentSnapshot object. A DocumentSnapshot represents a document in Firestore, 
//and it contains the data and metadata associated with that document.
  Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
    return await FirebaseFirestore.instance
        .collection('ConfirmedOrder')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
  }
   // This is a function definition named storeData. It takes a parameter firestoreData, 
   //which is expected to be a Map containing the data you want to store in Firestore. 
   //The function is marked as async since it contains asynchronous operations.
  void storeData(Map<String, dynamic> firestoreData) async {
    await FirebaseFirestore.instance
        .collection('PlacedOrder')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('PlaceOrder')
        .doc()
        .set(firestoreData);
  }
 //TextFieldController
  TextEditingController ordernowController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    //appears to calculate the total amount by adding a specified 
    //value to the ShippingItemPrice extracted from a widget's properties. 
    num total = Add(widget.ShipingItemPrice, 100);
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        BackgroundImage(),
        SizedBox(
          height: height * 0.02,
          width: width * 0.03,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Align(alignment: Alignment.topLeft, child: IconMenu1()),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.2,
                  width: width * 0.9,
                  decoration: const BoxDecoration(color: boxcolor),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const Text(
                          'Order Summary',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: yellow),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          width: width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.12,
                              ),
                              const Text(
                                'SubTotal',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: width * 0.30,
                              ),
                              IconMenu(),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '${widget.ShipingItemPrice}',
                                  style: const TextStyle(
                                      color: yellow,
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          width: width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.12,
                              ),
                              const Text(
                                'Shipping',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: width * 0.29,
                              ),
                              IconMenu(),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  '100',
                                  style: TextStyle(
                                      color: yellow,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 225, 194, 194),
                          endIndent: width * 0.04,
                          indent: width * 0.03,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.12,
                              ),
                              const Text(
                                'Total',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: width * 0.36,
                              ),
                              IconMenu(),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "$total",
                                  style: const TextStyle(
                                      color: yellow,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.19,
                  width: width * 0.9,
                  decoration: const BoxDecoration(color: boxcolor),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.011,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Shiping Address',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                                color: yellow),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.011,
                      ),
                      //FutureBuilder widget in Flutter to asynchronously retrieve data, 
                      //perform some operations based on that data,
                      // and then display a series of Text widgets based on the fetched data
                      FutureBuilder(
                          future: getData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.data();
                                storeData({
                                  'total': widget.ShipingItemPrice,
                                  'username': data!['username'],
                                  'address': data['Address'],
                                  'phoneNumber': data['phoneNumber'],
                                  'selectedCity': data['selectedcity'],
                                  'currentLocation': data['location'],
                                  'orderTime': FieldValue.serverTimestamp(),
                                  'orderNote': ordernowController.text,
                                });
                                return Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          data['username'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          data['Address'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          data['phoneNumber'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          data['selectedcity'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          data['location'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text('Something went wrong');
                              }
                            } else {
                              return const Text('Something went wrong');
                            }
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.15,
                  width: width * 0.9,
                  decoration: const BoxDecoration(color: boxcolor),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.011,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Payment Options',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                                color: yellow),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.011,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Cash on delivery (COD)',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.1,
                  width: width * 0.9,
                  decoration: const BoxDecoration(color: boxcolor),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: ordernowController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: UnderlineInputBorder(),
                          labelText: 'Order Note',
                          labelStyle: TextStyle(
                            fontSize: 15,
                            color: yellow,
                            fontWeight: FontWeight.w900,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                LoginButton(height, width, () {
                  //store data in firebase by clicking on the button
                  if (data != null) {
                    return storeData({
                      'total': widget.ShipingItemPrice,
                      'username': data!['username'],
                      'address': data!['Address'],
                      'phoneNumber': data!['phoneNumber'],
                      'selectedCity': data!['selectedcity'],
                      'currentLocation': data!['location'],
                      'orderTime': FieldValue.serverTimestamp(),
                      'orderNote': ordernowController.text,
                    });
                  }
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: ConfirmedOrder(), withNavBar: false);
                })
              ],
            ),
          ),
        ),
      ]),
    ));
  }

  Widget IconMenu1() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SizedBox(
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          )),
    );
  }

  Widget IconMenu() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return const SizedBox(
        child: Text(
      'PKR',
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
    ));
  }

  Widget LoginButton(double height, double width, Function onTap) {
    return SizedBox(
        height: height * 0.07,
        width: width * 0.9,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: yellow,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.5, color: Colors.white),
                  borderRadius: BorderRadius.circular(15))),
          onPressed: () {
            onTap();
          },
          child: SizedBox(
            height: height * 0.1,
            width: width * 0.7,
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  FlickerAnimatedText('Place Order',
                      speed: const Duration(milliseconds: 500),
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ))
                ],
                repeatForever: true,
                displayFullTextOnTap: true,
                totalRepeatCount: 3,
                pause: const Duration(milliseconds: 100),
              ),
            ),
          ),
        ));
  }
}
