import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/barberShopListScreen.dart';
import 'package:app/screens/favouritesScreen.dart';
import 'package:app/screens/homeScreen.dart';
import 'package:app/screens/locationScreen.dart';
import 'package:app/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:flutter/services.dart';

class BottomNavigationWidget extends BaseRoute {
  final int? screenId;

  BottomNavigationWidget({a, o, this.screenId})
      : super(a: a, o: o, r: 'BottomNavigationWidget');

  @override
  _BottomNavigationWidgetState createState() =>
      new _BottomNavigationWidgetState(screenId: screenId);
}

class _BottomNavigationWidgetState extends BaseRouteState {
  int? screenId = 0;
  int? _currentIndex = 0;
  int? locationIndex = 0;
  _BottomNavigationWidgetState({this.screenId}) : super();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = screenId != null ? screenId : 0;
    if (screenId != null && screenId == 1) {
      locationIndex = screenId;
      screenId = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
            notchMargin: 2,
            shape: CircularNotchedRectangle(),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: SizedBox(
                height: 60,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex!,
                  unselectedFontSize: 0,
                  selectedFontSize: 0,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                      locationIndex = 0;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: '',
                      icon: Icon(Icons.home_outlined),
                      tooltip: 'Home',
                    ),
                    // BottomNavigationBarItem(
                    //     label: '',
                    //     tooltip: 'Location',
                    //     icon: Padding(
                    //       padding: global.isRTL
                    //           ? EdgeInsets.only(left: 15)
                    //           : EdgeInsets.only(right: 15),
                    //       child: Icon(Icons.location_on_outlined),
                    //     )),
                    BottomNavigationBarItem(
                        label: '',
                        tooltip: 'Favorite',
                        icon: Padding(
                          padding: global.isRTL
                              ? EdgeInsets.only(right: 15)
                              : EdgeInsets.only(left: 15),
                          child: Icon(Icons.favorite_outline_outlined),
                        )),
                    BottomNavigationBarItem(
                        label: '',
                        icon: Icon(Icons.person_outline),
                        tooltip: 'Profile')
                  ],
                ),
              ),
            )),

        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: CircleAvatar(
        //   radius: 23,
        //   backgroundColor: Colors.white,
        //   child: FloatingActionButton(
        //     elevation: 0,
        //     mini: true,
        //     backgroundColor: Color(0xFFF36D86),
        //     onPressed: () {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(
        //             builder: (context) => BarberShopListScreen(
        //                 a: widget.analytics, o: widget.observer)),
        //       );
        //     },
        //     child: Icon(Icons.calendar_today_rounded),
        //   ),
        // ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: screens().elementAt(_currentIndex!),
        ),
      ),
    );
  }

  List<Widget> screens() => [
        HomeScreen(a: widget.analytics, o: widget.observer),
        // LocationScreen(
        //   a: widget.analytics,
        //   o: widget.observer,
        //   screenId: locationIndex,
        // ),
        FavouritesScreen(a: widget.analytics, o: widget.observer),
        ProfileScreen(a: widget.analytics, o: widget.observer)
      ];
}
