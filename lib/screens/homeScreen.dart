import 'package:app/models/bannerModel.dart';
import 'package:app/models/barberShopModel.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/popularBarbersModel.dart';
import 'package:app/models/productModel.dart';
import 'package:app/screens/barberShopDescriptionScreen.dart';
import 'package:app/screens/productListScreen.dart';
import 'package:app/screens/serviceListScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import '../models/main_services.dart';
import 'detailsOfServices.dart';
import 'productsOfMain.dart';

class HomeScreen extends BaseRoute {
  HomeScreen({a, o}) : super(a: a, o: o, r: 'HomeScreen');
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<BannerModel>? _bannerList = [];
  // List<Service>? _serviceList = [];
  List<MainService>? _mainServiceList = [];
  List<MainService>? _mainProductsList = [];
  bool _isProductsLoaded = true;
  List<BarberShop>? _barberShopList = [];
  List<PopularBarbers>? _popularBarbersList = [];
  List<Product>? _productList = [];
  CarouselController? _carouselController;
  int _currentIndex = 0;
  bool _isBannerDataLoaded = true;
  // bool _isServicesDataLoaded = true;
  bool _isMainServicesDataLoaded = true;
  bool _isBarberShopDataLoaded = false;
  bool _isBarbersDataLoaded = false;

  _HomeScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          //
          await _init();
        },
        child: Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _isBannerDataLoaded
                    ? Container(
                        padding: EdgeInsets.only(top: 20),
                        height: MediaQuery.of(context).size.height * 0.40,
                        decoration: BoxDecoration(
                            // color: Color(0xFF171D2C),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 13, right: 13),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  (global.user?.image != null &&
                                          global.user?.image != "")
                                      ? CircleAvatar(
                                          radius: 26,
                                          backgroundColor:
                                              Color.fromARGB(255, 0, 0, 0),
                                          child: CachedNetworkImage(
                                            imageUrl: global.baseUrlForImage +
                                                global.user!.image!,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    CircleAvatar(
                                                        radius: 24,
                                                        backgroundImage:
                                                            imageProvider),
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    CircleAvatar(
                                              radius: 24,
                                              child: Icon(Icons.person),
                                              backgroundColor: Colors.black,
                                            ),
                                          ))
                                      : CircleAvatar(
                                          radius: 24,
                                          child: Image.asset(
                                              'assets/images/logo_person.png'),
                                          backgroundColor: Colors.white,
                                        ),

                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Padding(
                                      padding: global.isRTL
                                          ? EdgeInsets.only(right: 10)
                                          : EdgeInsets.only(left: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('مرحباً ',
                                              style: TextStyle(
                                                  color: Color(0xff747474),
                                                  fontSize: 18,
                                                  fontFamily: 'Cairo',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                  overflow: TextOverflow.clip)),
                                          Text(
                                            global.user?.id == null ||
                                                    global.user?.name == ''
                                                ? AppLocalizations.of(context)!
                                                    .txt_sign_up_to_continue
                                                : '${global.user!.name}',
                                            style: TextStyle(
                                              color: Color(0xff747474),
                                              fontSize: 18,
                                              fontFamily: 'Cairo',
                                              overflow: TextOverflow.clip,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     Navigator.of(context).push(
                                          //       MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               BottomNavigationWidget(
                                          //                 a: widget.analytics,
                                          //                 o: widget.observer,
                                          //                 screenId: 1,
                                          //               )),
                                          //     );
                                          //   },
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.start,
                                          //     mainAxisSize: MainAxisSize.min,
                                          //     children: [
                                          //       Icon(
                                          //         Icons.location_on_outlined,
                                          //         size: 17,
                                          //       ),
                                          //       SizedBox(
                                          //         width: 130,
                                          //         child: Text(
                                          //           global.currentLocation,
                                          //           overflow:
                                          //               TextOverflow.ellipsis,
                                          //           style: Theme.of(context)
                                          //               .primaryTextTheme
                                          //               .displayMedium,
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  //     padding: EdgeInsets.all(0),
                                  //     alignment: global.isRTL
                                  //         ? Alignment.centerLeft
                                  //         : Alignment.centerRight,
                                  //     onPressed: () {
                                  //       Navigator.of(context).push(
                                  //         MaterialPageRoute(
                                  //             builder: (context) => SearchScreen(
                                  //                 0,
                                  //                 a: widget.analytics,
                                  //                 o: widget.observer)),
                                  //       );
                                  //     },
                                  //     icon: Icon(
                                  //       Icons.search,
                                  //       size: 22,
                                  //     )),
                                  // IconButton(
                                  //     padding: EdgeInsets.all(0),
                                  //     alignment: global.isRTL
                                  //         ? Alignment.centerLeft
                                  //         : Alignment.centerRight,
                                  //     onPressed: () {
                                  //       global.user!.id == null
                                  //           ? Navigator.of(context).push(
                                  //               MaterialPageRoute(
                                  //                   builder: (context) =>
                                  //                       SignInScreen(
                                  //                         a: widget.analytics,
                                  //                         o: widget.observer,
                                  //                       )),
                                  //             )
                                  //           : Navigator.of(context).push(
                                  //               MaterialPageRoute(
                                  //                   builder: (context) =>
                                  //                       NotificationScreen(
                                  //                           a: widget.analytics,
                                  //                           o: widget.observer)),
                                  //             );
                                  //     },
                                  //     icon: Icon(
                                  //       Icons.notifications,
                                  //       size: 22,
                                  //     ))
                                ],
                              ),
                            ),
                            _bannerList!.length > 0
                                ? CarouselSlider(
                                    items: _items(),
                                    carouselController: _carouselController,
                                    options: CarouselOptions(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        aspectRatio: 1,
                                        viewportFraction: 0.93,
                                        initialPage: _currentIndex,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index, _) {
                                          _currentIndex = index;
                                          setState(() {});
                                        }))
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: Center(
                                        child: Text(
                                      AppLocalizations.of(context)!
                                          .txt_no_saloon_are_available_at_your_location,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .displayMedium,
                                    ))),
                            _isBannerDataLoaded
                                ? _bannerList!.length > 0
                                    ? DotsIndicator(
                                        dotsCount: _bannerList!.length,
                                        position: _currentIndex,
                                        onTap: (i) {
                                          print('ssssssss');
                                          _currentIndex = i.toInt();
                                          _carouselController!.animateToPage(
                                              _currentIndex,
                                              duration:
                                                  Duration(microseconds: 1),
                                              curve: Curves.easeInOut);
                                        },
                                        decorator: DotsDecorator(
                                          activeSize: const Size(8, 8),
                                          size: const Size(8, 8),
                                          activeShape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50.0))),
                                          activeColor: Color(0xffF36D86),
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      )
                                    : SizedBox()
                                : SizedBox()
                          ],
                        ),
                      )
                    : _shimmer1(),
                Padding(
                  padding: EdgeInsets.only(top: 0, left: 13, right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الخدامات',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ServiceListScreen(
                                        // a: widget.analytics,
                                        // o: widget.observer,
                                      )),
                            );
                          },
                          child: Text(
                            'الكل',
                            style: TextStyle(
                              color: Color(0xffF36D86),
                              fontSize: 18,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w200,
                              height: 0,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                    // height: 60,
                    child: _isMainServicesDataLoaded
                        ? _mainServiceList!.length > 0
                            ? _services()
                            : Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .txt_no_service_available_at_your_location,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium,
                                  ),
                                ),
                              )
                        : _shimmer2()),
                //recommended BarberShop
                // Padding(
                //   padding: EdgeInsets.only(top: 18, left: 13, right: 13),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //           AppLocalizations.of(context)!
                //               .lbl_recommended_barbershop,
                //           style: Theme.of(context).primaryTextTheme.titleLarge),
                //       InkWell(
                //           splashColor: Colors.transparent,
                //           highlightColor: Colors.transparent,
                //           overlayColor:
                //               MaterialStateProperty.all(Colors.transparent),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                   builder: (context) => BarberShopListScreen(
                //                       a: widget.analytics, o: widget.observer)),
                //             );
                //           },
                //           child: Text(AppLocalizations.of(context)!.lbl_see_more,
                //               style: Theme.of(context)
                //                   .primaryTextTheme
                //                   .headlineSmall))
                //     ],
                //   ),
                // ),
                // SizedBox(
                //     height: 156,
                //     child: _isBarberShopDataLoaded
                //         ? _barberShopList!.length > 0
                //             ? _recommendedBarbershop()
                //             : Padding(
                //                 padding: const EdgeInsets.only(left: 15),
                //                 child: Align(
                //                   alignment: Alignment.centerLeft,
                //                   child: Text(
                //                     AppLocalizations.of(context)!
                //                         .txt_no_barbershop_are_available_at_your_location,
                //                     style: Theme.of(context)
                //                         .primaryTextTheme
                //                         .titleMedium,
                //                   ),
                //                 ),
                //               )
                //         : _shimmer3()),

                // //popular Barbers
                // Padding(
                //   padding: EdgeInsets.only(top: 20, left: 13, right: 13),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(AppLocalizations.of(context)!.lbl_popular_barbers,
                //           style: Theme.of(context).primaryTextTheme.titleLarge),
                //       InkWell(
                //           splashColor: Colors.transparent,
                //           highlightColor: Colors.transparent,
                //           overlayColor:
                //               MaterialStateProperty.all(Colors.transparent),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                   builder: (context) => BarberListScreen(
                //                         a: widget.analytics,
                //                         o: widget.observer,
                //                       )),
                //             );
                //           },
                //           child: Text(AppLocalizations.of(context)!.lbl_see_more,
                //               style: Theme.of(context)
                //                   .primaryTextTheme
                //                   .headlineSmall)),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //     height: 120,
                //     child: _isBarbersDataLoaded
                //         ? _popularBarbersList!.length > 0
                //             ? Align(
                //                 alignment: global.isRTL
                //                     ? Alignment.centerRight
                //                     : Alignment.centerLeft,
                //                 child: _popularBarbers())
                //             : Padding(
                //                 padding: const EdgeInsets.only(left: 15),
                //                 child: Align(
                //                   alignment: Alignment.centerLeft,
                //                   child: Text(
                //                     AppLocalizations.of(context)!
                //                         .txt_no_barbers_are_available_at_your_location,
                //                     style: Theme.of(context)
                //                         .primaryTextTheme
                //                         .titleMedium,
                //                   ),
                //                 ),
                //               )
                //         : _shimmer4()),

                Padding(
                  padding: EdgeInsets.only(top: 20, left: 13, right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المنتجات',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ProductListScreen(
                                        // a: widget.analytics,
                                        // o: widget.observer,
                                      )),
                            );
                          },
                          child: Text(
                            'الكل',
                            style: TextStyle(
                                color: Color(0xffF36D86),
                                fontSize: 18,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w200,
                                height: 0),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  // height: 160,
                  child: _isProductsLoaded
                      ? _mainProductsList!.length > 0
                          ? _products()
                          : Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .txt_nothing_is_yet_to_see_here,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium,
                                ),
                              ),
                            )
                      : _shimmer3(),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<bool?> _addToFavorite(int? id) async {
    bool _isFav = false;
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper!.addToFavorite(global.user!.id, id).then((result) {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();
              _isFav = true;

              setState(() {});
            } else if (result.status == "0") {
              hideLoader();
              _isFav = true;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      return _isFav;
    } catch (e) {
      print("Exception - homeScreen.dart - _addToFavorite():" + e.toString());
      return null;
    }
  }

  _getNearByBanners() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!
            .getNearByBanners() //global.lat, global.lng
            .then((result) {
          if (result != null) {
            if (result.status == "1") {
              _bannerList = result.recordList;
            } else {}
          }
          setState(() {
            _isBannerDataLoaded = true;
          });
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - homeScreen.dart - _getNearByBanners():" + e.toString());
    }
  }

  // _getNearByBarberShops() async {
  //   try {
  //     bool isConnected = await br.checkConnectivity();
  //     if (isConnected) {
  //       await apiHelper!
  //           .getNearByBarberShops(global.lat, global.lng, 1)
  //           .then((result) {
  //         if (result != null) {
  //           if (result.status == "1") {
  //             _barberShopList = result.recordList;
  //           } else {}
  //         }
  //         _isBarberShopDataLoaded = true;
  //         setState(() {});
  //       });
  //     } else {
  //       showNetworkErrorSnackBar(_scaffoldKey);
  //     }
  //   } catch (e) {
  //     print("Exception - homeScreen.dart - _getNearByBarberShops():" +
  //         e.toString());
  //   }
  // }

  // _getPopularBarbers() async {
  //   try {
  //     bool isConnected = await br.checkConnectivity();
  //     if (isConnected) {
  //       await apiHelper!
  //           .getPopularBarbersList(global.lat, global.lng, 1, null)
  //           .then((result) {
  //         if (result != null) {
  //           if (result.status == "1") {
  //             _popularBarbersList = result.recordList;
  //           } else {}
  //         }
  //         _isBarbersDataLoaded = true;
  //         setState(() {});
  //       });
  //     } else {
  //       showNetworkErrorSnackBar(_scaffoldKey);
  //     }
  //   } catch (e) {
  //     print("Exception - homeScreen.dart - _getServices():" + e.toString());
  //   }
  // }

  // _getProducts() async {
  //   try {
  //     bool isConnected = await br.checkConnectivity();
  //     if (isConnected) {
  //       await apiHelper!
  //           .getProducts(global.lat, global.lng, 1, '')
  //           .then((result) {
  //         if (result != null) {
  //           if (result.status == "1") {
  //             _productList = result.recordList;
  //           } else {}
  //         }
  //         _isProductsLoaded = true;
  //         setState(() {});
  //       });
  //     } else {
  //       showNetworkErrorSnackBar(_scaffoldKey);
  //     }
  //   } catch (e) {
  //     print("Exception - homeScreen.dart - _getProducts():" + e.toString());
  //   }
  // }

  // _getServices() async {
  //   try {
  //     bool isConnected = await br.checkConnectivity();
  //     if (isConnected) {
  //       await apiHelper!.getServices(global.lat, global.lng, 1).then((result) {
  //         if (result != null) {
  //           if (result.status == "1") {
  //             _serviceList = result.recordList;
  //           } else {}
  //         }

  //         setState(() {
  //           _isServicesDataLoaded = true;
  //         });
  //       });
  //     } else {
  //       showNetworkErrorSnackBar(_scaffoldKey);
  //     }
  //   } catch (e) {
  //     print("Exception - homeScreen.dart - _getServices():" + e.toString());
  //   }
  // }
  _getMainServices({String type = 'service'}) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getMainServices(type: type).then((result) {
          if (result != null) {
            if (result.status == "1") {
              if (type == 'service') {
                _mainServiceList = result.recordList;
              } else {
                _mainProductsList = result.recordList;
              }
            } else {}
          }
          setState(() {
            _isProductsLoaded = true;
            _isMainServicesDataLoaded = true;
          });
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - _getServices():" + e.toString());
    }
  }

  _init() async {
    final List<dynamic> _ = await Future.wait([
      _getNearByBanners(),
      _getMainServices(type: 'service'),
      _getMainServices(type: 'product'),

      // _getNearByBarberShops(),
      // _getPopularBarbers(),
      // _getProducts()
    ]);
    setState(() {});
  }

  List<Widget> _items() {
    List<Widget> list = [];
    try {
      for (int i = 0; i < _bannerList!.length; i++) {
        list.add(GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => BarberShopDescriptionScreen(
                        int.parse(_bannerList![i].vendor_id ?? '1'),
                        // a: widget.analytics,
                        // o: widget.observer,
                      )),
            );
          },
          child: _bannerList![i].banner_image != "N/A"
              ? CachedNetworkImage(
                  imageUrl:
                      global.baseUrlForImage + _bannerList![i].banner_image!,
                  imageBuilder: (context, imageProvider) => Container(
                    margin: EdgeInsets.only(
                      top: 18,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Container(
                    margin: EdgeInsets.only(
                        top: 18, bottom: 10, left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:
                        Text(AppLocalizations.of(context)!.txt_no_image_availa),
                  ),
                )
              : Container(
                  margin:
                      EdgeInsets.only(top: 18, bottom: 10, left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:
                      Text(AppLocalizations.of(context)!.txt_no_image_availa),
                ),
        ));
      }

      return list;
    } catch (e) {
      print("Exception - homeScreen.dart - _items(): " + e.toString());
      list.add(SizedBox());
      return list;
    }
  }

  // Widget _popularBarbers() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 7, right: 7),
  //     child: ListView.builder(
  //         itemCount: _popularBarbersList!.length,
  //         shrinkWrap: true,
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (BuildContext context, int index) {
  //           return InkWell(
  //             splashColor: Colors.transparent,
  //             highlightColor: Colors.transparent,
  //             overlayColor: MaterialStateProperty.all(Colors.transparent),
  //             onTap: () {
  //               Navigator.of(context).push(
  //                 MaterialPageRoute(
  //                     builder: (context) => BarberDetailScreen(
  //                         _popularBarbersList![index].staff_id,
  //                         a: widget.analytics,
  //                         o: widget.observer)),
  //               );
  //             },
  //             child: Padding(
  //               padding: EdgeInsets.only(left: 5, right: 5),
  //               child: SizedBox(
  //                 width: 80,
  //                 height: 120,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     CachedNetworkImage(
  //                       imageUrl: global.baseUrlForImage +
  //                           _popularBarbersList![index].staff_image!,
  //                       imageBuilder: (context, imageProvider) => CircleAvatar(
  //                           radius: 35, backgroundImage: imageProvider),
  //                       placeholder: (context, url) =>
  //                           Center(child: CircularProgressIndicator()),
  //                       errorWidget: (context, url, error) => CircleAvatar(
  //                         radius: 35,
  //                         child: Icon(Icons.person),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 40,
  //                       child: Text(
  //                         _popularBarbersList![index].staff_name!,
  //                         textAlign: TextAlign.center,
  //                         style: Theme.of(context).primaryTextTheme.bodyLarge,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }

  Widget _products() {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: Align(
        alignment: global.isRTL ? Alignment.centerRight : Alignment.centerLeft,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2.5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10),
            itemCount: _mainProductsList!.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ProductDetailScreen(
                  //         _mainProductsList![index].id,
                  //         a: widget.analytics,
                  //         o: widget.observer,
                  //         isShowGoCartBtn:
                  //             _mainProductsList![index].cart_qty != null &&
                  //                     _mainProductsList![index].cart_qty! > 0
                  //                 ? true
                  //                 : false)));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductsOfMainScreen(
                            mainId: _mainProductsList![index].id ?? 4,
                            // a: widget.analytics,
                            // o: widget.observer,
                            serviceImage: _mainProductsList![index].image,
                            serviceName: _mainProductsList![index].name,
                          )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 2, right: 2, bottom: 2, top: 2),
                  child: SizedBox(
                    width: 110,
                    child: Card(
                      elevation: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: Card(
                              child: CachedNetworkImage(
                                imageUrl: global.baseUrlForImage +
                                    _mainProductsList![index].image!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  // width: 110,
                                  // height: 110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageProvider)),
                                  // child: Align(
                                  //   alignment: Alignment.topRight,
                                  //   child: IconButton(
                                  //       alignment: Alignment.topRight,
                                  //       padding: EdgeInsets.all(4),
                                  //       onPressed: () async {
                                  //         if (global.user!.id == null) {
                                  //           Navigator.of(context).push(
                                  //             MaterialPageRoute(
                                  //                 builder: (context) =>
                                  //                     SignInScreen(
                                  //                       a: widget
                                  //                           .analytics,
                                  //                       o: widget
                                  //                           .observer,
                                  //                     )),
                                  //           );
                                  //         } else {
                                  //           bool? _isFav;
                                  //           _isFav = await _addToFavorite(
                                  //               _mainProductsList![index]
                                  //                   .id);
                                  //           if (_isFav! &&
                                  //               _productList![index]
                                  //                       .isFavourite !=
                                  //                   null) {
                                  //             _productList![index]
                                  //                     .isFavourite =
                                  //                 !_productList![index]
                                  //                     .isFavourite!;
                                  //           }
                                  //         }
                                  //         setState(() {});
                                  //       },
                                  //       icon: Icon(
                                  //         _productList![index]
                                  //                         .isFavourite !=
                                  //                     null &&
                                  //                 _productList![index]
                                  //                     .isFavourite!
                                  //             ? Icons.favorite
                                  //             : Icons.favorite_outline,
                                  //         color: _productList![index]
                                  //                         .isFavourite !=
                                  //                     null &&
                                  //                 _productList![index]
                                  //                     .isFavourite!
                                  //             ? Color(0xffF36D86)
                                  //             : Colors.white,
                                  //         size: 20,
                                  //       )),
                                  // )
                                ),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Container(
                                    // width: 110,
                                    // height: 110,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2)),
                                    child: Text(
                                      "No image",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '${_mainProductsList![index].name}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  // Widget _recommendedBarbershop() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 7, right: 7),
  //     child: Align(
  //       alignment: global.isRTL ? Alignment.centerRight : Alignment.centerLeft,
  //       child: ListView.builder(
  //           itemCount: _barberShopList!.length,
  //           shrinkWrap: true,
  //           scrollDirection: Axis.horizontal,
  //           itemBuilder: (BuildContext context, int index) {
  //             return InkWell(
  //               splashColor: Colors.transparent,
  //               highlightColor: Colors.transparent,
  //               overlayColor: MaterialStateProperty.all(Colors.transparent),
  //               onTap: () {
  //                 Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                       builder: (context) => BarberShopDescriptionScreen(
  //                           _barberShopList![index].vendor_id,
  //                           a: widget.analytics,
  //                           o: widget.observer)),
  //                 );
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.only(
  //                     left: 7, right: 7, bottom: 2, top: 5),
  //                 child: Card(
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       CachedNetworkImage(
  //                         imageUrl: global.baseUrlForImage +
  //                             _barberShopList![index].vendor_logo!,
  //                         imageBuilder: (context, imageProvider) => Container(
  //                           width: 180,
  //                           height: 80,
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10),
  //                               image: DecorationImage(
  //                                   fit: BoxFit.contain, image: imageProvider)),
  //                         ),
  //                         placeholder: (context, url) => SizedBox(
  //                             width: 180,
  //                             height: 80,
  //                             child:
  //                                 Center(child: CircularProgressIndicator())),
  //                         errorWidget: (context, url, error) => Container(
  //                           width: 180,
  //                           height: 80,
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10)),
  //                           child: Center(
  //                               child: Text(AppLocalizations.of(context)!
  //                                   .txt_no_image_availa)),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 180,
  //                         child: Padding(
  //                           padding: EdgeInsets.only(
  //                               left: 7, right: 7, bottom: 5, top: 5),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Expanded(
  //                                   child: Padding(
  //                                 padding: const EdgeInsets.only(left: 3),
  //                                 child: Text(
  //                                     '${_barberShopList![index].vendor_name}',
  //                                     style: Theme.of(context)
  //                                         .primaryTextTheme
  //                                         .bodyLarge,
  //                                     overflow: TextOverflow.ellipsis,
  //                                     maxLines: 1),
  //                               )),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 180,
  //                         child: Padding(
  //                           padding: global.isRTL
  //                               ? EdgeInsets.only(right: 7)
  //                               : EdgeInsets.only(left: 7),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Icon(
  //                                 Icons.location_on_outlined,
  //                                 size: 15,
  //                               ),
  //                               SizedBox(
  //                                 width: 150,
  //                                 child: Text(
  //                                   '${_barberShopList![index].vendor_loc}',
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: Theme.of(context)
  //                                       .primaryTextTheme
  //                                       .bodyMedium,
  //                                   maxLines: 1,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       _barberShopList![index].rating != null
  //                           ? Padding(
  //                               padding: EdgeInsets.only(left: 10, right: 10),
  //                               child: Row(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: [
  //                                   Text('${_barberShopList![index].rating}',
  //                                       style: Theme.of(context)
  //                                           .primaryTextTheme
  //                                           .bodyMedium),
  //                                   RatingBar.builder(
  //                                     initialRating:
  //                                         _barberShopList![index].rating!,
  //                                     minRating: 0,
  //                                     direction: Axis.horizontal,
  //                                     allowHalfRating: true,
  //                                     itemCount: 5,
  //                                     itemSize: 8,
  //                                     itemPadding:
  //                                         EdgeInsets.symmetric(horizontal: 0),
  //                                     itemBuilder: (context, _) => Icon(
  //                                       Icons.star,
  //                                       color: Colors.amber,
  //                                     ),
  //                                     ignoreGestures: true,
  //                                     updateOnDrag: false,
  //                                     onRatingUpdate: (rating) {},
  //                                   )
  //                                 ],
  //                               ),
  //                             )
  //                           : SizedBox()
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }),
  //     ),
  //   );
  // }

  Widget _services() {
    return Padding(
      padding: EdgeInsets.only(
        left: 7,
        right: 7,
        top: 7,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2.5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10),
            itemCount: _mainServiceList!.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),

            // scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // color: Colors.red,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DetailsOfServiceScreen(
                              sId: _mainServiceList![index].id.toString(),
                              serviceName: _mainServiceList![index].name,
                              // a: widget.analytics,
                              // o: widget.observer,
                              serviceImage: _mainServiceList![index].image)),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: CachedNetworkImage(
                          imageUrl: global.baseUrlForImage +
                              _mainServiceList![index].image!,
                          imageBuilder: (context, imageProvider) => Card(
                            // margin:
                            //     EdgeInsets.only(left: 4, right: 4, bottom: 4),
                            child: Container(
                              // width: 120,
                              // height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider),
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Container(
                            margin:
                                EdgeInsets.only(left: 4, right: 4, bottom: 4),
                            width: 120,
                            height: 50,
                            child: Card(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Text(
                                    AppLocalizations.of(context)!.lbl_no_image),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Opacity(
                      //   opacity: 0.5,
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 4, right: 4, bottom: 4),
                      //     width: 120,
                      //     height: 50,
                      //     decoration: BoxDecoration(
                      //       color: Colors.black,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),
                      Text(
                        '${_mainServiceList![index].name}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w200,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _shimmer1() {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Card(),
                    radius: 26,
                  ),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 90,
                    child: Card(
                      margin: EdgeInsets.only(left: 5, bottom: 10),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Card(),
              ),
            ],
          ),
        ));
  }

  Widget _shimmer2() {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 100,
                    height: 60,
                    child: Card(
                      margin: EdgeInsets.only(left: 5, right: 5),
                    ),
                  );
                })));
  }

  Widget _shimmer3() {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 170,
                  height: 150,
                  child: Card(
                    margin: EdgeInsets.only(left: 5, right: 5),
                  ),
                );
              }),
        ));
  }

  // Widget _shimmer4() {

  //   return Padding(
  //       padding: const EdgeInsets.all(15),
  //       child: Shimmer.fromColors(
  //         baseColor: Colors.grey[300]!,
  //         highlightColor: Colors.grey[100]!,
  //         child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: 5,
  //             itemBuilder: (BuildContext context, int index) {
  //               return Row(
  //                 children: [
  //                   CircleAvatar(
  //                     radius: 40,
  //                     child: Card(),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                 ],
  //               );
  //             }),
  //       ));
  // }
}
