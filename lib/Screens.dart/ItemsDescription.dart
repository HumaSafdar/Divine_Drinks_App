import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divine/Models.dart/ItemsDescriptionModel.dart';
import 'package:divine/Models.dart/appbarname.dart';
import 'package:divine/Screens.dart/DescriptionScree.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';

import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';

import 'package:flutter/material.dart';

import '../BottomNavigationBarScreens.dart/CartScreen.dart';
import '../BottomNavigationBarScreens.dart/HomeScreen.dart';
import '../BottomNavigationBarScreens.dart/ItemPage.dart';
import '../BottomNavigationBarScreens.dart/SearchScreen.dart';
import 'DrawerScreen.dart';

class ItemsDescription extends StatefulWidget {
  ItemsDescription({super.key, required this.id});
  static const pageName = "/ItemsDescription";
  String id;
  @override
  State<ItemsDescription> createState() => _ItemsDescriptionState();
}

class _ItemsDescriptionState extends State<ItemsDescription> {
  int indexScreen = 0;
  final screens = [
    const ItemPage(),
    const MyHomePage(),
    const SearchScreen(),
    const CartScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    String id = widget.id.trim();
    final firebaseImage = FirebaseFirestore.instance
        .collection('drinks')
        .doc(id)
        .collection('juiceDetail')
        .snapshots();
    final firebaseImage1 = FirebaseFirestore.instance
        .collection('drinks')
        .doc(id)
        .collection('appbarname')
        .snapshots();

    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.07,
                  width: width * 0.9,
                  child: StreamBuilder<dynamic>(
                      stream: firebaseImage1,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: darkColor,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Appbarname appbarName = Appbarname.fromMap(
                                  snapshot.data.docs[index].data());
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      appbarName.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    MenuIcon(height, width),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return const Text('Something went wrong');
                        }
                      }),
                ),
                SizedBox(
                  height: height * 0.8,
                  width: width * 0.9,
                  child: StreamBuilder<dynamic>(
                    stream: firebaseImage,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: darkColor,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(

                                  crossAxisSpacing: 8,
                                  childAspectRatio: 3 / 4,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            ItemDescriptionModel itemDescriptionModel =
                                ItemDescriptionModel.fromMap(
                                    snapshot.data.docs[index].data());

                            return SizedBox(
                              height: height * 0.4,
                              width: width * 0.45,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return DescriptionScreen(
                                          id: itemDescriptionModel.id,
                                          image: itemDescriptionModel.image,
                                          name: itemDescriptionModel.name,
                                          price: itemDescriptionModel.price,
                                          originalprice:
                                              itemDescriptionModel.price,
                                          description:
                                              itemDescriptionModel.description,
                                          quantity:
                                              itemDescriptionModel.quantity,
                                        );
                                      },
                                      transitionDuration:
                                          const Duration(seconds: 1),
                                      reverseTransitionDuration:
                                          const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: boxcolor),
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 6,
                                            child: Hero(
                                              flightShuttleBuilder:
                                                  (flightContext,
                                                      animation,
                                                      flightDirection,
                                                      fromHeroContext,
                                                      toHeroContext) {
                                                final Widget toHero =
                                                    toHeroContext.widget;
                                                return RotationTransition(
                                                  turns: animation,
                                                  child: toHero,
                                                );
                                              },
                                              tag: itemDescriptionModel.image,
                                              child: Image.network(
                                                  itemDescriptionModel.image),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12),
                                              child: Text(
                                                itemDescriptionModel.name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
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
                                                      fontSize: 15,
                                                      color: yellow,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                    itemDescriptionModel.price
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white)),
                                              ],
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 13),
                                          child: Container(
                                            height: height * 0.05,
                                            width: width * 0.29,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: const Color.fromARGB(
                                                    255, 169, 154, 12)),
                                            child: Center(
                                                child: Text(
                                                    itemDescriptionModel.cart,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
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
              ],
            ),
          ),
        ],
      ),
    ));
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
      width: width * 0.1,
      child: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const DrawerScreen();
              },
            ));
          },
          icon: const Icon(
            Icons.menu,
            size: 25,
            color: Colors.white,
          )),
    );
  }
}
