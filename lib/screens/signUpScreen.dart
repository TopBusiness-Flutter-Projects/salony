import 'dart:io';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/userModel.dart';
import 'package:app/screens/otpVerificationScreen.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:app/screens/termsOfServicesScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  bool _isConfirmPasswordVisible = false;
  _SignUpScreenState({this.email, this.fbId, this.name, this.appleId})
      : super();

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
                        // Stack(
                        //   alignment: Alignment.bottomRight,
                        //   children: [
                        //     _tImage != null
                        //         ? CircleAvatar(
                        //             radius: 32,
                        //             child: ClipRRect(
                        //                 borderRadius: BorderRadius.circular(32),
                        //                 child: Image.file(_tImage!)),
                        //           )
                        //         : global.user!.image != null
                        //             ? CachedNetworkImage(
                        //                 imageUrl: global.baseUrlForImage +
                        //                     global.user!.image!,
                        //                 imageBuilder: (context, imageProvider) =>
                        //                     CircleAvatar(
                        //                         radius: 32,
                        //                         backgroundImage: imageProvider),
                        //                 placeholder: (context, url) => Center(
                        //                     child: CircularProgressIndicator()),
                        //                 errorWidget: (context, url, error) =>
                        //                     Icon(Icons.error),
                        //               )
                        //             : CircleAvatar(
                        //                 radius: 24,
                        //                 child: Icon(Icons.person),
                        //                 backgroundColor: Colors.white,
                        //               ),
                        //     CircleAvatar(
                        //       radius: 32,
                        //       child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(32),
                        //           child: _tImage == null
                        //               ? CircleAvatar(
                        //                   radius: 30,
                        //                   child: Icon(Icons.person),
                        //                   backgroundColor: Colors.white,
                        //                 )
                        //               : Image.file(
                        //                   _tImage ?? File(''),
                        //                   errorBuilder:
                        //                       (context, error, stackTrace) {
                        //                     return CircleAvatar(
                        //                       radius: 24,
                        //                       child: Icon(Icons.add),
                        //                       backgroundColor: Colors.white,
                        //                     );
                        //                   },
                        //                 )),
                        //     ),
                        //     Positioned(
                        //         top: 30,
                        //         left: 30,
                        //         child: IconButton(
                        //             padding: EdgeInsets.all(0),
                        //             onPressed: () {
                        //               _showCupertinoModalSheet();
                        //               setState(() {});
                        //             },
                        //             icon: Container(
                        //                 padding: EdgeInsets.all(0),
                        //                 margin: EdgeInsets.all(0),
                        //                 decoration: BoxDecoration(
                        //                     color: Color(0xFFF36D86),
                        //                     borderRadius:
                        //                         BorderRadius.circular(34)),
                        //                 child: Icon(
                        //                   Icons.add,
                        //                   color: Colors.white,
                        //                   size: 20,
                        //                 ))))
                        //   ],
                        // )
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
                    // Container(
                    //     margin: EdgeInsets.only(top: 15),
                    //     height: 50,
                    //     child: TextFormField(
                    //       textAlign: TextAlign.start,
                    //       autofocus: false,
                    //       cursorColor: Color(0xFFF36D86),
                    //       enabled: true,
                    //       style: Theme.of(context).primaryTextTheme.headline6,
                    //       controller: _cReferralCode,
                    //       focusNode: _fReferralCode,
                    //       decoration: InputDecoration(
                    //           hintText:
                    //               AppLocalizations.of(context)!.lbl_referral_code),
                    //       onEditingComplete: () {
                    //         FocusScope.of(context).unfocus();
                    //       },
                    //     )),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 40),
                    //   child: GestureDetector(
                    //       onTap: () {
                    //         _isAgree = !_isAgree;
                    //         setState(() {});
                    //       },
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.check_circle,
                    //             size: 20,
                    //             color: _isAgree
                    //                 ? Color(0xFFF36D86)
                    //                 : Color(0xFF898A8D),
                    //           ),
                    //           Padding(
                    //               padding: const EdgeInsets.only(left: 5),
                    //               child: Wrap(
                    //                 children: [
                    //                   Text(
                    //                     AppLocalizations.of(context)!
                    //                         .txt_i_agree_to_the,
                    //                     style: Theme.of(context)
                    //                         .primaryTextTheme
                    //                         .subtitle1,
                    //                   ),
                    //                   InkWell(
                    //                       splashColor: Colors.transparent,
                    //                       highlightColor: Colors.transparent,
                    //                       overlayColor: MaterialStateProperty.all(
                    //                           Colors.transparent),
                    //                       onTap: () {
                    //                         Navigator.of(context).push(
                    //                           MaterialPageRoute(
                    //                               builder: (context) =>
                    //                                   TermsOfServices(
                    //                                       a: widget.analytics,
                    //                                       o: widget.observer)),
                    //                         );
                    //                       },
                    //                       child: Text(
                    //                           AppLocalizations.of(context)!
                    //                               .txt_term_of_services,
                    //                           style: Theme.of(context)
                    //                               .primaryTextTheme
                    //                               .subtitle2))
                    //                 ],
                    //               ))
                    //         ],
                    //       )),
                    // ),
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

  // _showCupertinoModalSheet() {
  //   try {
  //     showCupertinoModalPopup(
  //       context: context,
  //       builder: (BuildContext context) => CupertinoActionSheet(
  //         title: Text(AppLocalizations.of(context)!.lbl_actions),
  //         actions: [
  //           CupertinoActionSheetAction(
  //             child: Text(AppLocalizations.of(context)!.lbl_take_picture,
  //                 style: TextStyle(color: Color(0xFF171D2C))),
  //             onPressed: () async {
  //               Navigator.pop(context);
  //               showOnlyLoaderDialog();
  //               _tImage = await br.openCamera();
  //               hideLoader();

  //               setState(() {});
  //             },
  //           ),
  //           CupertinoActionSheetAction(
  //             child: Text(AppLocalizations.of(context)!.lbl_choose_from_library,
  //                 style: TextStyle(color: Color(0xFF171D2C))),
  //             onPressed: () async {
  //               Navigator.pop(context);
  //               showOnlyLoaderDialog();
  //               _tImage = await br.selectImageFromGallery();
  //               hideLoader();

  //               setState(() {});
  //             },
  //           )
  //         ],
  //         cancelButton: CupertinoActionSheetAction(
  //           child: Text(AppLocalizations.of(context)!.lbl_cancelled
  //               style: TextStyle(color: Color(0xFFF36D86))),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     print("Exception - signUpScreen.dart - _showCupertinoModalSheet():" +
  //         e.toString());
  //   }
  // }

  _signUp() async {
    try {
      CurrentUser _user = new CurrentUser();
      if (appleId != null) {
        _user.apple_id = appleId;
      }

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
          _cPassword.text.trim() == _cConfirmPassword.text.trim()) {
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
}
