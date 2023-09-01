import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divine/BottomNavigationBarScreens.dart/ItemPage.dart';

import 'package:divine/Models.dart/cartModel.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../AddressScreen.dart';
import '../Screens.dart/DrawerScreen.dart';
import '../Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });
  static const pageName = "/CartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // To store data in firebase
  final firestore = FirebaseFirestore.instance
      .collection('Orders')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('Orders')
      .snapshots();

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
                        child: Text1(height, width, 'CART'),
                      ),
                      MenuIcon(height, width),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.63,
                width: width,
                // fetch data from firestore
                child: StreamBuilder(
                  stream: firestore,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: boxcolor,
                        ),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.27),
                          CartIcon(height, width),
                          Text2(height, width, 'Your cart is currently empty!')
                        ],
                      );
                    } else if (snapshot.hasData) {
                      final cartItems = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          cartModel model = cartModel
                              .fromMap(snapshot.data!.docs[index].data());
                          final CartItem = snapshot.data!.docs[index];
                          final Itemid = CartItem.id;
                          if (model.noOrders == 0) {
                            return const SizedBox();
                          }
                          // delete item from cart if the number of item is less then 1
                          void deleteItemFromCart() {
                            FirebaseFirestore.instance
                                .collection('Orders')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('Orders')
                                .doc(Itemid)
                                .update({
                              'noOrders': 0,
                              'price': 0,
                            });
                          }

                          return Card(
                            color: boxcolor,
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.13,
                                  width: width * 0.23,
                                  color: boxcolor,
                                  child: Image.network(model.image),
                                ),
                                SizedBox(
                                  width: width * 0.19,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.15,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 7),
                                              child: Text(
                                                model.name,
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    color: yellow,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.1,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Rs.',
                                                  style: TextStyle(
                                                      color: yellow,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  height: height * 0.03,
                                                  width: width * 0.06,
                                                  child: Center(
                                                    child: Text(
                                                      model.originalprice
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 9,
                                                          color: yellow,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                          width: width * 0.15,
                                          child: Center(
                                            child: Text(
                                              model.quantity,
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: yellow,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.12,
                                  child: const VerticalDivider(
                                    thickness: 2,
                                    color: yellow,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.12,
                                  width: width * 0.2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        'Quantity',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        width: width * 0.13,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                //Decrement the number of order and then give new price
                                                final newQuantity =
                                                    CartItem['noOrders'] - 1;
                                                if (newQuantity < 0) {
                                                  deleteItemFromCart();
                                                } else {
                                                  final newPrice =
                                                      (CartItem['price'] /
                                                          CartItem['noOrders'] *
                                                          newQuantity).toInt();
                                                  FirebaseFirestore.instance
                                                      .collection('Orders')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.email)
                                                      .collection('Orders')
                                                      .doc(Itemid)
                                                      .update({
                                                    'noOrders': newQuantity,
                                                    'price': newPrice,
                                                  });
                                                }
                                              },
                                              child: const Text(
                                                '-',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Text(
                                              (model.noOrders.toString()),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                //Increment the number of orders and and give us the new price
                                                final newQuantity =
                                                    CartItem['noOrders'] + 1;
                                                int newPrice =
                                            (CartItem['price'] /
                                                        CartItem["noOrders"] *
                                                        newQuantity).toInt();
                                                FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.email)
                                                    .collection('Orders')
                                                    .doc(Itemid)
                                                    .update({
                                                  'noOrders': newQuantity,
                                                  'price': newPrice,
                                                });
                                              },
                                              child: const Text(
                                                '+',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.12,
                                  child: const VerticalDivider(
                                    thickness: 2,
                                    color: yellow,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.12,
                                  width: width * 0.25,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          'Price',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: width * 0.2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                'Rs.',
                                                style: TextStyle(
                                                    color: yellow,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                model.price.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text('Something went wrong');
                    }
                  },
                ),
              ),
              SizedBox(
                height: height * 0.2,
                child: StreamBuilder(
                    stream: firestore,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: boxcolor,
                        ));
                      } else if (snapshot.hasError) {
                        return const Text(
                          'Error Loading data',
                          style: TextStyle(color: Colors.red, fontSize: 17),
                        );
                      } else {
                        // give us the total price of all the orders
                        num totalCartPrice = 0;
                        if (snapshot.hasData) {
                          final cartItems = snapshot.data!.docs;
                          for (var cartItem in cartItems) {
                            totalCartPrice += cartItem['price'];
                          }
                        }

                        return Column(
                          children: [
                            SizedBox(
                              height: height * 0.1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text3(height, width, 'TOTAL'),
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: yellow),
                                    child: SizedBox(
                                      width: width * 0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Rs.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          SizedBox(width: width*0.01,),
                                          Text(
                                            '$totalCartPrice',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.07,
                              width: width * 0.55,
                              child: Container(
                                height: height * 0.07,
                                width: width * 0.55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: yellow),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      if (totalCartPrice > 0) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return AddressScreen(
                                                TotalCartPrice: totalCartPrice);
                                          },
                                        ));
                                      } else {
                                        // show dialogue
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            backgroundColor: yellow,
                                            title: const Center(
                                                child: Text(
                                              'Error',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: boxcolor),
                                            )),
                                            content: const Text(
                                              'Please! Add something to cart',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                lightColor
                                                                    .withOpacity(
                                                                        0.8)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: InkWell(
                                                      onTap: () {
                                                        FirebaseAuth.instance
                                                            .signOut();
                                                      },
                                                      child: const Text(
                                                        'OK',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Proceed to Checkout',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ),
            ],
          )
        ],
      ),
    ));
    ;
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

  Widget Text3(double height, double width, String value) {
    return SizedBox(
      width: width * 0.22,
      child: Text(
        value,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
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

  Widget CartIcon(double height, double width) {
    return SizedBox(
      height: height * 0.12,
      width: width * 0.3,
      child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart_sharp,
            size: 70,
            color: yellow,
          )),
    );
  }

  Widget Text2(double height, double width, String value) {
    return SizedBox(
      height: height * 0.04,
      width: width * 0.75,
      child: Text(
        value,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
      ),
    );
  }
}
