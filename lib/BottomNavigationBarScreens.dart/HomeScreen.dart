import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:divine/Models.dart/dealsModel.dart';

import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../Screens.dart/DrawerScreen.dart';

import '../Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    this.noOrders,
    final int? originalprice,
    Key? key,
  }) : super(key: key);
  static const pageName = "/MyHomePage";

  final int? noOrders;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final firebaseImage2 =
      FirebaseFirestore.instance.collection('deals').snapshots();
  final firestore1 = FirebaseFirestore.instance
      .collection('Orders')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('Orders')
      .snapshots();
  final firebase = FirebaseFirestore.instance.collection('Orders');
 // add to  cart the order and then give us total price 
  Map<String, int> itemQuantities = {}; 
  int cartCounter = 1;

void addTOCart(deals Deals) async {
  int currentQuantity = itemQuantities[Deals.name] ?? 0;

  final newQuantity = currentQuantity + 1;
  final newPrice = Deals.price * newQuantity;

  final cartItemDoc = firebase
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('Orders')
      .doc(Deals.name);

  itemQuantities[Deals.name] = newQuantity;

  cartItemDoc.set({
    'name': Deals.name,
    'image': Deals.image,
    'price': newPrice,
    'originalprice': Deals.price,
    'quantity': Deals.quantity,
    'noOrders': newQuantity,
  });
}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      const BackgroundImage(),
      SizedBox(
        height: height * 0.87,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: height * 0.07,
                  width: width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 10),
                        child: Text1(height, width, 'DEALS'),
                      ),
                      MenuIcon(height, width),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  height: height * 0.79,
                  width: width * 0.7,
                  //for fetching data from firebase
                  child: StreamBuilder<dynamic>(
                      stream: firebaseImage2,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: darkColor,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          // To show data in gridview
                          return GridView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 5,
                                      crossAxisCount: 1),
                              itemBuilder: (context, index) {
                                deals Deals = deals
                                    .fromMap(snapshot.data.docs[index].data());

                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: boxcolor),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Image.network(Deals.image)),
                                      Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 12),
                                            child: Text(
                                              Deals.name,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Rs.',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: yellow,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(Deals.price.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                      color: Colors.white)),
                                            ],
                                          )),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 13),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                            
                                            });
                                            addTOCart(Deals);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: height * 0.05,
                                                width: width * 0.29,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: const Color.fromARGB(
                                                        255, 169, 154, 12)),
                                                child: Center(
                                                    child: Text(Deals.cart,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.white))),
                                              ),
                                              // to show badge on add to cart button
                                              StreamBuilder(
                                                stream: firestore1,
                                                builder: (context, snapshot) {
                                                  int newTotalNoOfOrder = itemQuantities[Deals.name] ?? 0;
                                                  if (snapshot.hasData) {
                                                    final cartItems =
                                                        snapshot.data!.docs;

                                                    for (var cartItem
                                                        in cartItems) {
                                                      if (cartItem['name'] ==
                                                          Deals.name) {
                                                        newTotalNoOfOrder =
                                                            cartItem[
                                                                'noOrders'];
                                                        break;
                                                      }
                                                    }
                                                  }
                                                  if (newTotalNoOfOrder > 0) {
                                                    return Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Badge(
                                                        label: Text(
                                                          '$newTotalNoOfOrder',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return const Text('Something went wrong');
                        }
                      })),
            ],
          ),
        ),
      ),
    ])));
  }

  Widget Text1(double height, double width, String value) {
    return SizedBox(
      height: height * 0.04,
      width: width * 0.4,
      child: Text(
        value,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }

  Widget MenuIcon(
    double height,
    double width,
  ) {
    return SizedBox(
      height: height * 0.045,
      width: width * 0.05,
      child: IconButton(
          onPressed: () {
            PersistentNavBarNavigator.pushNewScreen(context,
                screen: const DrawerScreen(), withNavBar: true);
          },
          icon: const Icon(
            Icons.menu,
            size: 25,
            color: Colors.white,
          )),
    );
  }
}
