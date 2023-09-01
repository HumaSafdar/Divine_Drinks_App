import 'package:flutter/material.dart';

import 'Color.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splashimage1.jpeg'),
              fit: BoxFit.fill),
        ),
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
          darkColor.withOpacity(0.4),
          lightColor.withOpacity(0.5)
        ], begin: Alignment.bottomLeft, end: Alignment.topRight))),
      ),
    ));
  }
}
