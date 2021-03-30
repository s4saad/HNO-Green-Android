import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersipay/Money/Send_money.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Exchange/exchange.dart';
import 'Witdrawal/witdrawal.dart';
import 'corporate/money/money_panel.dart';
import 'corporate/withdrawal/create_withdrawal.dart';
import 'deposit/deposit_panel.dart';

Widget getCustomNavigator(BuildContext context, List<String> menu, int select,
    repo, wallets, UserTypes userType) {
  List<bool> selection = [false, false, false, false];
  selection[select] = true;
  return Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: selection[0] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
            FontAwesomeIcons.moneyBillWaveAlt,
                      color: selection[0] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[0],
                      style: TextStyle(
                        color: selection[0] ? Colors.blue : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  if (select == 0) return;
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DepositPanelScreen(repo, wallets, userType)));
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: selection[1] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.paperPlane,
                      color: selection[1] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[1],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selection[1] ? Colors.blue : Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  if (select == 1) return;
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => userType == UserTypes.Individual
                              ? MoneyTransferSendScreen(repo, wallets)
                              : MoneyPanelScreen(repo, wallets)));
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: selection[2] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.database,
                      color: selection[2] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[2],
                      style: TextStyle(
                          color: selection[2] ? Colors.blue : Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  if (select == 2) return;
                  Navigator.pop(context);
                  userType == UserTypes.Individual
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context2) =>
                                UserWithdrawalPanelScreen(repo, wallets),
                          ))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context2) =>
                                CreateCorporateWithdrawalsPanelScreen(
                                    repo, wallets),
                          ));
                },
              ),
            ),
          ),
       /*   Expanded(
            flex: 1,
            child: Container(
              color: selection[3] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.exchangeAlt,
                      color: selection[3] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[3],
                      style: TextStyle(
                          color: selection[3] ? Colors.blue : Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  if (select == 3) return;
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExchangePanelScreen(repo, wallets, userType),
                      ));
                },
              ),
            ),
          ),*/
        ],
      ),
      height: 60,
      width: double.infinity,
    ),
  );
}










Widget getCustomNavigatorMONEY(BuildContext context, List<String> menu, int select,
    repo, wallets, UserTypes userType) {
  List<bool> selection = [false, false, false, false];
  selection[select] = true;
  return Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: selection[0] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.moneyBillWaveAlt,
                      color: selection[0] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[0],
                      style: TextStyle(
                        color: selection[0] ? Colors.blue : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  if (select == 0) return;
               //   Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          DepositPanelScreen(repo, wallets, userType)));
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: selection[1] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.paperPlane,
                      color: selection[1] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[1],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selection[1] ? Colors.blue : Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
              /*    if (select == 1) return;
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => userType == UserTypes.Individual
                              ? MoneyTransferSendScreen(repo, wallets)
                              : MoneyPanelScreen(repo, wallets)));
                */
                },

              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: selection[2] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.database,
                      color: selection[2] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[2],
                      style: TextStyle(
                          color: selection[2] ? Colors.blue : Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  if (select == 2) return;
                  Navigator.pop(context);
                  userType == UserTypes.Individual
                      ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context2) =>
                            UserWithdrawalPanelScreen(repo, wallets),
                      ))
                      : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context2) =>
                            CreateCorporateWithdrawalsPanelScreen(
                                repo, wallets),
                      ));
                },
              ),
            ),
          ),
          /*   Expanded(
            flex: 1,
            child: Container(
              color: selection[3] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.exchangeAlt,
                      color: selection[3] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[3],
                      style: TextStyle(
                          color: selection[3] ? Colors.blue : Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  if (select == 3) return;
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExchangePanelScreen(repo, wallets, userType),
                      ));
                },
              ),
            ),
          ),*/
        ],
      ),
      height: 60,
      width: double.infinity,
    ),
  );
}




Widget getCustomNavigatorWith(BuildContext context, List<String> menu, int select,
    repo, wallets, UserTypes userType) {
  List<bool> selection = [false, false, false, false];
  selection[select] = true;
  return Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: selection[0] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.moneyBillWaveAlt,
                      color: selection[0] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[0],
                      style: TextStyle(
                        color: selection[0] ? Colors.blue : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  if (select == 0) return;
                  //   Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          DepositPanelScreen(repo, wallets, userType)));
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: selection[1] ? Colors.white : Colors.blue,
              child: FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.paperPlane,
                        color: selection[1] ? Colors.blue : Colors.white,
                        size: 15,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        menu[1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: selection[1] ? Colors.blue : Colors.white,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  onPressed: () {
                       if (select == 1) return;
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => userType == UserTypes.Individual
                              ? MoneyTransferSendScreen(repo, wallets)
                              : MoneyPanelScreen(repo, wallets)));

                  },

              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: selection[2] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.database,
                      color: selection[2] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[2],
                      style: TextStyle(
                          color: selection[2] ? Colors.blue : Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {/*
                  if (select == 2) return;
                  Navigator.pop(context);
                  userType == UserTypes.Individual
                      ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context2) =>
                            UserWithdrawalPanelScreen(repo, wallets),
                      ))
                      : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context2) =>
                            CreateCorporateWithdrawalsPanelScreen(
                                repo, wallets),
                      ));*/
                },
              ),
            ),
          ),
          /*   Expanded(
            flex: 1,
            child: Container(
              color: selection[3] ? Colors.white : Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.exchangeAlt,
                      color: selection[3] ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      menu[3],
                      style: TextStyle(
                          color: selection[3] ? Colors.blue : Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  if (select == 3) return;
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExchangePanelScreen(repo, wallets, userType),
                      ));
                },
              ),
            ),
          ),*/
        ],
      ),
      height: 60,
      width: double.infinity,
    ),
  );
}
