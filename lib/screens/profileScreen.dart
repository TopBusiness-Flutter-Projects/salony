import 'dart:convert';
import 'dart:io';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/userModel.dart';
import 'package:app/screens/accountSettingScreen.dart';
import 'package:app/screens/bookingManagementScreen.dart';
import 'package:app/screens/pricingAndOffersScreen.dart';
import 'package:app/screens/productOrderHistoryScreen.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:app/screens/termsOfServicesScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends BaseRoute {
  ProfileScreen({a, o}) : super(a: a, o: o, r: 'ProfileScreen');
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  CurrentUser? _user;
  bool _isDataLoaded = false;
  _ProfileScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'الحساب',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          automaticallyImplyLeading: false,
        ),
        body: (global.user?.id == null)
            ? Center(
                child: Text("لا يوجد بيانات شخصية"),
              )
            : _isDataLoaded
                ? ScrollConfiguration(
                    behavior: ScrollBehavior(),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: global.user!.image != ''
                                ? CachedNetworkImage(
                                    imageUrl:
                                        '${global.baseUrlForImage}${global.user!.image}',
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
                                          color: Theme.of(context).primaryColor,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.17,
                                    width: MediaQuery.of(context).size.height *
                                        0.17,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardTheme.color,
                                      borderRadius: new BorderRadius.all(
                                        new Radius.circular(
                                            MediaQuery.of(context).size.height *
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
                          ),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${global.user?.name}',
                              style:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                            ),
                          )),
                          Card(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AccountSettingScreen(
                                              a: widget.analytics,
                                              o: widget.observer)),
                                );
                              },
                              shape: Theme.of(context).cardTheme.shape,
                              leading: Icon(Icons.person),
                              title: Text('إعدادات الحساب',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall),
                              subtitle: Text(
                                AppLocalizations.of(context)!
                                    .txt_name_email_address_contact_number,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium,
                              ),
                            ),
                          ),
                          Card(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductOrderHistoryScreen(
                                              a: widget.analytics,
                                              o: widget.observer)),
                                );
                              },
                              shape: Theme.of(context).cardTheme.shape,
                              leading: Icon(FontAwesomeIcons.clockRotateLeft),
                              title: Text(
                                  AppLocalizations.of(context)!.lbl_my_orders,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall),
                              subtitle: Text(
                                AppLocalizations.of(context)!
                                    .txt_manage_your_order_history,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium,
                              ),
                            ),
                          ),
                          Card(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookingManagementScreen(
                                              a: widget.analytics,
                                              o: widget.observer)),
                                );
                              },
                              shape: Theme.of(context).cardTheme.shape,
                              leading: Icon(Icons.book_online),
                              title: Text(
                                  AppLocalizations.of(context)!
                                      .lbl_booking_management,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall),
                              subtitle: Text(
                                AppLocalizations.of(context)!
                                    .txt_manage_your_booking_system,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium,
                              ),
                            ),
                          ),
                          // Card(
                          //   margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                          //   child: ListTile(
                          //     onTap: () {
                          //       Navigator.of(context).push(
                          //         MaterialPageRoute(
                          //             builder: (context) => RewardScreen(
                          //                 a: widget.analytics, o: widget.observer)),
                          //       );
                          //     },
                          //     shape: Theme.of(context).cardTheme.shape,
                          //     leading: Icon(Icons.card_giftcard),
                          //     title: Text(
                          //         AppLocalizations.of(context)!
                          //             .lbl_reward_points_programme,
                          //         style: Theme.of(context)
                          //             .primaryTextTheme
                          //             .titleSmall),
                          //     subtitle: Text(
                          //       "You've ${global.user?.rewards ?? 0} rewards points",
                          //       style:
                          //           Theme.of(context).primaryTextTheme.titleMedium,
                          //     ),
                          //   ),
                          // ),
                          Card(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: ListTile(
                              shape: Theme.of(context).cardTheme.shape,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => PricingAndOffers(
                                          a: widget.analytics,
                                          o: widget.observer)),
                                );
                              },
                              leading: Icon(FontAwesomeIcons.tag),
                              title: Text(
                                  AppLocalizations.of(context)!
                                      .lbl_pricing_offers,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall),
                              subtitle: Text(
                                AppLocalizations.of(context)!
                                    .txt_get_every_special_offers,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium,
                              ),
                            ),
                          ),
                          // Card(
                          //   margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                          //   child: ListTile(
                          //     shape: Theme.of(context).cardTheme.shape,
                          //     onTap: () {
                          //       Navigator.of(context).push(
                          //         MaterialPageRoute(
                          //             builder: (context) => ReferAndEarnScreen(
                          //                 a: widget.analytics, o: widget.observer)),
                          //       );
                          //     },
                          //     leading: Icon(MdiIcons.accountConvert),
                          //     title: Text(
                          //         AppLocalizations.of(context)!.lbl_invite_earn,
                          //         style: Theme.of(context)
                          //             .primaryTextTheme
                          //             .titleSmall),
                          //     subtitle: Text(
                          //       AppLocalizations.of(context)!
                          //           .txt_invite_friends_and_earn_reward,
                          //       style:
                          //           Theme.of(context).primaryTextTheme.titleMedium,
                          //     ),
                          //   ),
                          // ),
                          Card(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => TermsOfServices(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )),
                                );
                              },
                              shape: Theme.of(context).cardTheme.shape,
                              leading: Icon(Icons.close),
                              title: Text(
                                  AppLocalizations.of(context)!
                                      .lbl_terms_of_service,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall),
                              subtitle: Text(
                                AppLocalizations.of(context)!
                                    .txt_save_your_terms_of_service,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium,
                              ),
                            ),
                          ),
                          // Card(
                          //   margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                          //   child: ListTile(
                          //     onTap: () {
                          //       Navigator.of(context).push(
                          //         MaterialPageRoute(
                          //             builder: (context) => ChooseLanguageScreen(
                          //                   a: widget.analytics,
                          //                   o: widget.observer,
                          //                 )),
                          //       );
                          //     },
                          //     shape: Theme.of(context).cardTheme.shape,
                          //     leading: Icon(FontAwesomeIcons.language),
                          //     title: Text(
                          //         AppLocalizations.of(context)!.lbl_select_language,
                          //         style: Theme.of(context)
                          //             .primaryTextTheme
                          //             .titleSmall),
                          //     subtitle: Text(
                          //       AppLocalizations.of(context)!
                          //           .txt_set_your_preffered_language,
                          //       style:
                          //           Theme.of(context).primaryTextTheme.titleMedium,
                          //     ),
                          //   ),
                          // ),
                          Card(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: ListTile(
                              onTap: () {
                                _showDeleteAccountDialog();
                              },
                              shape: Theme.of(context).cardTheme.shape,
                              leading: Icon(FontAwesomeIcons.userLock),
                              title: Text(
                                  AppLocalizations.of(context)!
                                      .lbl_delete_account,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall),
                              subtitle: Text(
                                AppLocalizations.of(context)!
                                    .txt_delete_account,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .backgroundColor),
                            ),
                            onPressed: () {
                              _signOutDialog();
                            },
                            icon: Icon(Icons.logout_rounded),
                            label: Text(
                                AppLocalizations.of(context)!.btn_sign_out),
                          ),
                          SizedBox(height: 40)
                        ],
                      ),
                    ),
                  )
                : _shimmer(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // if (global.user?.id == null) {
    //   Future.delayed(Duration.zero, () {
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //           builder: (context) => SignInScreen(
    //                 a: widget.analytics,
    //                 o: widget.observer,
    //               )),
    //     );
    //   });
    // }
    _init();
  }

  _getUserProfile() async {
    if (global.user!.id == null) {
      Fluttertoast.showToast(msg: 'قم بتسجيل الدخول لتتمكن عرض الصفحه الشخصيه');
      global.user = CurrentUser();
    } else {
      try {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          await apiHelper!.getUserProfile(global.user!.id).then((result) {
            if (result != null) {
              if (result.status == "1") {
                _user = result.recordList;
                int? _tCartCount = global.user!.cart_count;
                global.user = _user;
                global.user!.cart_count = _tCartCount;

                global.sp.setString(
                    "currentUser", json.encode(global.user!.toJson()));
              }
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } catch (e) {
        print("Exception - profileScreen.dart - _getUserProfile():" +
            e.toString());
      }
    }
  }

  _init() async {
    try {
      await _getUserProfile();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - profileScreen.dart - _init():" + e.toString());
    }
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                child: Card(),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Card(
                                  margin: EdgeInsets.only(top: 5, bottom: 5)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 220,
                                  height: 40,
                                  child: Card(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 5)),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  height: 40,
                                  child: Card(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 5)),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _signOutDialog() async {
    try {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: CupertinoAlertDialog(
                title: Text(
                  AppLocalizations.of(context)!.lbl_sign_out,
                ),
                content: Text(
                  AppLocalizations.of(context)!
                      .txt_confirmation_message_for_sign_out,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      AppLocalizations.of(context)!.lbl_cancelled,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      // Dismiss the dialog but don't
                      // dismiss the swiped item
                      return Navigator.of(context).pop(false);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(AppLocalizations.of(context)!.btn_sign_out),
                    onPressed: () async {
                      global.sp.remove("currentUser");

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignInScreen(
                              a: widget.analytics, o: widget.observer)));
                      global.user = new CurrentUser();
                    },
                  ),
                ],
              ),
            );
          });
    } catch (e) {
      print(
          'Exception - profileScreen.dart - exitAppDialog(): ' + e.toString());
    }
  }

  _showDeleteAccountDialog() async {
    if (Platform.isIOS) {
      _showCupertinoDeleteDialog();
    } else {
      _showMaterialDeleteDialog();
    }
  }

  _showMaterialDeleteDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.lbl_account_deletion),
            content: Text(AppLocalizations.of(context)!
                .lbl_account_deletion_confirmation),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.lbl_cancelled)),
              ElevatedButton(
                  onPressed: () async {
                    if (global.user?.id != null) {
                      await apiHelper?.deleteAccount(global.user?.id);
                      global.sp.remove("currentUser");

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignInScreen(
                              a: widget.analytics, o: widget.observer)));
                      global.user = new CurrentUser();
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.btn_delete)),
            ],
          );
        });
  }

  _showCupertinoDeleteDialog() async {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(dialogBackgroundColor: Colors.white),
            child: CupertinoAlertDialog(
              title: Text(
                AppLocalizations.of(context)!.lbl_account_deletion,
              ),
              content: Text(
                AppLocalizations.of(context)!.lbl_account_deletion_confirmation,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context)!.lbl_cancelled),
                  onPressed: () {
                    // Dismiss the dialog but don't
                    // dismiss the swiped item
                    return Navigator.of(context).pop(false);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context)!.btn_delete,
                      style: TextStyle(color: Colors.red)),
                  onPressed: () async {
                    await apiHelper?.deleteAccount(global.user?.id);
                    global.sp.remove("currentUser");

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignInScreen(
                            a: widget.analytics, o: widget.observer)));
                    global.user = new CurrentUser();
                  },
                ),
              ],
            ),
          );
        });
  }
}
