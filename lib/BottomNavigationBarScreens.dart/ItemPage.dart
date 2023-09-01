import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divine/Models.dart/ItemPagePicture.dart';
import 'package:divine/Models.dart/Items.dart';
import 'package:divine/Screens.dart/ItemsDescription.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../Screens.dart/DrawerScreen.dart';
import '../Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
import '../Screens.dart/Re_use_able_classes.dart/Color.dart';

class ItemPage extends StatefulWidget {
 const ItemPage({
    super.key,
  });
  static const pageName="/ItemPage";

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final firestore =
      FirebaseFirestore.instance.collection('picture').snapshots();
  final firebase = FirebaseFirestore.instance.collection('drinks').snapshots();
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
          child: Column(
            children: [
              SizedBox(
                height: height * 0.29,
                width: width,
                child: Stack(
                  children: [
                    StreamBuilder<dynamic>(
                      stream: firestore,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: darkColor,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            itemBuilder: (context, index) {
                              Picture picture = Picture.fromMap(
                                  snapshot.data.docs[index].data());
                              return SizedBox(
                                  child: Image.network(
                                picture.image,
                                fit: BoxFit.cover,
                              ));
                            },
                          );
                        } else {
                          return const Text('Something went wrong');
                        }
                      },
                    ),
                 
                    Align(
                alignment: Alignment.topRight,
                 child: IconButton(
                           onPressed: () {
                           
                               PersistentNavBarNavigator.pushNewScreen(context,
                screen: const DrawerScreen(), withNavBar: true);
                           },
                           icon: const Icon(
                             Icons.menu,
                             size: 25,
                             color: Colors.black,
                           )),
               ),
                  ],
                ),
              ),
               
              SizedBox(
                height: height * 0.1,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text('DIVINE',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Range',
                          style: TextStyle(
                              fontSize: 17,
                              color: yellow,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 45.0, right: 45.0),
                          child: const Divider(
                            color: Colors.white,
                            thickness: 2,
                            height: 100,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height ,
                width: width,
                child: StreamBuilder<dynamic>(
                  stream: firebase,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: darkColor),
                      );
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 4,
                                crossAxisCount: 2,
                                crossAxisSpacing: 5),
                        itemBuilder: (context, index) {
                          Product product = Product.fromMap(
                              snapshot.data.docs[index].data());
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ItemsDescription(id: product.id);
                                  },
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: boxcolor),
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 6,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          child: Image.network(product.image),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Text(product.name,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(product.range,
                                            style: const TextStyle(
                                                color: yellow,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                fontStyle:
                                                    FontStyle.italic))),
                                  ],
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
              )
            ],
          ),
        )
      ],
    )));
  }
}
