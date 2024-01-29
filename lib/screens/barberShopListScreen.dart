import 'package:app/models/barberShopModel.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/screens/barberShopDescriptionScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class BarberShopListScreen extends BaseRoute {
  BarberShopListScreen({a, o}) : super(a: a, o: o, r: 'BarberShopListScreen');
  @override
  _BarberShopListScreenState createState() => new _BarberShopListScreenState();
}

class _BarberShopListScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<BarberShop> _barberShopList = [];
  bool _isDataLoaded = false;
  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  ScrollController _scrollController = ScrollController();
  int pageNumber = 0;
  _BarberShopListScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.lbl_barber_shop),
        ),
        body: SafeArea(
          child: _isDataLoaded
              ? _barberShopList.length > 0
              ? ListView.builder(
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            itemCount: _barberShopList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 13, right: 13),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BarberShopDescriptionScreen(_barberShopList[index].vendor_id, a: widget.analytics, o: widget.observer)),
                    );
                  },
                  child: Card(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CachedNetworkImage(
                          imageUrl: global.baseUrlForImage + _barberShopList[index].vendor_logo!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 85,
                            width: 100,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
                          ),
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Container(
                            height: 85,
                            width: 100,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Text(AppLocalizations.of(context)!.txt_no_image_availa)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            isThreeLine: true,
                            title: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '${_barberShopList[index].vendor_name}',
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _barberShopList[index].vendor_loc != null && _barberShopList[index].vendor_loc != "" ? '${_barberShopList[index].vendor_loc}' : 'Location not provided',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).primaryTextTheme.bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                                if (_barberShopList[index].rating != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('${_barberShopList[index].rating}', style: Theme.of(context).primaryTextTheme.bodyText1),
                                        _barberShopList[index].rating != null
                                            ? RatingBar.builder(
                                          initialRating: _barberShopList[index].rating!,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 8,
                                          itemPadding: EdgeInsets.symmetric(horizontal: 0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          ignoreGestures: true,
                                          updateOnDrag: false,
                                          onRatingUpdate: (rating) {

                                          },
                                        )
                                            : SizedBox()
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
              : Center(
            child: Text(
              AppLocalizations.of(context)!.txt_near_by_barbershop_list_will_shown_here,
              style: Theme.of(context).primaryTextTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          )
              : _shimmer(),
        ),
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

  _getNearByBarberShops() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });

          if (_barberShopList.isEmpty) {
            pageNumber = 1;
          } else {
            pageNumber++;
          }
          await apiHelper!.getNearByBarberShops(global.lat, global.lng, pageNumber).then((result) {
            if (result != null) {
              if (result.status == "1") {
                List<BarberShop> _tList = result.recordList;

                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }

                _barberShopList.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              } else {
                _barberShopList = [];
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - barberShopListScreen.dart - _getNearByBarberShops():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getNearByBarberShops();
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isMoreDataLoaded) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          await _getNearByBarberShops();
          setState(() {
            _isMoreDataLoaded = false;
          });
        }
      });
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - barberShopListScreen.dart - _init():" + e.toString());
    }
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Card(margin: EdgeInsets.only(top: 5, bottom: 5)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 220,
                            height: 40,
                            child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 120,
                            height: 40,
                            child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
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
      ),
    );
  }
}
