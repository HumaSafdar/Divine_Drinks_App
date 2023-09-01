import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divine/BottomNavigationBarScreens.dart/CartScreen.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/BackGroundImage.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Color.dart';
import 'package:divine/Screens.dart/Re_use_able_classes.dart/Utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'OrderSummary.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.TotalCartPrice});
  final num TotalCartPrice;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  //key for TextFiels
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  //Controller for Textfield
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  Map<String, dynamic> userdata = {};
  String? email = FirebaseAuth.instance.currentUser!.email;
  Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
  }

  
  void storeconfirmedOrder() async {
    String? email = FirebaseAuth.instance.currentUser!.email;
    String username = usernameController.text;
    String phoneNumber = phoneController.text;
    String Address = AddressController.text;
    String selectedcity = SelectedCity;
    String location = currentAddress;
    await FirebaseFirestore.instance
        .collection('ConfirmedOrder')
        .doc(email)
        .set({
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
      'Address': Address,
      'selectedcity': selectedcity,
      'location': location,
      'orderTime': FieldValue.serverTimestamp(),
    });
  }

  Future<void> loadUserdata() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await getData();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      setState(() {
        usernameController.text = data['Username'] ?? '';
        phoneController.text = data['PhoneNumber'] ?? '';
        userdata = snapshot.data()!;
      });
    }
  }

  bool isLocationFetched = false;
  String currentAddress = '';
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng(_currentPosition!);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        isLocationFetched = true;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
 bool isKeyboardOpen = false;
  @override
  void initState() {
    super.initState();
    loadUserdata();
    
   
  }

  List<String> cities = [
    'Bahawalpur',
    'Multan',
    'Vehari',
    ' Lahore',
    'Karachi',
    'Peshawar',
    'Islamabad',
    'Sahiwal',
    'Rahim Yar Khan',
    'SadiqAbad',
    'Gujrat',
    'Rawalpindi',
    'Gujranwala',
    'FaislAbad',
    'Kamalia',
  ];
  String SelectedCity = '';

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
        height: height * 0.85,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: IconMenu1(),
                    ),
                    IconMenu(),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    SizedBox(
                      width: width * 0.2,
                      child: Text(
                        '${widget.TotalCartPrice}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: height * 0.08,
                width: width * 0.9,
                decoration: const BoxDecoration(
                  color: boxcolor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text1(height, width, 'Email', '$email')],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Text(
                'Shipping Address',
                style: TextStyle(
                    color: yellow, fontWeight: FontWeight.w900, fontSize: 17),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Form(
                key: formstate,
                child: Container(
                  height: height * 0.6,
                  width: width * 0.9,
                  decoration: const BoxDecoration(color: boxcolor),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        userNameUpdateField(
                          height * 0.08,
                          width * 0.9,
                          userdata['Username'].toString(),
                          usernameController,
                        ),
                        SizedBox(
                          height: height * 0.08,
                          child: phoneUpdateField(
                              height * 0.08,
                              width * 0.9,
                              userdata['PhoneNumber'].toString(),
                              phoneController),
                        ),
                        SizedBox(
                          height: height * 0.1,
                          child: AddressUpdateField(height * 0.08, width * 0.9,
                              AddressController, 'Address can not be Empty'),
                        ),
                        CityUpdateField(height, width, cityController,
                            'Please select city'),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            textAlign: TextAlign.start,
                            onTap: () {
                              _getCurrentPosition();
                            },
                            decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: const UnderlineInputBorder(),
                                hintStyle: TextStyle(
                                    color: isLocationFetched
                                        ? Colors.white
                                        : yellow,
                                    fontWeight: FontWeight.w600),
                                hintText: isLocationFetched
                                    ? currentAddress
                                    : "Share Location",
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                        LoginButton(height, width, () {
                          if (formstate.currentState!.validate()) {
                            storeconfirmedOrder();
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: OrderSummary(
                                  ShipingItemPrice: widget.TotalCartPrice,
                                ),
                                withNavBar: false);
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ])));
  }

  Widget IconMenu() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return const SizedBox(
        child: Text(
      'PKR',
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
    ));
  }

  Widget IconMenu1() {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SizedBox(
      child: IconButton(
          onPressed: () {
            PersistentNavBarNavigator.pushNewScreen(context,
                screen: const CartScreen(), withNavBar: true);
            // Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          )),
    );
  }

  Widget Text1(double height, double width, String Text1, String text2) {
    return SizedBox(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              Text1,
              style: const TextStyle(
                  color: yellow, fontWeight: FontWeight.w900, fontSize: 15),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                text2,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15),
              )),
        ],
      ),
    );
  }

  Widget userNameUpdateField(
    double height,
    double width,
    String value,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const UnderlineInputBorder(),
            labelText: 'Username',
            labelStyle: const TextStyle(
              fontSize: 15,
              color: yellow,
              fontWeight: FontWeight.w900,
            ),
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900),
            hintText: value,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }

  Widget CityUpdateField(
    double height,
    double width,
    TextEditingController controller,
    String validationText,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        controller:
            TextEditingController(text: SelectedCity ?? 'Select a City'),
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  showCitypiker(height * 0.03, width * 0.08, context);
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: yellow,
                  size: 30,
                )),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const UnderlineInputBorder(),
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900),
            labelText: 'Select City',
            labelStyle: const TextStyle(
                color: yellow, fontWeight: FontWeight.w900, fontSize: 15),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationText;
          }
          return null;
        },
      ),
    );
  }

  Widget phoneUpdateField(
    double height,
    double width,
    String value,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const UnderlineInputBorder(),
            labelText: 'PhoneNumber',
            labelStyle: const TextStyle(
              fontSize: 15,
              color: yellow,
              fontWeight: FontWeight.w900,
            ),
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900),
            hintText: value,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        keyboardType: TextInputType.phone,
      ),
    );
  }

  Widget container(
      double height, double width, BuildContext context, String text1) {
    String? email = FirebaseAuth.instance.currentUser!.email;
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        color: boxcolor,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text1,
                  style: const TextStyle(
                    fontSize: 14,
                    color: yellow,
                    fontWeight: FontWeight.w900,
                  )),
              SizedBox(height: height * 0.005),
              Text(
                '$email',
                style: const TextStyle(fontSize: 17, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showCitypiker(
    double height,
    double width,
    BuildContext context,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cities[index]),
                onTap: () {
                  setState(() {
                    SelectedCity = cities[index];
                  });
                  Navigator.pop(context);
                },
                //selected: SelectedCity == cities[index],
              );
            },
          );
        });
  }

  Widget AddressUpdateField(
    double height,
    double width,
    TextEditingController controller,
    String validationText,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        controller: controller,
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: UnderlineInputBorder(),
            labelText: 'Address',
            labelStyle: TextStyle(
              fontSize: 15,
              color: yellow,
              fontWeight: FontWeight.w900,
            ),
            hintStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            // hintText: 'Address',
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationText;
          }
          return null;
        },
      ),
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
              'Continue to Payment',
              style: TextStyle(
                  color: TextColor, fontWeight: FontWeight.w800, fontSize: 16),
            )));
  }
}
