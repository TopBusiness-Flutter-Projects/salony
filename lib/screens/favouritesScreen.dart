import 'dart:async';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/businessLayer/shared_prefrence.dart';
import 'package:app/models/favoriteModel.dart';
import 'package:app/screens/cartScreen.dart';
import 'package:app/screens/productDetailScreen.dart';
import 'package:app/screens/searchScreen.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

Favorites? favoritesList;

class FavouritesScreen extends BaseRoute {
  FavouritesScreen({a, o}) : super(a: a, o: o, r: 'FavouritesScreen');
  @override
  _FavouritesScreenState createState() => new _FavouritesScreenState();
}

class _FavouritesScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  bool _isDataLoaded = false;

  _FavouritesScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: sc(Scaffold(
          appBar: AppBar(
            title: Text(
              'المفضلة', // AppLocalizations.of(context)!.lbl_favourites,
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            automaticallyImplyLeading: false,
            actions: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //             builder: (context) => SearchScreen(
              //                   0,
              //                   a: widget.analytics,
              //                   o: widget.observer,
              //                 )),
              //       );
              //     },
              //     icon: Icon(Icons.search)),
              // _isDataLoaded
              //     ? Container(
              //         margin: EdgeInsets.only(top: 3),
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //         child: badges.Badge(
              //           badgeStyle: badges.BadgeStyle(
              //               padding: EdgeInsets.all(5),
              //               badgeColor: Theme.of(context).primaryColor),
              //           showBadge: true,
              //           badgeContent: Text(
              //             '${myCartCount <= 0 ? 0 : myCartCount}', // '${global.user!.cart_count}',
              //             style: TextStyle(color: Colors.white, fontSize: 15),
              //           ),
              //           child: GestureDetector(
              //             onTap: () {
              //               print('0000000000000000000000000000000001');
              //               Navigator.of(context).push(MaterialPageRoute(
              //                   builder: (context) => CartScreen(
              //                         a: widget.analytics,
              //                         o: widget.observer,
              //                         screenId: 1,
              //                       )));
              //             },
              //             child: Icon(
              //               Icons.shopping_cart_outlined,
              //               size: 25,
              //               color: Colors.black,
              //             ),
              //           ),
              //         ),
              //       )
              //     : SizedBox(),
            ],
          ),
          resizeToAvoidBottomInset: true,
          body: (global.user?.id == null)
              ? Center(
                  child: Text("لا يوجد منتاجات في المفضله"),
                )
              : _isDataLoaded
                  ? favoritesList != null && favoritesList!.fav_items.length > 0
                      ? _productListWidget()
                      : Center(
                          child: Text(
                            AppLocalizations.of(context)!
                                .txt_nothing_is_yet_to_see_here,
                            style:
                                Theme.of(context).primaryTextTheme.titleSmall,
                          ),
                        )
                  : _shimmer())),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        print('5555555555555555');
      });
    });
    super.initState();
    // if (global.user!.id == null) {
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

  Future<bool> _addToCart(int quantity, int? id) async {
    bool _isSucessfullyAdded = false;
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!
            .addToCart(global.user!.id, id, quantity)
            .then((result) {
          if (result != null) {
            if (result.status == "1") {
              _isSucessfullyAdded = true;
              setState(() {});

              _getFavoriteList();
            } else {}
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      return _isSucessfullyAdded;
    } catch (e) {
      print("Exception - favoritesScreen.dart - _addToCart():" + e.toString());
      return _isSucessfullyAdded;
    }
  }

  Future<bool> _delFromCart(int? id) async {
    bool _isDeletedSuccessfully = false;
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.delFromCart(global.user!.id, id).then((result) {
          if (result != null) {
            if (result.status == "1" && global.user?.cart_count != null) {
              _isDeletedSuccessfully = true;
              global.user!.cart_count = global.user!.cart_count! > 0
                  ? global.user!.cart_count! - 1
                  : 0;
              setState(() {});
            } else {}
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      return _isDeletedSuccessfully;
    } catch (e) {
      print(
          "Exception - favouritesScreen.dart - _delFromCart():" + e.toString());
      return _isDeletedSuccessfully;
    }
  }

  _getFavoriteList() async {
    print("000000000000 SSFF ${global.user?.id == null} xx");

    if (global.user?.id == null) {
      print("000000000000 SS ${global.user?.id == null} xx");

      favoritesList = null;
    } else {
      try {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          print("000000000000 ${global.user!.id.toString()} xx");

          await apiHelper!.getFavoriteList(global.user!.id).then((result) {
            if (result != null) {
              if (result.status == "1") {
                favoritesList = result.recordList;
                _isDataLoaded = true;
              } else if (result.status == "0") {
                favoritesList = null;
                _isDataLoaded = true;
              }
              setState(() {});
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } catch (e) {
        print("Exception - favoritesScreen.dart - _getFavoriteList():" +
            e.toString());
      }
    }
  }

  _init() async {
    await _getFavoriteList();
  }

  List<Widget> _productList() {
    List<Widget> productList = [];
    for (int index = 0; index < favoritesList!.fav_items.length; index++) {
      productList.add(InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      favoritesList!.fav_items[index].id,
                      a: widget.analytics,
                      o: widget.observer,
                      isShowGoCartBtn:
                          favoritesList!.fav_items[index].cart_qty != null &&
                                  favoritesList!.fav_items[index].cart_qty! > 0
                              ? true
                              : false,
                    )),
          );
        },
        child: SizedBox(
          height: (MediaQuery.of(context).size.width / 1.93),
          width: (MediaQuery.of(context).size.width / 2) - 17,
          child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Flexible(
                child: favoritesList!.fav_items[index].product_image != null
                    ? CachedNetworkImage(
                        imageUrl: global.baseUrlForImage +
                            favoritesList!.fav_items[index].product_image!,
                        imageBuilder: (context, imageProvider) => Container(
                          height:
                              (((MediaQuery.of(context).size.width / 2) - 15) *
                                      1.4) *
                                  0.55,
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: imageProvider)),
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () async {
                                await (_removeFromFavorites(
                                        favoritesList!.fav_items[index].id)
                                    .then((_isFav) {
                                  _getFavoriteList();
                                  print(
                                      "_isFav 4 $_isFav s: ${favoritesList!.fav_items.length}  : index : $index");
                                  if (_isFav ?? true) {
                                    favoritesList!.fav_items.removeAt(index);
                                    print(
                                        "_isFav 4 : ${favoritesList!.fav_items.length}  : index : $index");
                                  }
                                  setState(() {});
                                }));
                              },
                              icon: Icon(Icons.favorite,
                                  color: Color(0xFFF36D86))),
                        ),
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : Container(
                        height:
                            (((MediaQuery.of(context).size.width / 2) - 15) *
                                    1.4) *
                                0.72,
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          AppLocalizations.of(context)!.lbl_no_image,
                          style: Theme.of(context).primaryTextTheme.titleMedium,
                        )),
              ),
              SizedBox(
                height: 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          width: 100,
                          child: Text(
                            '${favoritesList!.fav_items[index].product_name}',
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).primaryTextTheme.displaySmall,
                          ),
                        ),
                      ),
                      Text(
                          '${global.currency.currency_sign}${favoritesList!.fav_items[index].price}',
                          style: Theme.of(context).primaryTextTheme.titleMedium)
                    ],
                  ),
                ),
              ),
              favoritesList!.fav_items[index].cart_qty == null ||
                      (favoritesList!.fav_items[index].cart_qty != null &&
                          favoritesList!.fav_items[index].cart_qty == 0)
                  ? GestureDetector(
                      onTap: () async {
                        showOnlyLoaderDialog();
                        int _qty = 1;
                        bool isSuccess = await _addToCart(
                            _qty, favoritesList!.fav_items[index].id);
                        if (isSuccess && global.user?.cart_count != null) {
                          favoritesList!.fav_items[index].cart_qty = 1;
                          global.user!.cart_count =
                              global.user!.cart_count! + 1;
                          await setCartCount();
                          await getCartCount();
                          myCartCount++;
                          print('00000000000000$myCartCount');
                          setState(() {});
                        } else {
                          favoritesList!.fav_items[index].cart_qty = 1;
                          // global.user!.cart_count =
                          //     global.user!.cart_count! + 1;
                          await setCartCount();
                          await getCartCount();
                          myCartCount++;
                          print('00000000000000 : $myCartCount');
                          setState(() {});
                        }
                        hideLoader();
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                              size: 16,
                            ),
                            Flexible(
                              child: Text(
                                  AppLocalizations.of(context)!.lbl_add_to_cart,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium),
                            )
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 25,
                              width: 25,
                              child: TextButton(
                                onPressed: () async {
                                  showOnlyLoaderDialog();
                                  if (favoritesList!
                                          .fav_items[index].cart_qty ==
                                      1) {
                                    bool isSuccess = await _delFromCart(
                                        favoritesList!.fav_items[index].id);
                                    if (isSuccess) {
                                      favoritesList!.fav_items[index].cart_qty =
                                          0;
                                    }
                                    favoritesList!.fav_items[index].cart_qty =
                                        0;

                                    await setCartCount(
                                        count: favoritesList!
                                                .fav_items[index].cart_qty! -
                                            1);
                                    await getCartCount();
                                    myCartCount =
                                        myCartCount < 0 ? 0 : myCartCount - 1;
                                  } else {
                                    int _qty = favoritesList!
                                            .fav_items[index].cart_qty! -
                                        1;

                                    bool isSuccess = await _addToCart(_qty,
                                        favoritesList!.fav_items[index].id);
                                    if (isSuccess &&
                                        favoritesList
                                                ?.fav_items[index].cart_qty !=
                                            null) {
                                      favoritesList!.fav_items[index].cart_qty =
                                          favoritesList!
                                                  .fav_items[index].cart_qty! -
                                              1;
                                    }
                                  }

                                  hideLoader();
                                  setState(() {});
                                },
                                child:
                                    favoritesList!.fav_items[index].cart_qty ==
                                            1
                                        ? Icon(
                                            Icons.delete,
                                            size: 11,
                                          )
                                        : Icon(
                                            FontAwesomeIcons.minus,
                                            size: 11,
                                          ),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            margin: EdgeInsets.all(2),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              border: Border.all(
                                  width: 1.0,
                                  color: Theme.of(context).primaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Text(
                              "${favoritesList!.fav_items[index].cart_qty}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                              height: 25,
                              width: 25,
                              child: TextButton(
                                onPressed: () async {
                                  showOnlyLoaderDialog();
                                  int _qty = favoritesList!
                                          .fav_items[index].cart_qty! +
                                      1;
                                  bool isSuccess = await _addToCart(
                                      _qty, favoritesList!.fav_items[index].id);
                                  if (isSuccess &&
                                      favoritesList
                                              ?.fav_items[index].cart_qty !=
                                          null) {
                                    favoritesList!.fav_items[index].cart_qty =
                                        favoritesList!
                                                .fav_items[index].cart_qty! +
                                            1;
                                  }
                                  hideLoader();
                                  // await setCartCount(
                                  //     count: favoritesList!
                                  //             .fav_items[index].cart_qty! +
                                  //         1);
                                  // await getCartCount();
                                  // myCartCount++;
                                  setState(() {});
                                },
                                child: Icon(
                                  FontAwesomeIcons.plus,
                                  size: 10,
                                ),
                              ))
                        ],
                      ),
                    )
            ]),
          ),
        ),
      ));
    }
    return productList;
  }

  _productListWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 10,
            left: favoritesList!.fav_items.length == 1 ? 15 : 5,
            right: 5,
            top: 15),
        child: Align(
          alignment: favoritesList!.fav_items.length == 1
              ? global.isRTL
                  ? Alignment.centerRight
                  : Alignment.centerLeft
              : Alignment.center,
          child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 12,
              children: _productList()),
        ),
      ),
    );
  }

  Future<bool?> _removeFromFavorites(int? id) async {
    bool _isFav = false;
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.addToFavorite(global.user!.id, id).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _isFav = true;
              print("_isFav : $_isFav");
              setState(() {});
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      return _isFav;
    } catch (e) {
      print("Exception - favoritesScreen.dart - _removeFromFavorites():" +
          e.toString());
      return null;
    }
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: GridView.count(
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            children: List.generate(
                8,
                (index) => SizedBox(
                      child: Card(
                          margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                    )),
          )),
    );
  }
}
