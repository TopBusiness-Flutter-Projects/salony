import 'dart:async';
import 'dart:convert';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/businessRule.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/screens/cookiesPolicyScreen.dart';
import 'package:app/screens/exploreScreen.dart';
import 'package:app/screens/privacyAndPolicy.dart';
import 'package:app/screens/resetPasswordScreen.dart';
import 'package:app/screens/termsOfServicesScreen.dart';
import 'package:app/widgets/bottomNavigationWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPVerificationScreen extends BaseRoute {
  final int? screenId;
  final String? verificationId;
  final String? phoneNumberOrEmail;
  OTPVerificationScreen({a, o, this.screenId, this.verificationId, this.phoneNumberOrEmail}) : super(a: a, o: o, r: 'OTPVerificationScreen');
  @override
  _OTPVerificationScreenState createState() => new _OTPVerificationScreenState(screenId: screenId, verificationId: verificationId, phoneNumberOrEmail: this.phoneNumberOrEmail);
}

class _OTPVerificationScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  String? phoneNumberOrEmail;
  String? verificationId;
  int _seconds = 60;
  late Timer _countDown;
  var _cCode = new TextEditingController();
  String? status;
  int? screenId;
  late BusinessRule br;
  _OTPVerificationScreenState({this.screenId, this.verificationId, this.phoneNumberOrEmail}) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: sc(Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: screenId == 2
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                  child: Column(
                    children: [
                      Text(
                        'Verifying OTP',
                        style: Theme.of(context).primaryTextTheme.caption,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Enter the verification code from the email we just sent you.',
                          style: Theme.of(context).primaryTextTheme.headline3,
                        ),
                      ),
                      PinFieldAutoFill(
                        key: Key("1"),
                        decoration:
                            BoxLooseDecoration(textStyle: TextStyle(fontSize: 20, color: Colors.black), strokeColorBuilder: FixedColorBuilder(Colors.transparent), bgColorBuilder: FixedColorBuilder(Colors.grey[100]!), hintText: '••••••', hintTextStyle: TextStyle(fontSize: 70, color: Colors.black)),
                        currentCode: _cCode.text,
                        controller: _cCode,
                        codeLength: 6,
                        keyboardType: TextInputType.number,
                        onCodeSubmitted: (code) {
                          setState(() {
                            _cCode.text = code;
                          });
                        },
                        onCodeChanged: (code) async {
                          if (code!.length == 6) {
                            _cCode.text = code;
                            setState(() {});
                            FocusScope.of(context).requestFocus(FocusNode());
                            _verifyForgotPasswordOtp();
                          }
                        },
                      ),
                      Container(
                          height: 50,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10),
                          child: TextButton(
                              onPressed: () async {
                                _verifyForgotPasswordOtp();
                              },
                              child: Text('Verify'))),
                      Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('By tapping verification code above, you agree ', style: Theme.of(context).primaryTextTheme.subtitle1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('to the ', style: Theme.of(context).primaryTextTheme.subtitle1),
                                    InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => TermsOfServices(a: widget.analytics, o: widget.observer)),
                                          );
                                        },
                                        child: Text('Terms of Services,', style: Theme.of(context).primaryTextTheme.subtitle2)),
                                    InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => PrivacyAndPolicy(a: widget.analytics, o: widget.observer)),
                                          );
                                        },
                                        child: Text('  privacy policy', style: Theme.of(context).primaryTextTheme.subtitle2)),
                                    Text(' and', style: Theme.of(context).primaryTextTheme.subtitle1),
                                  ],
                                ),
                                InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => CookiesPolicy(a: widget.analytics, o: widget.observer)),
                                      );
                                    },
                                    child: Text(' cookies policy.', style: Theme.of(context).primaryTextTheme.subtitle2))
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                  child: Column(
                    children: [
                      Text(
                        'Verifying Number',
                        style: Theme.of(context).primaryTextTheme.caption,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Enter the verification code from the phone we just sent you.',
                          style: Theme.of(context).primaryTextTheme.headline3,
                        ),
                      ),
                      PinFieldAutoFill(
                        key: Key("1"),
                        decoration:
                            BoxLooseDecoration(textStyle: TextStyle(fontSize: 20, color: Colors.black), strokeColorBuilder: FixedColorBuilder(Colors.transparent), bgColorBuilder: FixedColorBuilder(Colors.grey[100]!), hintText: '••••••', hintTextStyle: TextStyle(fontSize: 70, color: Colors.black)),
                        currentCode: _cCode.text,
                        controller: _cCode,
                        codeLength: 6,
                        keyboardType: TextInputType.number,
                        onCodeSubmitted: (code) {
                          setState(() {
                            _cCode.text = code;
                          });
                        },
                        onCodeChanged: (code) async {
                          if (code!.length == 6) {
                            _cCode.text = code;
                            setState(() {});
                            await _checkOTP(_cCode.text);
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () async {
                                await _getOTP(phoneNumberOrEmail);
                              },
                              child: Text(_seconds != 0 ? 'Resend code 0:$_seconds' : 'Resend OTP', style: Theme.of(context).primaryTextTheme.headline5))),
                      Container(
                          height: 50,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10),
                          child: TextButton(
                              onPressed: () async {
                                _checkSecurityPin();
                              },
                              child: Text('Verify'))),
                      Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('By tapping verification code above, you agree ', style: Theme.of(context).primaryTextTheme.subtitle1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('to the ', style: Theme.of(context).primaryTextTheme.subtitle1),
                                    InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => TermsOfServices(a: widget.analytics, o: widget.observer)),
                                          );
                                        },
                                        child: Text('Terms of Services,', style: Theme.of(context).primaryTextTheme.subtitle2)),
                                    InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => PrivacyAndPolicy(a: widget.analytics, o: widget.observer)),
                                          );
                                        },
                                        child: Text('  privacy policy', style: Theme.of(context).primaryTextTheme.subtitle2)),
                                    Text(' and', style: Theme.of(context).primaryTextTheme.subtitle1),
                                  ],
                                ),
                                InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => CookiesPolicy(a: widget.analytics, o: widget.observer)),
                                      );
                                    },
                                    child: Text(' cookies policy.', style: Theme.of(context).primaryTextTheme.subtitle2))
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SmsAutoFill().unregisterListener();
  }

  @override
  void initState() {
    super.initState();
    OTPInteractor().getAppSignature()
        //ignore: avoid_print
        .then((value) => print('signature - $value'));
    _cCode = OTPTextEditController(
      codeLength: 6,
      //ignore: avoid_print
      onCodeReceive: (code) {
        setState(() {
          _cCode.text = code;
        });
      },
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [],
      );
    _init();
    startTimer();
  }

  Future startTimer() async {
    try {
      setState(() {});
      const oneSec = const Duration(seconds: 1);
      _countDown = new Timer.periodic(
        oneSec,
        (timer) {
          if (_seconds == 0) {
            setState(() {
              _countDown.cancel();
              timer.cancel();
            });
          } else {
            setState(() {
              _seconds--;
            });
          }
        },
      );

      setState(() {});
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - startTimer():" + e.toString());
    }
  }

  Future _checkOTP(String otp) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      var _credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: otp.trim());
      showOnlyLoaderDialog();
      await auth.signInWithCredential(_credential).then((result) {
        status = 'success';
        hideLoader();

        _verifyOtp(status);
      }).catchError((e) {
        status = 'failed';
        hideLoader();

        _verifyOtp(status);
      }).onError((dynamic error, stackTrace) {
        hideLoader();
      });
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _checkOTP():" + e.toString());
    }
  }

  _checkSecurityPin() async {
    try {
      if (_cCode.text.length == 6) {
        await _checkOTP(_cCode.text);
      } else {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enter 6 digit otp');
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _checkSecurityPin() : " + e.toString());
    }
  }

  Future _getOTP(String? mobileNumber) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.verifyPhoneNumber(
        phoneNumber: '+92$mobileNumber',
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) async {
          setState(() {});
        },
        verificationFailed: (authException) {},
        codeSent: (String verificationId, [int? forceResendingToken]) async {
          _cCode.clear();
          _seconds = 60;
          startTimer();
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        },
      );
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _getOTP():" + e.toString());
      return null;
    }
  }

  _init() async {
    try {
      SmsAutoFill().listenForCode;
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _init():" + e.toString());
    }
  }

  _verifyForgotPasswordOtp() async {
    try {
      if (_cCode.text.length == 6) {
        showOnlyLoaderDialog();
        await apiHelper!.verifyOtpForgotPassword(phoneNumberOrEmail, _cCode.text).then((result) {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ResetPasswordScreen(
                          phoneNumberOrEmail,
                          a: widget.analytics,
                          o: widget.observer,
                        )),
              );
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
              setState(() {});
            }
          }
        });
      } else {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enter 6 digit OTP');
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _verifyForgotPasswordOtp():" + e.toString());
    }
  }

  _verifyOtp(String? _status) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (screenId == 1) {
          showOnlyLoaderDialog();
          await apiHelper!.verifyOtpAfterLogin(phoneNumberOrEmail, _status, global.appDeviceId).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                global.user = result.recordList;
                global.sp.setString('currentUser', json.encode(global.user!.toJson()));

                await getCurrentPosition().then((_) async {
                  if (global.lat != null && global.lng != null) {
                    hideLoader();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationWidget(
                                a: widget.analytics,
                                o: widget.observer,
                              )),
                    );
                  } else {
                    hideLoader();
                    showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enable location permission to use this App');
                  }
                });
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            } else {
              hideLoader();
            }
          }).catchError((e) {});
        } else {
          showOnlyLoaderDialog();
          await apiHelper!.verifyOtpAfterRegistration(phoneNumberOrEmail, _status, null, global.appDeviceId).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                global.user = result.recordList;
                global.sp.setString('currentUser', json.encode(global.user!.toJson()));

                await getCurrentPosition().then((_) async {
                  if (global.lat != null && global.lng != null) {
                    hideLoader();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExploreScreen(a: widget.analytics, o: widget.observer)),
                    );
                  } else {
                    hideLoader();
                    showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enable location permission to use this App');
                  }
                });
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            } else {
              hideLoader();
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _verifyOtp():" + e.toString());
    }
  }
}
