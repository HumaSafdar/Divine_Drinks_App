// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:divine/BottomNavigationBarScreens.dart/HomeScreen.dart';
// import 'package:divine/BottomNavigationBarScreens.dart/ItemPage.dart';
// import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
// import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import '../../BottomNavigationBarScreens.dart/CartScreen.dart';
// import '../../BottomNavigationBarScreens.dart/SearchScreen.dart';
// import '../../noInternet.dart';

// class bottomNavigation extends StatefulWidget {
//   const bottomNavigation({Key? key}) : super(key: key);
//   static const pageName = "/BottomBarDesign";

//   @override
//   State<bottomNavigation> createState() => _bottomNavigationState();
// }

// class _bottomNavigationState extends State<bottomNavigation> {
//   final fireStore = FirebaseFirestore.instance
//       .collection('Orders')
//       .doc(FirebaseAuth.instance.currentUser!.email)
//       .collection('Orders')
//       .snapshots();

//   int currentIndex = 0;
//   StreamController<ConnectivityResult>? connectivityController;
//   StreamSubscription<ConnectivityResult>? subscription;
//   @override
//   void initState() {
//     super.initState();

//     // Initialize the StreamController in initState
//     connectivityController = StreamController<ConnectivityResult>();

//     // Listen for connectivity changes and add the result to the stream
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       connectivityController!.add(result);
//     });
//   }

//   @override
//   void dispose() {
//     // Cancel the subscription and close the StreamController
//     subscription?.cancel();
//     connectivityController?.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> buildScreens() {
//       return [
//         const ItemPage(),
//         const MyHomePage(),
//         const SearchScreen(),
//         const CartScreen(),
//       ];
//     }

//     List<PersistentBottomNavBarItem> navBarsItems() {
//       return [
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.home_filled),
//           activeColorPrimary: boxcolor,
//           inactiveColorPrimary: Colors.white,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.menu_book),
//           activeColorPrimary: boxcolor,
//           inactiveColorPrimary: Colors.white,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.search),
//           activeColorPrimary: boxcolor,
//           inactiveColorPrimary: Colors.white,
//         ),
//         PersistentBottomNavBarItem(
//           icon: Stack(
//             alignment: Alignment.center,
//             children: [
//               const Icon(Icons.shopping_cart),
//               StreamBuilder(
//                 stream: fireStore,
//                 builder: (context, snapshot) {
//                   num newtotalNoOfOrders = 0;
//                   if (snapshot.hasData) {
//                     final cartItems = snapshot.data!.docs;
//                     for (var cartItem in cartItems) {
//                       newtotalNoOfOrders += cartItem['noOrders'];
//                     }
//                   }
//                   if (newtotalNoOfOrders > 0) {
//                     return Positioned(
//                       top: 0,
//                       right: 0,
//                       child: Badge(
//                         label: Text(
//                           '$newtotalNoOfOrders',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 10,
//                           ),
//                         ),
//                       ),
//                     );
//                   } else {
//                     return const SizedBox(); // Return an empty widget if not added to cart
//                   }
//                 },
//               ),
//             ],
//           ),
//           activeColorPrimary: boxcolor,
//           inactiveColorPrimary: Colors.white,
//         ),
//       ];
//     }

//     PersistentTabController controller;

//     controller = PersistentTabController(initialIndex: 0);

//     return SafeArea(
//         child: Scaffold(
//             resizeToAvoidBottomInset: true,
//             body: StreamBuilder<ConnectivityResult>(
//               stream: connectivityController!.stream,
//               builder: (context, snapshot) {
//                 final connectivityResult = snapshot.data;
//                 if (connectivityResult == ConnectivityResult.none) {
//                   // Display the no internet screen
//                   return NoInternetConnectionScreen(
//                     snapshot: snapshot,
//                     widget: Stack(children: [
//                       const BackgroundImage(),
//                       PersistentTabView(
//                         context,
//                         controller: controller,
//                         screens: buildScreens(),
//                         items: navBarsItems(),
//                         confineInSafeArea: true,
//                         margin: const EdgeInsets.fromLTRB(10, 0, 10, 7),
//                         backgroundColor: yellow,
//                         handleAndroidBackButtonPress: true,
//                         resizeToAvoidBottomInset: true,
//                         stateManagement: true,
//                         hideNavigationBarWhenKeyboardShows: true,
//                         decoration: const NavBarDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(30)),
//                             adjustScreenBottomPaddingOnCurve: true,
//                             colorBehindNavBar: boxcolor),
//                         popAllScreensOnTapOfSelectedTab: true,
//                         popActionScreens: PopActionScreensType.all,
//                         popAllScreensOnTapAnyTabs: true,
//                         navBarStyle: NavBarStyle.simple,
//                       )
//                     ]),
//                   );
//                 } else {
//                   return Stack(children: [
//                     const BackgroundImage(),
//                     PersistentTabView(
//                       context,
//                       controller: controller,
//                       screens: buildScreens(),
//                       items: navBarsItems(),
//                       confineInSafeArea: true,
//                       margin: const EdgeInsets.fromLTRB(10, 0, 10, 7),
//                       backgroundColor: yellow,
//                       handleAndroidBackButtonPress: true,
//                       resizeToAvoidBottomInset: true,
//                       stateManagement: true,
//                       hideNavigationBarWhenKeyboardShows: true,
//                       decoration: const NavBarDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                           adjustScreenBottomPaddingOnCurve: true,
//                           colorBehindNavBar: boxcolor),
//                       popAllScreensOnTapOfSelectedTab: true,
//                       popActionScreens: PopActionScreensType.all,
//                       popAllScreensOnTapAnyTabs: true,
//                       navBarStyle: NavBarStyle.simple,
//                     )
//                   ]);
//                 }
//               },
//             )));
//   }
// }

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:divine/BottomNavigationBarScreens.dart/HomeScreen.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../BottomNavigationBarScreens.dart/CartScreen.dart';

import '../../BottomNavigationBarScreens.dart/ItemPage.dart';
import '../../noInternet.dart';
import 'BackGroundImage.dart';
import '../../BottomNavigationBarScreens.dart/SearchScreen.dart';

class bottomNavigation extends StatefulWidget {
  bottomNavigation({super.key});
  static const pageName = "/bottomNavigation";

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  final fireStore = FirebaseFirestore.instance
      .collection('Orders')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('Orders')
      .snapshots();

  int currentIndex = 0;
  StreamController<ConnectivityResult>? connectivityController;
  StreamSubscription<ConnectivityResult>? subscription;
  @override
  void initState() {
    super.initState();

    // Initialize the StreamController in initState
    connectivityController = StreamController<ConnectivityResult>();

    // Listen for connectivity changes and add the result to the stream
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityController!.add(result);
    });
  }

  @override
  void dispose() {
    // Cancel the subscription and close the StreamController
    subscription?.cancel();
    connectivityController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [
        const ItemPage(),
        const MyHomePage(),
        const SearchScreen(),
        const CartScreen(),
      ];
    }

    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    List<PersistentBottomNavBarItem> navBarItems() {
      return [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            activeColorPrimary: boxcolor,
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.menu_book),
            activeColorPrimary: boxcolor,
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.search),
            activeColorPrimary: boxcolor,
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
            icon: Badge(
                label: StreamBuilder(
                  stream: fireStore,
                  builder: (context, snapshot) {
                    num newTotalnoOfOrders = 0;
                    if (snapshot.hasData) {
                      final cartItems = snapshot.data!.docs;
                      for (var cartItem in cartItems) {
                        newTotalnoOfOrders += cartItem['noOrders'];
                      }
                    }
                    return Text(
                      '$newTotalnoOfOrders',
                      //Display the total number of orders
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 10),
                    );
                  },
                ),
                child: const Icon(Icons.shopping_cart_sharp)),
            activeColorPrimary: boxcolor,
            inactiveColorPrimary: Colors.white)
      ];
    }

    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset:false,
      body: StreamBuilder<ConnectivityResult>(
          stream: connectivityController!.stream,
          builder: (context, snapshot) {
            final connectivityResult = snapshot.data;
            if (connectivityResult == ConnectivityResult.none) {
              // Display the no internet screen
              return NoInternetConnectionScreen(
                  snapshot: snapshot,
                  widget: Stack(
                    children: [
                      const BackgroundImage(),
                      PersistentTabView(
                        context,
                        controller: controller,
                        screens: buildScreens(),
                        items: navBarItems(),
                        confineInSafeArea: true,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 7),
                        backgroundColor: yellow,
                        handleAndroidBackButtonPress: true,
                        resizeToAvoidBottomInset: true,
                        stateManagement: true,
                        hideNavigationBarWhenKeyboardShows: true,
                        decoration: const NavBarDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            adjustScreenBottomPaddingOnCurve: true,
                            colorBehindNavBar: boxcolor),
                        popAllScreensOnTapOfSelectedTab: true,
                        popActionScreens: PopActionScreensType.all,
                        popAllScreensOnTapAnyTabs: true,
                        navBarStyle: NavBarStyle.simple,
                      )
                    ],
                  ));
            } else {
                  return Stack(children: [
                    const BackgroundImage(),
                    PersistentTabView(
                      context,
                      controller: controller,
                      screens: buildScreens(),
                      items: navBarItems(),
                      confineInSafeArea: true,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 7),
                      backgroundColor: yellow,
                      handleAndroidBackButtonPress: true,
                      resizeToAvoidBottomInset: true,
                      stateManagement: true,
                      hideNavigationBarWhenKeyboardShows: true,
                      decoration: const NavBarDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          adjustScreenBottomPaddingOnCurve: true,
                          colorBehindNavBar: boxcolor),
                      popAllScreensOnTapOfSelectedTab: true,
                      popActionScreens: PopActionScreensType.all,
                      popAllScreensOnTapAnyTabs: true,
                      navBarStyle: NavBarStyle.simple,
                    )
                  ]);
                }
          }),
    ));
  }
}
