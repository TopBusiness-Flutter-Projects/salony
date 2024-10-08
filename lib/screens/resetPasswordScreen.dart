import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPasswordScreen extends BaseRoute {
  final String? email;
  ResetPasswordScreen(this.email, {a, o})
      : super(a: a, o: o, r: 'ResetPasswordScreen');
  @override
  _ResetPasswordScreenState createState() =>
      new _ResetPasswordScreenState(this.email);
}

class _ResetPasswordScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TextEditingController _cNewPassword = new TextEditingController();
  TextEditingController _cConfirmPassword = new TextEditingController();
  FocusNode _fNewPassword = new FocusNode();
  FocusNode _fConfirmPassword = new FocusNode();
  String? email;
  _ResetPasswordScreenState(this.email) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: sc(Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            child: Column(
              children: [
                Text(
                  'إعادة تعيين كلمة المرور',
                  style: Theme.of(context).primaryTextTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                      "الرجاء إدخال كلمة المرور حتى نتمكن من مساعدتك في استعادة كلمة المرور الخاصة بك.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.headline3),
                ),
                Container(
                    margin: EdgeInsets.only(top: 70),
                    height: 50,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      autofocus: false,
                      cursorColor: Color(0xFFF36D86),
                      enabled: true,
                      style: Theme.of(context).primaryTextTheme.headline6,
                      controller: _cNewPassword,
                      focusNode: _fNewPassword,
                      decoration:
                          InputDecoration(hintText: 'كلمة المرور الجديدة'),
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
                      cursorColor: Color(0xFFF36D86),
                      enabled: true,
                      style: Theme.of(context).primaryTextTheme.headline6,
                      controller: _cConfirmPassword,
                      focusNode: _fConfirmPassword,
                      decoration:
                          InputDecoration(hintText: 'تأكيد كلمة المرور '),
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
                          _changePassword();
                        },
                        child: Text("إعادة تعيين كلمة المرور"))),
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
  }

  @override
  void initState() {
    super.initState();
  }

  _changePassword() async {
    try {
      if (_cNewPassword.text.isNotEmpty &&
          _cNewPassword.text.trim().length >= 8 &&
          _cConfirmPassword.text.isNotEmpty &&
          _cNewPassword.text.trim() == _cConfirmPassword.text.trim()) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!
              .changePassword(email, _cNewPassword.text.trim())
              .then((result) {
            if (result != null) {
              if (result.status == "1") {
                hideLoader();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => SignInScreen(
                            // a: widget.analytics,
                            // o: widget.observer,
                          )),
                );
                Fluttertoast.showToast(
                    msg: 'تم تغير كلمة المرور بنجاح. قم بتسجيل الدخول الان!');
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
      } else if (_cNewPassword.text.isEmpty ||
          _cNewPassword.text.trim().length < 8) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: 'Password should be of minimun 8 characters');
      } else if (_cConfirmPassword.text.isEmpty ||
          _cConfirmPassword.text.trim() != _cNewPassword.text.trim()) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'Passwords do not match');
      }
    } catch (e) {
      print("Exception - resetPasswordScreen.dart - _changePassword():" +
          e.toString());
    }
  }
}
