import 'package:flutter/foundation.dart';
import 'package:fluttersipay/corporate/dashboard/merchant_repo.dart';
import 'package:fluttersipay/main_api_data_model.dart';

class CorporateNotificationsMainProvider with ChangeNotifier {
  MerchantMainRepository _merchantRepo;
  List _notificationsList;
  bool _showLoad = false;


  bool get showLoad => _showLoad;

  set showLoad(bool value) {
    _showLoad = value;
  notifyListeners();
  }

  CorporateNotificationsMainProvider(this._merchantRepo) {
    _getNotificationsForm();
  }

  get notificationsList =>
      _notificationsList != null ? _notificationsList : List();

  void _getNotificationsForm() async {
    MainApiModel notificationsModel =
        await _merchantRepo.corporateNotificationsForm();
    if (notificationsModel.statusCode == 100) {
      _notificationsList = notificationsModel.data['notifications'];
      notifyListeners();
    }
  }

  Future<bool> readNotification(String notificationID)async{
    showLoad = true;
    MainApiModel notificationsModel =
    await _merchantRepo.corporateReadSingleNotification(notificationID);
    showLoad = false;
    return notificationsModel.statusCode == 100;
  }

}
