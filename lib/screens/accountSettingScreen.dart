import 'dart:convert';
import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/businessRule.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/DistrictModel.dart';
import '../models/city_model.dart';
import '../models/region_model.dart';

class AccountSettingScreen extends BaseRoute {
  AccountSettingScreen({a, o}) : super(a: a, o: o, r: 'AccountSettingScreen');

  @override
  _AccountSettingScreenState createState() => new _AccountSettingScreenState();
}

class _AccountSettingScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TextEditingController _cName = new TextEditingController();
  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cMobile = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  TextEditingController _cConfirmPassword = new TextEditingController();
  FocusNode _fName = new FocusNode();
  FocusNode _fEmail = new FocusNode();
  FocusNode _fMobile = new FocusNode();
  FocusNode _fPasword = new FocusNode();
  FocusNode _fConfirmPassword = new FocusNode();
  File? _tImage;
  late BusinessRule br;

  _AccountSettingScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('إعدادات الحساب'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.19,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _tImage != null
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                  width:
                                      MediaQuery.of(context).size.height * 0.17,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardTheme.color,
                                    borderRadius: new BorderRadius.all(
                                      new Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.17),
                                    ),
                                    image: DecorationImage(
                                        image: FileImage(_tImage!),
                                        fit: BoxFit.cover),
                                    border: new Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 3.0,
                                    ),
                                  ),
                                )
                              : global.user!.image != ''
                                  ? CachedNetworkImage(
                                      imageUrl: global.baseUrlForImage +
                                          global.user!.image!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.17,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.17,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).cardTheme.color,
                                          borderRadius: new BorderRadius.all(
                                            new Radius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.17),
                                          ),
                                          image: DecorationImage(
                                              image: imageProvider),
                                          border: new Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 3.0,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.17,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.17,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).cardTheme.color,
                                        borderRadius: new BorderRadius.all(
                                          new Radius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.17),
                                        ),
                                        border: new Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 3.0,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        size: 50,
                                      ),
                                    ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      Positioned(
                          top: 86,
                          right: 15,
                          child: IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                _showCupertinoModalSheet();
                                setState(() {});
                              },
                              icon: Container(
                                  padding: EdgeInsets.all(0),
                                  margin: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF36D86),
                                      borderRadius: BorderRadius.circular(34)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ))))
                    ],
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${global.user!.name}',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              )),
              Align(
                  alignment: global.isRTL
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(
                      'اسم المستخدم',
                      style: Theme.of(context).primaryTextTheme.displaySmall,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  height: 50,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    autofocus: false,
                    cursorColor: Color(0xFFF36D86),
                    style: Theme.of(context).inputDecorationTheme.hintStyle,
                    controller: _cName,
                    focusNode: _fName,
                    onEditingComplete: () {
                      _fPasword.requestFocus();
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'اسم المستخدم'),
                  )),
              // Align(
              //     alignment: global.isRTL
              //         ? Alignment.centerRight
              //         : Alignment.centerLeft,
              //     child: Padding(
              //       padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              //       child: Text(
              //         'البريد الالكتروني',
              //         style: TextStyle(
              //             fontFamily: 'cairo',
              //             color: Colors.black54,
              //             fontSize: 16),
              //       ),
              //     )),
              // Container(
              //     margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              //     height: 50,
              //     child: TextFormField(
              //       textAlign: TextAlign.start,
              //       autofocus: false,
              //       cursorColor: Color(0xFFF36D86),
              //       enabled: true,
              //       readOnly: true,
              //       style: Theme.of(context).inputDecorationTheme.hintStyle,
              //       controller: _cEmail,
              //       focusNode: _fEmail,
              //       decoration: InputDecoration(
              //         prefixIcon: Icon(Icons.email),
              //         hintText: 'البريد الالكتروني',
              //         hintStyle: TextStyle(
              //             fontFamily: 'cairo',
              //             color: Colors.black26,
              //             fontSize: 16),
              //       ),
              //     )),

              Align(
                  alignment: global.isRTL
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(
                      'رقم الهاتف',
                      style: TextStyle(
                          fontFamily: 'cairo',
                          color: Colors.black54,
                          fontSize: 16),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  height: 50,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    autofocus: false,
                    cursorColor: Color(0xFFF36D86),
                    enabled: true,
                    readOnly: true,
                    style: Theme.of(context).inputDecorationTheme.hintStyle,
                    controller: _cMobile,
                    focusNode: _fMobile,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'رقم الهاتف',
                      hintStyle: TextStyle(
                          fontFamily: 'cairo',
                          color: Colors.black26,
                          fontSize: 16),
                    ),
                  )),
              Align(
                  alignment: global.isRTL
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(
                      'كلمة المرور',
                      style: TextStyle(
                          fontFamily: 'cairo',
                          color: Colors.black54,
                          fontSize: 16),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  height: 50,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    autofocus: false,
                    cursorColor: Color(0xFFF36D86),
                    enabled: true,
                    obscureText: true,
                    style: Theme.of(context).inputDecorationTheme.hintStyle,
                    controller: _cPassword,
                    focusNode: _fPasword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      hintText: 'كلمة المرور',
                      hintStyle: TextStyle(
                          fontFamily: 'cairo',
                          color: Colors.black26,
                          fontSize: 16),
                    ),
                    onEditingComplete: () {
                      _fConfirmPassword.requestFocus();
                    },
                  )),
              Align(
                  alignment: global.isRTL
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(
                      'تأكيد كلمة المرور',
                      style: TextStyle(
                          fontFamily: 'cairo',
                          color: Colors.black54,
                          fontSize: 16),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  height: 50,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    autofocus: false,
                    cursorColor: Color(0xFFF36D86),
                    enabled: true,
                    obscureText: true,
                    style: Theme.of(context).inputDecorationTheme.hintStyle,
                    controller: _cConfirmPassword,
                    focusNode: _fConfirmPassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      hintText: 'تأكيد كلمة المرور',
                      helperStyle: TextStyle(
                          fontFamily: 'cairo',
                          color: Colors.black26,
                          fontSize: 16),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                  )),

              //!
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' العنوان الحالي : ',
                      style: TextStyle(
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    Text(
                      '${global.user!.region ?? ""} - ${global.user!.city ?? ""} - ${global.user!.area ?? ""}',
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15), // color: Colors.red,
                // height: 10,
                child: DropdownButtonFormField2<RegionModel>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                      margin: EdgeInsets.only(top: 15), // color: Colors.red,
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
                      margin: EdgeInsets.only(top: 15), // color: Colors.red,
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
                            .map((item) => DropdownMenuItem<DistrictModel>(
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
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(),
              SizedBox(
                width: 150,
                height: 43,
                child: TextButton(
                    onPressed: () {
                      _save();
                    },
                    child: Text(
                      'حفظ',
                      style: TextStyle(
                          fontFamily: 'cairo',
                          color: Colors.white,
                          fontSize: 18),
                    )),
              ),
              SizedBox(),
            ],
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
    super.initState();
    _init();
    _getRegions();
  }

  _init() {
    try {
      _cName.text = global.user!.name!;
      // _cEmail.text = global.user!.email??'';
      _cMobile.text = global.user!.user_phone ?? '';

      setState(() {});
    } catch (e) {
      print("Exception - accountSettingScreen.dart - _init():" + e.toString());
    }
  }

  _save() async {
    try {
      FocusScope.of(context).unfocus();
      global.user!.user_name = _cName.text;
      global.user!.user_password =
          _cPassword.text.isEmpty ? null : _cPassword.text;
      global.user!.region = regionModel?.nameAr;
      global.user!.city = cityModel?.nameAr;
      global.user!.area = districtModel?.nameAr;
      if (_cPassword.text.isNotEmpty &&
          _cPassword.text.trim().length >= 8 &&
          _cConfirmPassword.text.isNotEmpty &&
          _cPassword.text.trim() == _cConfirmPassword.text.trim()) {
      } else if (_cPassword.text.isNotEmpty &&
          _cPassword.text.trim().length < 8) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: 'كلمة المرور يجب  ان تكون اكبر من 8 حروف و ارقام');
      } else if (_cConfirmPassword.text.isNotEmpty &&
          _cConfirmPassword.text.trim() != _cPassword.text.trim()) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'كلمة المرور غير متطابقه');
      }

      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper!
            .updateProfile(
          global.user!.id,
          global.user!.user_name,
          _tImage,
          user_password: global.user!.user_password,
          region: global.user!.region,
          city: global.user!.city,
          area: global.user!.area,
        )
            .then((result) {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();

              global.user = result.data;
              global.sp
                  .setString("currentUser", json.encode(global.user!.toJson()));
              Navigator.of(context).pop();

              setState(() {});
            } else {
              showSnackBar(
                  key: _scaffoldKey, snackBarMessage: '${result.message}');
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - accountSettingScreen.dart - _save():" + e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context)!.lbl_actions),
          actions: [
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context)!.lbl_take_picture,
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context)!.lbl_choose_from_library,
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.selectImageFromGallery();
                hideLoader();

                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context)!.lbl_cancelled,
                style: TextStyle(color: Color(0xFFF36D86))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print(
          "Exception - accountSettingScreen.dart - _showCupertinoModalSheet():" +
              e.toString());
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

  RegionModel? regionModel;
  CityModel? cityModel;
  DistrictModel? districtModel;
  List<RegionModel> regions = [];
  List<CityModel> cities = [];
  List<DistrictModel> districts = [];
  bool _isRegionsLoaded = false;
  bool _isCitiesLoaded = false;
  bool _isDistrictsLoaded = false;
  //
}
