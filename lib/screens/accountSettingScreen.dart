import 'dart:convert';
import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/businessRule.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              Align(
                  alignment: global.isRTL
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(
                      'البريد الالكتروني',
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
                    controller: _cEmail,
                    focusNode: _fEmail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'البريد الالكتروني',
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
  }

  _init() {
    try {
      _cName.text = global.user!.name!;
      _cEmail.text = global.user!.email!;
      _cMobile.text = global.user!.user_phone!;
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
      if (_cPassword.text.isNotEmpty &&
          _cPassword.text.trim().length >= 8 &&
          _cConfirmPassword.text.isNotEmpty &&
          _cPassword.text.trim() == _cConfirmPassword.text.trim()) {
      } else if (_cPassword.text.isNotEmpty &&
          _cPassword.text.trim().length < 8) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: 'كلمة المرور يجب  ان تكون اكبر من 8 حروق و ارقام');
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
}
