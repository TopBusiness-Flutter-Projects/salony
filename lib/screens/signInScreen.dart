import 'dart:convert';
import 'dart:core';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/userModel.dart';
import 'package:app/screens/forgotPasswordScreen.dart';
import 'package:app/screens/signUpScreen.dart';
import 'package:app/widgets/bottomNavigationWidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

//okay
class SignInScreen extends BaseRoute {
  SignInScreen({a, o}) : super(a: a, o: o, r: 'SignInScreen');
  @override
  _SignInScreenState createState() => new _SignInScreenState();
}

class _SignInScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TextEditingController _cPhone = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  FocusNode _fEmail = new FocusNode();
  FocusNode _fPassword = new FocusNode();
  bool _isRemember = false;
  String? phoneCodeintl = '+20';
  bool _isPasswordVisible = false;
  // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  _SignInScreenState() : super();
  final int _phoneNumberLength = 11;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitAppDialog().then((value) => value as bool);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: sc(Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => BottomNavigationWidget(
                                    // a: widget.analytics,
                                    // o: widget.observer,
                                    )),
                          ); //!
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFF36D86),
                                )),
                            child: Text(
                              'تخطي',
                              style: TextStyle(
                                color: Color(0xFF164863),
                                fontSize: 18,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            )),
                      ),
                    ),

                    SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //     '',
                    //       style: Theme.of(context).primaryTextTheme.headline4,
                    //     ),
                    //     ElevatedButton(
                    //         style: ButtonStyle(
                    //             elevation: MaterialStateProperty.all(0),
                    //             backgroundColor: MaterialStateProperty.all(
                    //                 Colors.transparent)),
                    //         onPressed: () async {
                    //           showOnlyLoaderDialog();
                    //           await getCurrentPosition().then((_) async {
                    //             if (global.lat != null && global.lng != null) {
                    //               global.user = new CurrentUser();
                    //               hideLoader();
                    //               Navigator.of(context).push(
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         ChooseLanguageScreen(
                    //                           a: widget.analytics,
                    //                           o: widget.observer,
                    //                         )),
                    //               );
                    //             } else {
                    //               hideLoader();
                    //               showSnackBar(
                    //                   key: _scaffoldKey,
                    //                   snackBarMessage: AppLocalizations.of(
                    //                           context)!
                    //                       .txt_please_enablet_location_permission_to_use_app);
                    //             }
                    //           });
                    //         },
                    //         child: Text(
                    //           AppLocalizations.of(context)!.lbl_skip,
                    //           style: Theme.of(context).primaryTextTheme.headlineSmall,
                    //         ))
                    //   ],
                    // ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ' تسجيل الدخول ',
                          style: TextStyle(
                            color: Color(0xFF164863),
                            fontSize: 18,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        )),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'يمكنك تسجيل الدخول الان',
                        style: TextStyle(
                          color: Color(0xFF164863),
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    IntlPhoneField(
                      decoration: InputDecoration(hintText: 'رقم الجوال'),
                      controller: _cPhone,                        showCountryFlag: false,

                      initialCountryCode: 'EG',
                      onCountryChanged: (country) {
                          phoneCodeintl = '+' + country.fullCountryCode;
                        print("sssssssssssss$phoneCodeintl");

                        print(phoneCodeintl);
                      },
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                      textAlign: TextAlign.start,
                      autofocus: false,
                      cursorColor: Color(0xFFF36D86),
                      enabled: true,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).primaryTextTheme.headline6,
                      focusNode: _fEmail,
                    ),
                    // Container(
                    //     margin: EdgeInsets.only(top: 60),
                    //     height: 50,
                    //     child: TextFormField(
                    //       textAlign: TextAlign.start,
                    //       autofocus: false,
                    //       cursorColor: Color(0xFFF36D86),
                    //       enabled: true,
                    //       style: TextStyle(
                    //         color: Color(0xFFA6A6A6),
                    //         fontSize: 16,
                    //         fontFamily: 'Cairo',
                    //         fontWeight: FontWeight.w400,
                    //         height: 0,
                    //       ),
                    //       controller: _cPhone,
                    //       focusNode: _fEmail,
                    //       keyboardType: TextInputType.phone,
                    //       inputFormatters: [
                    //         FilteringTextInputFormatter.digitsOnly,
                    //         LengthLimitingTextInputFormatter(
                    //             _phoneNumberLength),
                    //       ],
                    //       onEditingComplete: () {
                    //         _fPassword.requestFocus();
                    //       },
                    //       decoration: InputDecoration(hintText: 'رقم الجوال'),
                    //     )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          autofocus: false,
                          cursorColor: Color(0xFFF36D86),
                          enabled: true,
                          style: TextStyle(
                            color: Color(0xFFA6A6A6),
                            fontSize: 16,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                          controller: _cPassword,
                          focusNode: _fPassword,
                          obscureText: !_isPasswordVisible,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                          },
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
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()),
                                );
                              },
                              child: Text(
                                'نسيت كلمة المرور',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFFF36D86),
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 50),
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(alignment: Alignment.center),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _loginWithEmail();
                          },
                          child: SizedBox(
                            child: Text(
                              'تسجيل الدخول',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        )),
                    // GestureDetector(
                    //     onTap: () {
                    //       FocusScope.of(context).unfocus();
                    //
                    //       if (_isRemember) {
                    //         global.sp.remove('isRememberMeEmail');
                    //       }
                    //       _isRemember = !_isRemember;
                    //       setState(() {});
                    //     },
                    //     child: Row(
                    //       children: [
                    //         Icon(
                    //           Icons.check_circle,
                    //           size: 20,
                    //           color: _isRemember
                    //               ? Color(0xFFF36D86)
                    //               : Color(0xFF898A8D),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(left: 5),
                    //           child: Text(
                    //             AppLocalizations.of(context)!
                    //                 .lbl_remember_me,
                    //             style: Theme.of(context)
                    //                 .primaryTextTheme
                    //                 .titleMedium,
                    //           ),
                    //         )
                    //       ],
                    //     )),
                    ///a
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 60),
                    //   child: Text(
                    //       AppLocalizations.of(context)!
                    //           .txt_or_Connect_with_social_account,
                    //       style: Theme.of(context).primaryTextTheme.titleMedium),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 10),
                    //   height: 50,
                    //   width: double.infinity,
                    //   child: TextButton(
                    //       onPressed: () async {
                    //         FocusScope.of(context).unfocus();
                    //         Navigator.of(context).push(MaterialPageRoute(
                    //             builder: (context) => AddPhoneScreen(
                    //                 a: widget.analytics, o: widget.observer)));
                    //         PermissionStatus permissionStatus =
                    //             await Permission.phone.status;
                    //         if (!permissionStatus.isGranted) {
                    //           permissionStatus = await Permission.phone.request();
                    //         }
                    //       },
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           Icon(Icons.phone_outlined),
                    //           Text(AppLocalizations.of(context)!
                    //               .btn_connect_with_phone_number),
                    //           Icon(
                    //             Icons.phone,
                    //             color: Colors.transparent,
                    //           ),
                    //         ],
                    //       )),
                    // ),
                    //
                    // Platform.isIOS
                    //     ? Container(
                    //         height: 50,
                    //         width: double.infinity,
                    //         margin: EdgeInsets.only(top: 10),
                    //         child: TextButton(
                    //             style: ButtonStyle(
                    //                 textStyle: MaterialStateProperty.all(
                    //                     TextStyle(
                    //                         fontSize: 15,
                    //                         color: Colors.white,
                    //                         letterSpacing: 1,
                    //                         fontWeight: FontWeight.w400)),
                    //                 backgroundColor: MaterialStateProperty.all(
                    //                   Colors.black,
                    //                 )),
                    //             onPressed: () {
                    //               _signInWithApple();
                    //             },
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               children: [
                    //                 Padding(
                    //                     padding: EdgeInsets.only(right: 5),
                    //                     child: Icon(MdiIcons.apple)),
                    //                 Text('Sign in with Apple'),
                    //                 Icon(
                    //                   MdiIcons.apple,
                    //                   color: Colors.transparent,
                    //                 ),
                    //               ],
                    //             )))
                    //     : SizedBox(),

                    // Container(
                    //     height: 50,
                    //     width: double.infinity,
                    //     margin: EdgeInsets.only(top: 10),
                    //     child: TextButton(
                    //         style: ButtonStyle(
                    //             textStyle: MaterialStateProperty.all(TextStyle(
                    //                 fontSize: 15,
                    //                 color: Colors.white,
                    //                 letterSpacing: 1,
                    //                 fontWeight: FontWeight.w400)),
                    //             backgroundColor:
                    //                 MaterialStateProperty.all(Color(0xFF3B5999))),
                    //         onPressed: () {
                    //           FocusScope.of(context).unfocus();
                    //           _signInWithFacebook();
                    //         },
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Icon(FontAwesomeIcons.facebook),
                    //             Text(AppLocalizations.of(context)!
                    //                 .btn_sign_in_with_facebook),
                    //             Icon(
                    //               MdiIcons.facebook,
                    //               color: Colors.transparent,
                    //             ),
                    //           ],
                    //         ))),
                    // Container(
                    //     height: 50,
                    //     width: double.infinity,
                    //     margin: EdgeInsets.only(top: 10),
                    //     child: TextButton(
                    //         style: ButtonStyle(
                    //             textStyle: MaterialStateProperty.all(TextStyle(
                    //                 fontSize: 15,
                    //                 color: Colors.white,
                    //                 letterSpacing: 1,
                    //                 fontWeight: FontWeight.w400)),
                    //             backgroundColor:
                    //                 MaterialStateProperty.all(Color(0xFFE94235))),
                    //         onPressed: () {
                    //           FocusScope.of(context).unfocus();
                    //           _signInWithGoogle();
                    //         },
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Icon(MdiIcons.google),
                    //             Text(AppLocalizations.of(context)!
                    //                 .btn_sign_in_with_google),
                    //             Icon(
                    //               Icons.facebook_outlined,
                    //               color: Colors.transparent,
                    //             ),
                    //           ],
                    //         ))),

                    Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 3.5,
                            bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' ليس لديك حساب معنا ؟',
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
                                        builder: (context) => SignUpScreen()),
                                  );
                                },
                                child: Text(
                                  ' انشاء حساب',
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
                ),
              ),
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
        )),
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
    // _init();
  }

  _loginWithEmail() async {
    try {
      CurrentUser _user = new CurrentUser();
      _user.user_email = _cPhone.text.trim();
      _user.user_password = _cPassword.text.trim();
      _user.device_id = global.appDeviceId;

      if (_cPhone.text.isNotEmpty && _cPassword.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!
              .loginWithEmail(
                  _cPhone.text, _cPassword.text, global.appDeviceId ?? '0')
              .then((result) async {
            if (result != null) {
              if (result.status == "1") {
                print("result.status");
                global.user = result.recordList;
                global.sp.setString(
                    "currentUser", json.encode(global.user!.toJson()));
                hideLoader();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationWidget(
                          // a: widget.analytics,
                          // o: widget.observer,
                          )),
                );
                // await getCurrentPosition().then((_) async {
                //   if (global.lat != null && global.lng != null) {
                //   } else {
                //     hideLoader();
                //     showSnackBar(
                //         key: _scaffoldKey,
                //         snackBarMessage: AppLocalizations.of(context)!
                //             .txt_please_enablet_location_permission_to_use_app);
                //   }
                // });
              } else {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            } else {
              hideLoader();
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      }
      if (_cPhone.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'ادخل رقم الجوال');
      } else if (_cPassword.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'ادخل كلمة المرور');
      }
    } catch (e) {
      print(
          "Exception - signInScreen.dart - _loginWithEmail():" + e.toString());
    }
  }

  // _signInWithApple() async {
  //   try {
  //     bool isConnected = await br.checkConnectivity();
  //     if (isConnected) {
  //       showOnlyLoaderDialog();

  //       final _firebaseAuth = FirebaseAuth.instance;

  //       String generateNonce([int length = 32]) {
  //         final charset =
  //             '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  //         final random = Random.secure();
  //         return List.generate(
  //             length, (_) => charset[random.nextInt(charset.length)]).join();
  //       }

  //       String sha256ofString(String input) {
  //         final bytes = utf8.encode(input);
  //         final digest = sha256.convert(bytes);
  //         return digest.toString();
  //       }

  //       final rawNonce = generateNonce();
  //       final nonce = sha256ofString(rawNonce);
  //       final credential = await SignInWithApple.getAppleIDCredential(
  //         scopes: [
  //           AppleIDAuthorizationScopes.email,
  //           AppleIDAuthorizationScopes.fullName,
  //         ],
  //         nonce: nonce,
  //       ).catchError((e) {
  //         hideLoader();
  //       });
  //       final oauthCredential = OAuthProvider("apple.com").credential(
  //         idToken: credential.identityToken,
  //         rawNonce: rawNonce,
  //       );
  //       final UserCredential? authResult = await _firebaseAuth
  //           .signInWithCredential(oauthCredential)
  //           .onError((dynamic error, stackTrace) {
  //         hideLoader();
  //         throw Future.error(error);
  //       }).catchError((e) {
  //         hideLoader();
  //       });
  //       await apiHelper!
  //           .socialLogin(
  //               email_id: credential.email != null ? credential.email : null,
  //               type: "apple",
  //               apple_id: authResult?.user?.uid)
  //           .then((result) async {
  //         if (result != null) {
  //           if (result.status == "1") {
  //             global.user = result.recordList;
  //             global.sp
  //                 .setString('currentUser', json.encode(global.user!.toJson()));

  //             await getCurrentPosition().then((_) async {
  //               if (global.lat != null && global.lng != null) {
  //                 hideLoader();
  //                 Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                       builder: (context) => BottomNavigationWidget(
  //                             a: widget.analytics,
  //                             o: widget.observer,
  //                           )),
  //                 );
  //               } else {
  //                 hideLoader();
  //                 showSnackBar(
  //                     key: _scaffoldKey,
  //                     snackBarMessage: AppLocalizations.of(context)!
  //                         .txt_please_enablet_location_permission_to_use_app);
  //               }
  //             });
  //           } else if (result.status == "4") {
  //             hideLoader();
  //             Navigator.of(context).push(
  //               MaterialPageRoute(
  //                   builder: (context) => SignUpScreen(
  //                         a: widget.analytics,
  //                         o: widget.observer,
  //                         email: credential.email,
  //                         appleId: authResult?.user?.uid,
  //                       )),
  //             );
  //           }
  //         }
  //       });
  //     } else {
  //       showNetworkErrorSnackBar(_scaffoldKey);
  //     }
  //   } catch (e) {
  //     print(
  //         "Exception - signInScreen.dart - _signinWithApple():" + e.toString());
  //   }
  // }

  // _signInWithFacebook() async {
  //   try {
  //     bool isConnected = await br.checkConnectivity();
  //     if (isConnected) {
  //       final LoginResult loginResult = await FacebookAuth.instance
  //           .login(permissions: ["email", "public_profile", "user_friends"]);

  //       final OAuthCredential facebookAuthCredential =
  //           FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //       var authCredentials =
  //           FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //       await apiHelper!
  //           .socialLogin(
  //               email_id: _googleSignIn.currentUser!.email,
  //               facebook_id: '',
  //               type: "facebook")
  //           .then((result) async {
  //         if (result != null) {
  //           if (result.status == "1") {
  //             global.user = result.recordList;
  //             global.sp
  //                 .setString('currentUser', json.encode(global.user!.toJson()));
  //             await getCurrentPosition().then((_) async {
  //               if (global.lat != null && global.lng != null) {
  //                 hideLoader();
  //                 Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                       builder: (context) => BottomNavigationWidget(
  //                             a: widget.analytics,
  //                             o: widget.observer,
  //                           )),
  //                 );
  //               } else {
  //                 hideLoader();
  //                 showSnackBar(
  //                     key: _scaffoldKey,
  //                     snackBarMessage: AppLocalizations.of(context)!
  //                         .txt_please_enablet_location_permission_to_use_app);
  //               }
  //             });
  //           } else if (result.status == "3") {
  //             hideLoader();
  //             Navigator.of(context).push(
  //               MaterialPageRoute(
  //                   builder: (context) => SignUpScreen(
  //                         a: widget.analytics,
  //                         o: widget.observer,
  //                         fbId: '',
  //                       )),
  //             );
  //           }
  //         }
  //       });
  //     } else {
  //       showNetworkErrorSnackBar(_scaffoldKey);
  //     }
  //   } catch (e) {
  //     print("Exception - signInScreen.dart - _signInWithFacebook():" +
  //         e.toString());
  //   }
  // }

  // _signInWithGoogle() async {
  //   try {
  //     bool isConnected = await br.checkConnectivity();
  //     if (isConnected) {
  //       showOnlyLoaderDialog();
  //       await _googleSignIn.signIn().then((value) async {
  //         if (value != null) {
  //           await value.authentication.then((value1) async {
  //             await apiHelper!
  //                 .socialLogin(
  //                     user_email: _googleSignIn.currentUser!.email,
  //                     type: "google")
  //                 .then((result) async {
  //               if (result != null) {
  //                 if (result.status == "1") {
  //                   global.user = result.recordList;
  //                   global.sp.setString(
  //                       'currentUser', json.encode(global.user!.toJson()));

  //                   await getCurrentPosition().then((_) async {
  //                     if (global.lat != null && global.lng != null) {
  //                       hideLoader();
  //                       Navigator.of(context).push(
  //                         MaterialPageRoute(
  //                             builder: (context) => BottomNavigationWidget(
  //                                   a: widget.analytics,
  //                                   o: widget.observer,
  //                                 )),
  //                       );
  //                     } else {
  //                       hideLoader();
  //                       showSnackBar(
  //                           key: _scaffoldKey,
  //                           snackBarMessage: AppLocalizations.of(context)!
  //                               .txt_please_enablet_location_permission_to_use_app);
  //                     }
  //                   });
  //                 } else if (result.status == "2") {
  //                   hideLoader();
  //                   Navigator.of(context).push(
  //                     MaterialPageRoute(
  //                         builder: (context) => SignUpScreen(
  //                               a: widget.analytics,
  //                               o: widget.observer,
  //                               email: _googleSignIn.currentUser!.email,
  //                               name: _googleSignIn.currentUser!.displayName,
  //                             )),
  //                   );
  //                 }
  //               }
  //             });
  //           });
  //         }
  //       });
  //     } else {
  //       showNetworkErrorSnackBar(_scaffoldKey);
  //     }
  //   } catch (e) {
  //     hideLoader();
  //     print("Exception - signInScreen.dart - _signInWithGoogle():" +
  //         e.toString());
  //   }
  // }
}
