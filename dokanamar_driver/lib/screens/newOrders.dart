import 'package:dokanamar_driver/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class newOrders extends StatefulWidget {
  @override
  _newOrdersState createState() => _newOrdersState();
}

class _newOrdersState extends State<newOrders> {
  bool abc = false;
  String _availableStatus = "Offline";

  AppBar homeappbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        _availableStatus,
        style:
            bigHeadingStyle.merge(TextStyle(fontSize: 18, color: whiteColor)),
      ),
      actions: [
        Switch(
            activeColor: whiteColor,
            value: abc,
            onChanged: (v) {
              setState(() {
                abc = !abc;
                if (abc) {
                  _availableStatus = "Online";
                } else {
                  _availableStatus = "Offline";
                }
              });
            }),
      ],
    );
  }



  Row profileWidget() {
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(width: 3, color: whiteColor),
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/4310981/pexels-photo-4310981.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Martha Banks",
              style: bigHeadingStyle
                  .merge(TextStyle(color: whiteColor, fontSize: 20)),
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
                  Icon(
                    Icons.star,
                    size: 20,
                  ),
                  SizedBox(
                    width: 4,
                  ),
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

  Container topSheet() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.6),
      ),
      padding: EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You have 10 new requests",
            style: bigHeadingStyle
                .merge(TextStyle(color: whiteColor, fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Container mapWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/onBoarding/map.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container bottomSheet() {
    return Container(
      height: 240,
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 7,
                spreadRadius: 5)
          ]),
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
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.pexels.com/photos/4310981/pexels-photo-4310981.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Martha Banks",
                    style: bigHeadingStyle.merge(
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "ApplePay",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Discount",
                          style: TextStyle(fontSize: 10),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "USD325.00",
                    style: bigHeadingStyle.merge(
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                  ),
                  Text(
                    "2.2km",
                    style: greyHeadingStyle,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
            },

            title: Text(
              "PICK UP",
              style: bigHeadingStyle
                  .merge(TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            ),
            subtitle: Text("7958 Swift Village"),
          ),
          SizedBox(
            child: Container(height: 1,
            color: Colors.grey,),
          ),
          ListTile(
            onTap: () {
            },

            title: Text(
              "DROP OFF",
              style: bigHeadingStyle
                  .merge(TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            ),
            subtitle: Text("105 William St,Chicago ,US"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(),
      appBar: homeappbar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [topSheet(), bottomSheet(),SizedBox(height: 10,),bottomSheet(),SizedBox(height: 10,),bottomSheet()],
        ),
      ),
    );
  }
}
