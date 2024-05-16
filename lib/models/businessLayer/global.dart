import 'dart:convert';
import 'package:app/models/currencyModel.dart';
import 'package:app/models/googleMapModel.dart';
import 'package:app/models/mapBoxModel.dart';
import 'package:app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? appDeviceId;
String appName = 'Salony';
String appShareMessage =
    "I'm inviting you to use $appName, a simple and easy app to find saloon services and products near by your location. Here's my code [CODE] - jusy enter it while registration.";
String appVersion = '1.0';
String baseUrl = 'https://salony.topbusiness.io/api/';
String baseUrlForImage = 'https://salony.topbusiness.io/';
Currency currency = new Currency();
late String currentLocation;
String googleAPIKey = "AIzaSyDq0ZFr83uRDmH_kz457gYpk_Y2a200hyg";
bool isRTL = false;
String? languageCode;
String? lat;
String? lng;
bool isGoogleMap = false;
MapBoxModel? mapBoxModel = new MapBoxModel();
GoogleMapModel? mapGBoxModel = new GoogleMapModel();
List<String> rtlLanguageCodeLList = [
  'ar',
  'arc',
  'ckb',
  'dv',
  'fa',
  'ha',
  'he',
  'khw',
  'ks',
  'ps',
  'ur',
  'uz_AF',
  'yi'
];
late SharedPreferences sp;
CurrentUser? user = new CurrentUser();
int cardCount = 0;

Future<Map<String, String>> getApiHeaders(bool authorizationRequired) async {
  Map<String, String> apiHeader = new Map<String, String>();
  if (authorizationRequired) {
    sp = await SharedPreferences.getInstance();
    if (sp.getString("currentUser") != null) {
      CurrentUser currentUser =
          CurrentUser.fromJson(json.decode(sp.getString("currentUser")!));
      user = CurrentUser.fromJson(json.decode(sp.getString("currentUser")!));
      print('aaaaaaaaaaa ... ${user?.cart_count ?? 5}');
      apiHeader.addAll({"Authorization": "Bearer" + currentUser.token!});
      print('token ${currentUser.token}');
    }
  }
  apiHeader.addAll({"Content-Type": "application/json"});
  apiHeader.addAll({"Accept": "application/json"});
  return apiHeader;
}
