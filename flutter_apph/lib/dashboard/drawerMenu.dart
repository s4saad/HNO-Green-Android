



import 'dart:convert';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fluttersipay/corporate/dashboard/providers/merchant_panel_dashboard_provider.dart';
import 'package:fluttersipay/corporate/dashboard/merchant_repo.dart';
import './activity_details.dart';
import 'package:animated_dialog/AnimatedDialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttersipay/Exchange/exchange.dart';
import 'package:fluttersipay/Money/Requset_money.dart';
import 'package:fluttersipay/Money/Send_money.dart';
import 'package:fluttersipay/Witdrawal/witdrawal.dart';
import 'package:fluttersipay/base_main_repo.dart';
import 'package:fluttersipay/corporate/money/money_panel.dart';
import 'package:fluttersipay/corporate/withdrawal/create_withdrawal.dart';
import 'package:fluttersipay/dashboard/json_models/merchant_panel_ui_model.dart';
import 'package:fluttersipay/dashboard/providers/individual_panel_dashboard_provider.dart';
import 'package:fluttersipay/dashboard/repos/individual_repo.dart';
import 'package:fluttersipay/dashboard/security.dart';
import 'package:fluttersipay/deposit/deposit_panel.dart';
import 'package:fluttersipay/login_screens/login_main.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:fluttersipay/src/custom_clipper.dart';
import 'package:fluttersipay/utils/app_utils.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bank_account.dart';
import 'Help_panel.dart';
import 'Live_support.dart';
import 'Notification_settings.dart';
import 'Profilesetting_panel.dart';
import 'Transaction_history.dart';
import 'Transfer_settins.dart';
import 'package:flutter/material.dart';

import 'notification_panel.dart';

import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';

import './activity_details.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';


import 'package:fluttersipay/dashboard/Transaction_history.dart';


import "package:fluttersipay/main_api_data_model.dart";
import 'Profilesetting_panel.dart';

import 'notification_panel.dart';

var loginModel2;
class DrawerMenu{




  Widget  getDrawer=
    Builder(
  builder: (BuildContext context) {
  return IconButton(
//  icon: const Icon(Icons.arrow_back_ios),
  onPressed: () {
  Navigator.pop(context);
  },
  );
  },
  );







}