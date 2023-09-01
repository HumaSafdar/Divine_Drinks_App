
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:divine/BottomNavigationBarScreens.dart/CartScreen.dart';

import 'Re_use_able_classes.dart/BackGroundImage.dart';
import 'Re_use_able_classes.dart/Color.dart';

class DescriptionScreen extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final num price;
  final num originalprice;
  final String quantity;
  final String description;
  final int? noOrders;
  const DescriptionScreen({
      required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.originalprice,
    required this.description,
    this.noOrders, 
    required this.quantity,
    super.key
    
  }) ;
  static const pageName = "/DescriptionScreen";
  

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}


class _DescriptionScreenState extends State<DescriptionScreen> {
  final firestores = FirebaseFirestore.instance
      .collection('Orders')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('Orders');

  final firestore1 =
     FirebaseFirestore.instance
      .collection('Orders')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('Orders')
      .snapshots();
  int noOrders = 1;
  void AddtoCart() {
    final newPrice = totalPrice(widget.price, noOrders);
    firestores.doc(widget.name).set({
      'name': widget.name,
      'image': widget.image,
      "price": newPrice,
      'originalprice': widget.originalprice,
      "noOrders": noOrders++,
      'quantity': widget.quantity,
    });
  }

  num totalPrice(item, Noorders) {
    return item * Noorders;
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
            SingleChildScrollView(
                child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: yellow,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                           return const  CartScreen(); 
                          },));
                        },
                        icon: const Icon(
                          Icons.child_friendly,
                          size: 30,
                          color: yellow,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.15,
              ),
              Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                    color: boxcolor, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: widget.image,
                      placeholderBuilder: (context, heroSize, child) {
                        return SizedBox(
                          height: heroSize.height,
                          width: heroSize.width,
                          child: Opacity(
                            opacity: 0.2,
                            child: Image.network(widget.image),
                          ),
                        );
                      },
                      child: Image.network(
                        width: width,
                        height: height * 0.4,
                        widget.image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      height: height * 0.04,
                      width: width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: yellow),
                      child: Center(
                          child: Text(
                        widget.quantity,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Colors.white),
                      )),
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Rs.',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: yellow),
                        ),
                        Text(
                          widget.price.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    InkWell(
                      onTap: () {
                        AddtoCart();
                      },
                      child: Stack(children: [
                        Container(
                          height: height * 0.04,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: yellow),
                          child: const Center(
                              child: Text(
                            'Add to Cart',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Colors.white),
                          )),
                        ),
                        StreamBuilder(
                          stream: firestore1,
                          builder: (context, snapshot) {
                            num newTotalNoOfOrder = 0;
                            if (snapshot.hasData) {
                              final cartItems = snapshot.data!.docs;

                              for (var cartItem in cartItems) {
                                if (cartItem['name'] == widget.name) {
                                  newTotalNoOfOrder += cartItem['noOrders'];
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
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 10),
                                    ),
                                  ));
                            } else {
                              return const SizedBox();
                            }
                          },
                        )
                      ]),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Description:',
                          style: TextStyle(
                              color: yellow,
                              fontWeight: FontWeight.w800,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                      child: Text(
                        widget.description,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.07,
              )
            ]))
          ],
        ),
      ),
    );
  }
}
