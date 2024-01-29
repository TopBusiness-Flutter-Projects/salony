import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/cookiesPolicyModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CookiesPolicy extends BaseRoute {
  CookiesPolicy({a, o}) : super(a: a, o: o, r: 'CookiesPolicy');
  @override
  _CookiesPolicyState createState() => new _CookiesPolicyState();
}

class _CookiesPolicyState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  Cookies? _cookiesPolicy;
  bool _isDataLoaded = false;
  _CookiesPolicyState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: sc(Scaffold(
        appBar: AppBar(
          title: Text('Cookies Policy'),
        ),
        body: _isDataLoaded
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Html(
                          data: _cookiesPolicy!.cookies_policy,
                          style: {
                            'body': Style(textAlign: TextAlign.justify),
                          },
                        )),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
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
    _init();
  }

  _getCookiesPolicy() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.cookiesPolicy().then((result) {
          if (result != null) {
            if (result.status == "1") {
              _cookiesPolicy = result.data;
              _isDataLoaded = true;
              setState(() {});
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - cookiesPolicyScreen.dart - _getCookiesPolicy():" + e.toString());
    }
  }

  _init() async {
    await _getCookiesPolicy();
  }
}
