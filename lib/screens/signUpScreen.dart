import 'dart:io';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/userModel.dart';
import 'package:app/screens/otpVerificationScreen.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:app/screens/termsOfServicesScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/DistrictModel.dart';
import '../models/city_model.dart';
import '../models/region_model.dart';

class SignUpScreen extends BaseRoute {
  final String? appleId;
  final String? email;
  final String? fbId;
  final String? name;
  SignUpScreen({a, o, this.email, this.fbId, this.name, this.appleId})
      : super(a: a, o: o, r: 'SignUpScreen');
  @override
  _SignUpScreenState createState() => new _SignUpScreenState(
      email: email, fbId: fbId, name: name, appleId: appleId);
}

class _SignUpScreenState extends BaseRouteState {
  String? appleId;
  String? email;
  String? fbId;
  String? name;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TextEditingController _cName = new TextEditingController();
  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cMobile = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  TextEditingController _cConfirmPassword = new TextEditingController();
  TextEditingController _cReferralCode = new TextEditingController();
  FocusNode _fReferralCode = new FocusNode();
  FocusNode _fName = new FocusNode();
  FocusNode _fEmail = new FocusNode();
  FocusNode _fMobile = new FocusNode();
  FocusNode _fPassword = new FocusNode();
  FocusNode _fConfirmPassword = new FocusNode();
  bool _isAgree = false;
  File? _tImage;
  bool _isPasswordVisible = false;
  final int _phoneNumberLength = 11;
  bool _isRegionsLoaded = false;
  bool _isCitiesLoaded = false;
  bool _isDistrictsLoaded = false;

  bool _isConfirmPasswordVisible = false;
  _SignUpScreenState({this.email, this.fbId, this.name, this.appleId})
      : super();
  RegionModel? regionModel;
  CityModel? cityModel;
  DistrictModel? districtModel;
  List<RegionModel> regions = [];
  List<CityModel> cities = [];
  List<DistrictModel> districts = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: sc(
          Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 10, right: 10),
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'انشاء حساب',
                              style: TextStyle(
                                color: Color(0xFF164863),
                                fontSize: 18,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Text(
                              'مرحباً بك يمكنك انشاء حساب معنا !',
                              style: TextStyle(
                                color: Color(0xFF164863),
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 60),
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          autofocus: false,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.deny(RegExp(r'[0-9]'))
                          ],
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Color(0xFFF36D86),
                          enabled: true,
                          style: TextStyle(fontFamily: 'cairo'),
                          controller: _cName,
                          focusNode: _fName,
                          onEditingComplete: () {
                            _fEmail.requestFocus();
                          },
                          decoration: InputDecoration(hintText: 'اسم المستخدم'),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          autofocus: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(
                                _phoneNumberLength),
                          ],
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xFFF36D86),
                          enabled: true,
                          style: TextStyle(fontFamily: 'cairo'),
                          controller: _cMobile,
                          focusNode: _fMobile,
                          decoration: InputDecoration(hintText: 'رقم الجوال'),
                          onEditingComplete: () {
                            _fPassword.requestFocus();
                          },
                        )),
                    //!
                    Container(
                      margin: EdgeInsets.only(top: 15), // color: Colors.red,
                      // height: 10,
                      child: DropdownButtonFormField2<RegionModel>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                          // the menu padding when button's width is not specified.
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // Add more decoration..
                        ),
                        hint: const Text(
                          'اختر منطقتك',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: regions
                            .map((item) => DropdownMenuItem<RegionModel>(
                                  value: item,
                                  child: Text(
                                    item.nameAr ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'من فضلك اختر بلدك';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cities = [];
                          districts = [];
                          // cityModel = null;
                          setState(() {});
                          regionModel = value;
                          _getCities(id: value!.regionId ?? 1);
                          //Do something when selected item is changed.
                        },
                        onSaved: (value) {
                          regionModel = value;
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    cities.isEmpty
                        ? Container()
                        : Container(
                            margin:
                                EdgeInsets.only(top: 15), // color: Colors.red,
                            // height: 10,
                            child: DropdownButtonFormField2<CityModel>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                // Add Horizontal padding using menuItemStyleData.padding so it matches
                                // the menu padding when button's width is not specified.
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                // Add more decoration..
                              ),
                              hint: const Text(
                                'اختر مدينتك',
                                style: TextStyle(fontSize: 14),
                              ),
                              // value: cityModel,
                              items: cities
                                  .map((item) => DropdownMenuItem<CityModel>(
                                        value: item,
                                        child: Text(
                                          item.nameAr ?? '',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'من فضلك اختر مدينتك';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  districts = [];
                                  // districtModel = null;
                                });
                                cityModel = value;
                                _getDistrict(cityId: value!.cityId ?? 1);
                                //Do something when selected item is changed.
                              },
                              onSaved: (value) {
                                cityModel = value;
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 24,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                    districts.isEmpty
                        ? Container()
                        : Container(
                            margin:
                                EdgeInsets.only(top: 15), // color: Colors.red,
                            // height: 10,
                            child: DropdownButtonFormField2<DistrictModel>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                // Add Horizontal padding using menuItemStyleData.padding so it matches
                                // the menu padding when button's width is not specified.
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                // Add more decoration..
                              ),
                              hint: const Text(
                                'اختر الحي',
                                style: TextStyle(fontSize: 14),
                              ),
                              // value: cityModel,
                              items: districts
                                  .map(
                                      (item) => DropdownMenuItem<DistrictModel>(
                                            value: item,
                                            child: Text(
                                              item.nameAr ?? '',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'من فضلك اختر الحي';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                //Do something when selected item is changed.
                                districtModel = value;
                              },
                              onSaved: (value) {
                                districtModel = value;
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 24,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),

                    Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          autofocus: false,
                          cursorColor: Color(0xFFF36D86),
                          enabled: true,
                          obscureText: !_isPasswordVisible,
                          style: TextStyle(fontFamily: 'cairo'),
                          controller: _cPassword,
                          focusNode: _fPassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: IconTheme.of(context).color),
                                onPressed: () {
                                  _isPasswordVisible = !_isPasswordVisible;
                                  setState(() {});
                                },
                              ),
                              hintText: 'كلمة المرور'),
                          onEditingComplete: () {
                            _fConfirmPassword.requestFocus();
                          },
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          autofocus: false,
                          obscureText: !_isConfirmPasswordVisible,
                          cursorColor: Color(0xFFF36D86),
                          enabled: true,
                          style: TextStyle(fontFamily: 'cairo'),
                          controller: _cConfirmPassword,
                          focusNode: _fConfirmPassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: IconTheme.of(context).color),
                                onPressed: () {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                  setState(() {});
                                },
                              ),
                              hintText: 'تأكيد كلمة المرور'),
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(_fReferralCode);
                          },
                        )),
                    Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10),
                        child: TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _signUp();
                            },
                            child: Text(
                              'انشاء حساب',
                              style: TextStyle(fontFamily: 'cairo'),
                            ))),
                    Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 3.5,
                            bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' لديك حساب معنا ؟',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => SignInScreen(
                                            a: widget.analytics,
                                            o: widget.observer)),
                                  );
                                },
                                child: Text(
                                  ' تسجيل دخول ',
                                  style: TextStyle(
                                    color: Color(0xFFF36D86),
                                    fontSize: 18,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                )),
                          ],
                        )),
                  ],
                )),
              ),
            ),
            bottomSheet: Container(
              height: MediaQuery.of(context).size.width / 6,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('assets/images/top.png',
                        width: MediaQuery.of(context).size.width / 3),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _getRegions();
    super.initState();
    _fillData();
  }

  _fillData() {
    _cEmail.text = email != null ? email! : '';
    _cName.text = name != null ? name! : '';
  }

  _sendOTP(String phoneNumber) async {
    print('....phone....:+966$phoneNumber');
    try {
      print('done....phone....:+966$phoneNumber');
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+966$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          hideLoader();
          showSnackBar(
              key: _scaffoldKey,
              snackBarMessage: AppLocalizations.of(context)!
                  .txt_please_try_again_after_sometime);
        },
        codeSent: (String verificationId, int? resendToken) async {
          hideLoader();
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => OTPVerificationScreen(
                      a: widget.analytics,
                      o: widget.observer,
                      verificationId: verificationId,
                      phoneNumberOrEmail: phoneNumber,
                    )),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("Exception - OTP - _sendOTP():" + e.toString());
    }
  }

  _signUp() async {
    try {
      CurrentUser _user = new CurrentUser();
      if (appleId != null) {
        _user.apple_id = appleId;
      }
      _user.area = districtModel?.nameAr ?? '';
      _user.city = cityModel?.nameAr ?? '';
      _user.region = regionModel?.nameAr ?? '';
      // _user.address =
      //     "${regionModel?.nameAr ?? ''} - ${cityModel?.nameAr ?? ''} - ${districtModel?.nameAr ?? ''}";
      _user.user_name = _cName.text.trim();
      // _user.user_email = _cEmail.text.trim();
      _user.user_phone = _cMobile.text.trim();
      _user.user_password = _cPassword.text.trim();
      // _user.user_image = _tImage;
      _user.device_id = global.appDeviceId;
      // _user.referral_code = null;
      _user.fb_id = fbId != null ? fbId : null;
      // _user.referral_code = _cReferralCode.text;
      if (_cName.text.isNotEmpty &&
          _cMobile.text.isNotEmpty &&
          // _cMobile.text.trim().length == _phoneNumberLength &&
          _cPassword.text.isNotEmpty &&
          _cConfirmPassword.text.isNotEmpty &&
          _cPassword.text.trim() == _cConfirmPassword.text.trim() &&
          regionModel != null) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.signUp(_user, context).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                hideLoader();
                await _sendOTP(_cMobile.text.trim());
              } else {
                hideLoader();

                showSnackBar(
                    key: _scaffoldKey,
                    snackBarMessage: result.message.toString());
              }
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cName.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_your_name);
      } else if (_cMobile.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: AppLocalizations.of(context)!
                .txt_please_enter_valid_mobile_number);
      } else if (regionModel == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'من فضلك اختر مدينتك');
      } else if ((cityModel == null && cities.isNotEmpty)) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'من فضلك اختر منطقتك');
      } else if (districtModel == null && districts.isNotEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'من فضلك اختر الحي');
      } else if (_cPassword.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_your_password);
      }
      // else if (_cPassword.text.isNotEmpty &&
      //     _cPassword.text.trim().length < 8) {
      //   showSnackBar(
      //       key: _scaffoldKey,
      //       snackBarMessage: AppLocalizations.of(context)!
      //           .txt_password_should_be_of_minimum_8_character);
      // }
      // else if (_cConfirmPassword.text.isEmpty && _cPassword.text.isNotEmpty) {
      //   showSnackBar(
      //       key: _scaffoldKey,
      //       snackBarMessage:
      //           AppLocalizations.of(context)!.txt_please_reEnter_your_password);
      // }
      else if (_cConfirmPassword.text.isNotEmpty &&
          _cPassword.text.isNotEmpty &&
          (_cConfirmPassword.text.trim() != _cPassword.text.trim())) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'كلمة المرور غير متطابقه');
      }
      // else if (!_isAgree) {
      //   showSnackBar(
      //       key: _scaffoldKey,
      //       snackBarMessage: AppLocalizations.of(context)!
      //           .txt_please_agree_term_condition_to_complete_your_registeration);
      // }
    } catch (e) {
      print("Exception - signUpScreen.dart - _signUp():" + e.toString());
    }
  }

  _getRegions() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getRegions().then((result) {
          if (result != null) {
            regions = result.map((e) => RegionModel.fromJson(e)).toList();
          }
          _isRegionsLoaded = true;
          setState(() {});
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - _getProducts():" + e.toString());
    }
  }

  _getCities({required int id}) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getCities(id: id).then((result) {
          if (result != null) {
            cities = result.map((e) => CityModel.fromJson(e)).toList();
          }
          _isCitiesLoaded = true;
          setState(() {});
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - _getProducts():" + e.toString());
    }
  }

  _getDistrict({required int cityId}) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getDistrict(cityId: cityId).then((result) {
          if (result != null) {
            districts = result.map((e) => DistrictModel.fromJson(e)).toList();
          }
          _isDistrictsLoaded = true;
          setState(() {});
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - getDistrict():" + e.toString());
    }
  }
  //
}
