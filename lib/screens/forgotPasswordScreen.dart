import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/otpVerificationScreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constansts.dart';

class ForgotPasswordScreen extends BaseRoute {
  ForgotPasswordScreen({a, o}) : super(a: a, o: o, r: 'ForgotPasswordScreen');
  @override
  _ForgotPasswordScreenState createState() => new _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;

  TextEditingController _cPhone = new TextEditingController();
  FocusNode _fPhone = new FocusNode();
  _ForgotPasswordScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: sc(Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            child: Column(
              children: [
                Text(AppLocalizations.of(context)?.txt_forgot_password ?? '',
                    style: Theme.of(context).primaryTextTheme.bodySmall),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                      AppLocalizations.of(context)
                              ?.txt_please_enter_your_email_so_we_can_help_you_to_recover_your_password ??
                          '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.displaySmall),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      autofocus: false,
                      cursorColor: Color(0xFFF36D86),
                      enabled: true,
                      style: Theme.of(context).primaryTextTheme.titleLarge,
                      controller: _cPhone,
                      focusNode: _fPhone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: 'أدخل رقم هاتفك'),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                    )),
                Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20),
                    child: TextButton(
                        onPressed: () {
                          _forgotPassword();
                        },
                        child: Text(AppLocalizations.of(context)!.btn_send))),
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _sendOTP(String phoneNumber) async {
    print('....phone....:+$phoneCode$phoneNumber');
    try {
      print('done....phone....:$phoneCode$phoneNumber');
      FirebaseAuth.instance.setSettings(forceRecaptchaFlow: true);

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$phoneCode$phoneNumber',
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
                      // a: widget.analytics,
                      // o: widget.observer,
                      verificationId: verificationId,
                      phoneNumberOrEmail: phoneNumber,
                      screenId: 2,
                    )),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("Exception - OTP - _sendOTP():" + e.toString());
    }
  }

  _forgotPassword() async {
    try {
      if (_cPhone.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.forgotPassword(_cPhone.text.trim()).then((result) {
            if (result != null) {
              if (result.status == "1") {
                hideLoader();
                _sendOTP(_cPhone.text);
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //       builder: (context) => OTPVerificationScreen(
                //             a: widget.analytics,
                //             o: widget.observer,
                //             screenId: 2,
                //             phoneNumberOrEmail: _cPhone.text,
                //           )),
                // );

                setState(() {});
              } else {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cPhone.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context)!.txt_please_enter_your_email);
      } else if (_cPhone.text.isNotEmpty &&
          !EmailValidator.validate(_cPhone.text)) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: AppLocalizations.of(context)!
                .txt_please_enter_your_valid_email);
      }
    } catch (e) {
      print("Exception - forgotPasswordScreen.dart - _forgotPassword():" +
          e.toString());
    }
  }
}
