import 'dart:convert';

import 'package:cuidapet_curso/app/models/address_model.dart';
import 'package:cuidapet_curso/app/models/user_model.dart';
import 'package:cuidapet_curso/app/modules/main/main_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACESS_TOKEN = '/_ACESS_TOKEN/';
  static const _DEVICE_ID = '/_DEVICE_ID/';
  static const _USER_DATA = '/_USER_DATA/';
  static const _SELECTED_ADDRESS = '/_SELECTED_ADDRESS/';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  Future<void> registerAcessToken(String token) async {
    await prefs.setString(_ACESS_TOKEN, token);
  }

  String get acessToken => prefs.getString(_ACESS_TOKEN);

  Future<void> registerDeviceId(String deviceId) async {
    await prefs.setString(_DEVICE_ID, deviceId);
  }

  String get acessDeviceId => prefs.getString(_DEVICE_ID);

  Future<void> registerUserData(UserModel user) async {
    await prefs.setString(_USER_DATA, jsonEncode(user));
  }

  UserModel get acessUserData {
    if (prefs.containsKey(_USER_DATA)) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString(_USER_DATA));
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  Future<void> logout() async {
    await prefs.clear();
    Modular.to.pushNamedAndRemoveUntil(MainPage.route, (_) => false);
  }

  Future<void> registerSelectedAddress(AddressModel address) async {
    await prefs.setString(_SELECTED_ADDRESS, address.toJson());
  }

  AddressModel get selectedAddress {
    if (prefs.containsKey(_SELECTED_ADDRESS)) {
      var jsonAddress = prefs.getString(_SELECTED_ADDRESS);
      return AddressModel.fromJson(jsonAddress);
    }
    return null;
  }
}
