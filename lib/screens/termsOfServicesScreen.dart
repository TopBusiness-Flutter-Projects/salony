import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/termsAndConditionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsOfServices extends BaseRoute {
  TermsOfServices({a, o}) : super(a: a, o: o, r: 'TermsOfServices');

  @override
  _TermsOfServicesState createState() => new _TermsOfServicesState();
}

class _TermsOfServicesState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TermsAndCondition? _termsAndCondition;
  bool _isDataLoaded = false;

  _TermsOfServicesState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.lbl_terms_of_service),
        ),
        body: _isDataLoaded
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Html(
                          data: _termsAndCondition!.termcondition,
                          style: {
                            'body': Style(textAlign: TextAlign.justify),
                          },
                        )),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
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

  _getTermsAndCondition() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getTermsAndCondition().then((result) {
          if (result != null) {
            if (result.status == "1") {
              _termsAndCondition = result.data;
              _isDataLoaded = true;
              setState(() {});
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - termsOfServicesScreen.dart - _getTermsAndCondition():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getTermsAndCondition();
    } catch (e) {
      print("Exception - termsOfServicesScreen.dart - _init():" + e.toString());
    }
  }
}
