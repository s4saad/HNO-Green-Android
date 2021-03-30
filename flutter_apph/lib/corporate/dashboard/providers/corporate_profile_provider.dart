import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttersipay/corporate/dashboard/merchant_repo.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CorporateProfileSettingsProvider with ChangeNotifier {
  final MerchantMainRepository _merchantRepo;
  final TextEditingController _currentPasswordController;
  final TextEditingController _newPasswordController;
  TextEditingController _confirmPasswordController;
  Map<String, dynamic> _userInfo;
  File _imageFromGallery;
  File _tempImage;
  bool _showLoad;
  String _userName;
  String _userID;
  String _customerNumber = '';
  String _userProfileAvatar;
  String _confirmPasswordErrorMessage;
  String _newPasswordErrorMessage;
  String _currentPasswordErrorMessage;
  static final kEmptyFieldErrorMessage = translator.translate("passError");
  MainApiModel _merchantDataModel;

  CorporateProfileSettingsProvider(
      this._merchantRepo,
      this._merchantDataModel,
      this._currentPasswordController,
      this._newPasswordController,
      this._confirmPasswordController) {
    getUserProfile();
  }

  get userName => _userName;

  get userID => _userID;

  get customerNumber => _customerNumber;

  get userProfileAvatar => _userProfileAvatar;

  get showLoad => _showLoad;

  set showLoad(bool value) {
    _showLoad = value;
    notifyListeners();
  }

  String get newPasswordErrorMessage => _newPasswordErrorMessage;

  String get confirmPasswordErrorMessage => _confirmPasswordErrorMessage;

  String get currentPasswordErrorMessage => _currentPasswordErrorMessage;

  TextEditingController get currentPasswordController =>
      _currentPasswordController;

  TextEditingController get newPasswordController => _newPasswordController;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  File get imageFromGallery => _imageFromGallery;

  load(bool load) {
    _showLoad = load;
    notifyListeners();
  }

  void getUserProfile() async {
    MainApiModel corporateProfileModel =
        await _merchantRepo.corporateProfileInfo();
    if (corporateProfileModel.statusCode == 100) {
      _userName = corporateProfileModel.data['user']['name'];
      _userID = corporateProfileModel.data['user']['id'].toString();
      _userProfileAvatar = corporateProfileModel.data['user']['img_path'];
      _merchantDataModel.data['user']['img_path'] =
          corporateProfileModel.data['user']['img_path'];
      _customerNumber =
          corporateProfileModel.data['user']['customer_number'].toString();
    }
    notifyListeners();
  }

  _resetPasswordErrorMessages() {
    _confirmPasswordErrorMessage = null;
    _currentPasswordErrorMessage = null;
    _newPasswordErrorMessage = null;
    notifyListeners();
  }

  setImagegalary(File image) async {
    _imageFromGallery =
        // ignore: deprecated_member_use
        image;
    notifyListeners();
  }

  pickImageFromLibrary(Function onSuccess, Function onFailure) async {
    _imageFromGallery =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_imageFromGallery != null) _uploadImage(onSuccess, onFailure);
  }

  _uploadImage(Function onSuccess, Function onFailure) async {
    load(true);
    MainApiModel uploadImageModel =
        await _merchantRepo.uploadBase64CorporateImage(_imageFromGallery);
    load(false);
    if (uploadImageModel.statusCode == 100) {
      _userProfileAvatar = uploadImageModel.data['user']['avatar'];
      _merchantDataModel.data['user']['img_path'] = _userProfileAvatar;
      onSuccess();
    } else {
      onFailure(uploadImageModel.description);
    }
  }

  String errorText = '';

  savePasswordUpdate(Function onSuccess, Function onFailure) async {
    errorText = '';
    _resetPasswordErrorMessages();
    if (_currentPasswordController.text.trim().isEmpty ||
        _newPasswordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      if (_currentPasswordController.text.trim().isEmpty)
        _currentPasswordErrorMessage = kEmptyFieldErrorMessage;
      if (_newPasswordController.text.trim().isEmpty)
        _newPasswordErrorMessage = kEmptyFieldErrorMessage;
      if (_confirmPasswordController.text.trim().isEmpty)
        _confirmPasswordErrorMessage = kEmptyFieldErrorMessage;
      return;
    }
    load(true);
    MainApiModel profileUpdateModel =
        await _merchantRepo.changeCorporatePassword(
            _currentPasswordController.text.trim(),
            _newPasswordController.text.trim(),
            _confirmPasswordController.text.trim());
    load(false);

    if (profileUpdateModel.statusCode != 100) {
      errorText = '';
      errorText = profileUpdateModel.description;
      if (profileUpdateModel.statusCode != 2) {
        List<String> list = profileUpdateModel.data['errors']['new_password'] !=
                null
            ? profileUpdateModel.data['errors']['new_password'].cast<String>()
            : List();

        list.forEach((element) {
          if (errorText.isEmpty) {
            errorText = element;
          } else {
            errorText = errorText + '\n' + element;
          }
        });

        List<String> list2 =
            profileUpdateModel.data['errors']['confirm_new_password'] != null
                ? profileUpdateModel.data['errors']['confirm_new_password']
                    .cast<String>()
                : List();
        list2.forEach((element) {
          if (errorText.isEmpty) {
            errorText = element;
          } else {
            errorText = errorText + '\n' + element;
          }
        });
      }
      print(errorText);
    }
    profileUpdateModel.statusCode == 100
        ? onSuccess()
        : onFailure(profileUpdateModel.description);
  }
}
