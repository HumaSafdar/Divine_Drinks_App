import 'package:flutter/material.dart';

class IconBack extends StatefulWidget {
  const IconBack({super.key});

  @override
  State<IconBack> createState() => _IconBackState();
}

class _IconBackState extends State<IconBack> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SizedBox(
      height: height*0.1,
      width: width*0.05,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_outlined,color: Colors.yellow,size: 30,)),
    );
  }
}
