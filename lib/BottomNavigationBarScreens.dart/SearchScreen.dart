import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divine/Models.dart/ItemsDescriptionModel.dart';
import 'package:divine/Screens.dart/DescriptionScree.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../Screens.dart/DrawerScreen.dart';
import '../Screens.dart/Re_use_able_classes.dart/Color.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ 
    
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<ItemDescriptionModel> foodList = <ItemDescriptionModel>[];
  List<ItemDescriptionModel> filterList = <ItemDescriptionModel>[];
  
  @override
  void initState() {
    super.initState();
    outerListModel();
   
  }
 

  void outerListModel() async {
    final outerfireStore =
        await FirebaseFirestore.instance.collection("drinks").get();
    for (var element in outerfireStore.docs) {
      final innerfireStore = await element.reference.collection('juiceDetail').get();
      foodList.addAll(innerfireStore.docs
          .map((e) => ItemDescriptionModel.fromMap(e.data()))
          .toList());
    }
    foodList.addAll(
        outerfireStore.docs.map((e) => ItemDescriptionModel.fromMap(e.data())));
    filterList.addAll(foodList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    // Check if filterList is empty and the searchController text is empty
    bool isNoSearchResults =
        filterList.isEmpty && searchController.text.isEmpty;
    bool noSearchResults =
        filterList.isEmpty && searchController.text.isNotEmpty;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width,
                    height: height * 0.07,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                              child: Text(
                                'SEARCH',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 10, 0),
                            child: InkWell(
                                onTap: () =>
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const DrawerScreen(),
                                      withNavBar: true,
                                    ),
                                child: const Icon(Icons.menu,
                                    color: Colors.white, size: 25)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: height * 0.08,
                      width: width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 18, 10, 0),
                        child: TextField(
                          controller: searchController,
                          cursorColor: Colors.white,
                          autocorrect: true,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              filterList = foodList.where((element) {
                                return element.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase());
                              }).toList();
                            } else {
                              filterList.clear();
                            }
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: yellow,
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: yellow),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: yellow),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: yellow),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      )),
                  SizedBox(
                    height: height * 0.69,
                    width: width * 0.95,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(7, 35, 7, 0),
                      child: isNoSearchResults
                          ? Container(
                              color: boxcolor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 12, 0, 0),
                                      child: Text(
                                        'Recent Searches',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 150),
                                  Center(
                                      child: Icon(Icons.search,
                                          size: 50, color: Colors.white)),
                                  Center(
                                    child: Text(
                                      'No recent searches',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: filterList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2 / 3,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5),
                              itemBuilder: (context, index) {
                                ItemDescriptionModel itemDescriptionModel =
                                    filterList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: ((context, animation,
                                                      secondaryAnimation) =>
                                                  DescriptionScreen(
                                                    id: itemDescriptionModel.id,
                                                    image: itemDescriptionModel
                                                        .image,
                                                    name: itemDescriptionModel
                                                        .name,
                                                    price: itemDescriptionModel
                                                        .price,
                                                    originalprice:
                                                        itemDescriptionModel
                                                            .price,
                                                    description:
                                                        itemDescriptionModel
                                                            .description,
                                                    quantity:
                                                        itemDescriptionModel
                                                            .quantity,
                                                  )),
                                              transitionDuration:
                                                  const Duration(seconds: 1),
                                              reverseTransitionDuration:
                                                  const Duration(seconds: 1)));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: boxcolor),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Image.network(
                                              itemDescriptionModel.image,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7),
                                                child: Text(
                                                    itemDescriptionModel.name,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text('Rs. ',
                                                      style: TextStyle(
                                                          color: yellow,
                                                          fontSize: 15)),
                                                  Text(
                                                      itemDescriptionModel.price
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 0, 15, 15),
                                            child: Container(
                                              height: 33,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                color: const Color.fromARGB(
                                                    255, 225, 205, 18),
                                              ),
                                              child: const Center(
                                                  child: Text('Add to cart',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w900))),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  SizedBox(height: height * 0.05)
                ]),
          )
        ],
      ),
    ));
  }
}
