import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/widgets/bottomNavigationWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingConfirmationScreen extends BaseRoute {
  final int? screenId;
  BookingConfirmationScreen({a, o, this.screenId})
      : super(a: a, o: o, r: 'BookingConfirmationScreen');
  @override
  _BookingConfirmationScreenState createState() =>
      new _BookingConfirmationScreenState(this.screenId);
}

class _BookingConfirmationScreenState extends BaseRouteState {
  int? screenId;
  _BookingConfirmationScreenState(this.screenId) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Navigator.of(context)
              .push(
                MaterialPageRoute(
                    builder: (context) => BottomNavigationWidget(
                          a: widget.analytics,
                          o: widget.observer,
                        )),
              )
              .then((value) => value as bool);
        },
        child: sc(Scaffold(
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF171D2C),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: Platform.isIOS ? 68 : 60,
              padding: EdgeInsets.only(
                left: 100,
                right: 100,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, bottom: Platform.isIOS ? 16.0 : 8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => BottomNavigationWidget(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )),
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.lbl_finish),
                    ),
                  )),
            ),
            body: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/greatekan3.png'))),
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Great' + ' ' + '${global.user!.name}',
                            style: Theme.of(context).primaryTextTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: screenId == 1
                          ? Text(
                              "لقد تم تقديم طلبك بنجاح، يرجى استلام العناصر الخاصة بك من المتجر في أسرع وقت ممكن",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium)
                          : Text(
                              "تم إجراء حجزك بنجاح، ستتلقى إشعارًا/رسالة نصية قصيرة حول حالة حجزك",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium),
                    ),
                  ],
                )))));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
