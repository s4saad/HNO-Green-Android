import 'package:flutter/material.dart';
import 'package:dokanamar_driver/constant.dart';

class slideTile extends StatelessWidget {
  
  final String imgPath, titleText, subtitleText;

  slideTile({this.imgPath, this.subtitleText, this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imgPath),
          SizedBox(height: 40,),
          Text(
            "Accept a job.",
            textAlign: TextAlign.center,
            style: bigHeadingStyle
          ),
          SizedBox(height: 20,),
          Text(
            "Lorem ipsum dolor sit amet, consectur, \na dipsciling elit. Nullam ac vestibulum",
            textAlign: TextAlign.center,
            style: greyHeadingStyle
          )
        ],
      ),
    );
  }
}
