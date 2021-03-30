import 'package:dokanamar_driver/screens/newOrders.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class drawerWidget extends StatefulWidget {
  @override
  _drawerWidgetState createState() => _drawerWidgetState();
}

class _drawerWidgetState extends State<drawerWidget> {

  ListTile drawerItem(iconName, title) {
    return ListTile(
      onTap: () {
        if (title == "New Orders") {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => newOrders()));
        }
      },
      leading: Icon(
        iconName,
        size: 25,
        color: blackColor,
      ),
      title: Text(
        title,
        style: bigHeadingStyle
            .merge(TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
      ),
    );
  }

  Column drawerHeader() {
    return Column(
      children: [profileWidget()],
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: Center(child: drawerHeader())),
          drawerItem(Icons.home, "Home"),
          drawerItem(Icons.list, "New Orders"),
          drawerItem(Icons.wallet_giftcard_outlined, "My Wallet"),
          drawerItem(Icons.replay, "History"),
          drawerItem(Icons.notifications, "Notifications"),
          drawerItem(Icons.card_giftcard_rounded, "Invite Friends"),
          drawerItem(Icons.settings, "Settings"),
          drawerItem(Icons.exit_to_app, "Logout")
        ],
      ),
    );
  }
}
