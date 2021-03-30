import 'package:dokanamar_driver/constant.dart';
import 'package:dokanamar_driver/screens/newOrders.dart';
import 'package:dokanamar_driver/screens/settingScreen.dart';
import 'package:dokanamar_driver/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool abc = false;
  String _availableStatus="Offline";

  Row profileWidget (){
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              width: 3,
              color: whiteColor
            ),
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/4310981/pexels-photo-4310981.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
                  ),fit: BoxFit.cover
              )
          ),
        ),
        SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Martha Banks",
              style: bigHeadingStyle.merge(TextStyle(color: whiteColor, fontSize: 20)),
            ),
            heightSpace,
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(999),

              ),
              padding: EdgeInsets.all(3),
              child: Row(
                children: [
                  Icon(Icons.star, size: 20,),
                  SizedBox(width: 4,),
                  Text(
                      "Gold Member",
                    style: appbarHeadingStyle.merge(TextStyle(
                      color: blackColor,
                    )),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  AppBar homeappbar (){
    return  AppBar(
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        _availableStatus
        ,style: bigHeadingStyle.merge(TextStyle(fontSize: 18, color: whiteColor)),
      ),
      actions: [
        Switch(
            activeColor: whiteColor,
            value: abc, onChanged: (v){
          setState(() {
            abc = !abc;
            if(abc){
              _availableStatus="Online";
            }else{
              _availableStatus="Offline";
            }
          });
        }
        ),
      ],
    );
  }


  Container topSheet (){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.6),
      ),
      padding: EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You are offline!",
            style: bigHeadingStyle.merge(TextStyle(color: whiteColor, fontSize: 18)),
          ),
          Text(
            "Go online to start accepting jobs.",
            style: bigHeadingStyle.merge(TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.normal)),
          )
        ],
      ),
    );
  }

  Container mapWidget (){
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/onBoarding/map.png"
          ),
          fit: BoxFit.cover,
        ),

      ),
    );
  }

  Expanded bottomSheet (){
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 7,
                  spreadRadius: 5
              )
            ]
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                          width: 3,
                          color: primaryColor
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.pexels.com/photos/4310981/pexels-photo-4310981.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
                          ),fit: BoxFit.cover
                      )
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Martha Banks",
                      style: bigHeadingStyle.merge(TextStyle( fontSize: 15,fontWeight: FontWeight.normal)),
                    ),
                    Text(
                      "Basic level",
                      style: greyHeadingStyle,
                    )
                  ],
                ),
                Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "USD325.00",
                      style: bigHeadingStyle.merge(TextStyle( fontSize: 15,fontWeight: FontWeight.normal)),
                    ),
                    Text(
                      "Earned",
                      style: greyHeadingStyle,
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 5,),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "10.2",
                          style: bigHeadingStyle.merge(TextStyle(color: whiteColor)),
                        ),
                        Text(
                          "ONLINE HOURS",
                          style: greyHeadingStyle.merge(TextStyle(fontSize: 12, color: whiteColor)),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "30 KM",
                          style: bigHeadingStyle.merge(TextStyle(color: whiteColor)),
                        ),
                        Text(
                          "TOTAL DISTANCE",
                          style: greyHeadingStyle.merge(TextStyle(fontSize: 12, color: whiteColor)),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "20",
                          style: bigHeadingStyle.merge(TextStyle(color: whiteColor)),
                        ),
                        Text(
                          "TOTAL JOBS",
                          style: greyHeadingStyle.merge(TextStyle(fontSize: 12, color: whiteColor)),
                        )
                      ],
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(),
      appBar: homeappbar(),
      body: Column(
        children: [
          topSheet(),
          mapWidget(),
          bottomSheet()
        ],
      ),
    );
  }
}
