import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/widgets/bottomNavigationWidget.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends BaseRoute {
  ExploreScreen({a, o}) : super(a: a, o: o, r: 'ExploreScreen');
  @override
  _ExploreScreenState createState() => new _ExploreScreenState();
}

class _ExploreScreenState extends BaseRouteState {
  _ExploreScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitAppDialog().then((value) => value as bool);
      },
      child: sc(Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/exploreImg.png',
              height: 300,
              width: double.infinity,
            ),
            Text(
              'You are ready to go!',
              style: Theme.of(context).primaryTextTheme.caption,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Thanks for taking your time to create an account with us. Now this is the fun part, let\'s experience this app.', textAlign: TextAlign.center, style: Theme.of(context).primaryTextTheme.headline3),
            ),
            Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.only(top: 40),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BottomNavigationWidget(a: widget.analytics, o: widget.observer)),
                      );
                    },
                    child: Text('Let\'s explore'))),
          ],
        ),
      ))),
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
}
