import 'package:dokanamar_driver/constant.dart';
import 'package:dokanamar_driver/screens/signUp.dart';

import 'package:dokanamar_driver/widgets/slideTile.dart';import 'package:flutter/material.dart';

class onBoarding extends StatefulWidget {
  @override
  _onBoardingState createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {

  int slideIndex = 0;

  PageController pageController;

//  List<SliderModel> mySlides = List<SliderModel>();

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.redAccent : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: PageView(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                controller: pageController,
                children: [
                  slideTile(
                    imgPath: "assets/onBoarding/1.png",
                  ),
                  slideTile(
                    imgPath:"assets/onBoarding/2.png",
                  ),
                  slideTile(
                    imgPath: "assets/onBoarding/3.png",
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: sdk_version_ui_as_code
                  for (int i = 0; i < 3; i++)
                    i == slideIndex
                        ? _buildPageIndicator(true)
                        : _buildPageIndicator(false),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> signUp()));
              },
              child: Text(
                "SKIP",
                style: greyHeadingStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
