import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/serviceModel.dart';
import 'package:app/screens/searchScreen.dart';
import 'package:app/screens/serviceDetailScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../models/main_services.dart';
import 'detailsOfServices.dart';

class ServiceListScreen extends BaseRoute {
  ServiceListScreen({a, o}) : super(a: a, o: o, r: 'ServiceListScreen');
  @override
  _ServiceListScreenState createState() => new _ServiceListScreenState();
}

class _ServiceListScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<MainService> _serviceList = [];
  bool _isDataLoaded = false;
  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  ScrollController _scrollController = ScrollController();
  int pageNumber = 0;
  _ServiceListScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.lbl_services,
                style: AppBarTheme.of(context).titleTextStyle),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => SearchScreen(
                                1,
                                // a: widget.analytics,
                                // o: widget.observer,
                              )),
                    );
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: _isDataLoaded
              ? _serviceList.length > 0
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2.5,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 10),
                      controller: _scrollController,
                      physics: ClampingScrollPhysics(),
                      itemCount: _serviceList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 13, right: 13),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsOfServiceScreen(
                                              sId: _serviceList[index]
                                                  .id
                                                  .toString(),
                                              serviceName:
                                                  _serviceList[index].name,
                                              // a: widget.analytics,
                                              // o: widget.observer,
                                              serviceImage:
                                                  _serviceList[index].image)),
                                );
                              },
                              child: Card(
                                elevation: 0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: CachedNetworkImage(
                                        imageUrl: global.baseUrlForImage +
                                            _serviceList[index].image!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          // height: 85,
                                          // width: 125,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: imageProvider)),
                                        ),
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceAround,
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     // Expanded(
                                    //     //   child: Padding(
                                    //     //     padding: global.isRTL
                                    //     //         ? EdgeInsets.only(right: 18)
                                    //     //         : EdgeInsets.only(left: 18),
                                    //     //     child: Column(
                                    //     //       crossAxisAlignment:
                                    //     //           CrossAxisAlignment.start,
                                    //     //       mainAxisSize: MainAxisSize.min,
                                    //     //       children: [
                                    //     //         Text(
                                    //     //           '${_serviceList[index].service_name}',
                                    //     //           style: TextStyle(
                                    //     //             color: Colors.black,
                                    //     //             fontSize: 20,
                                    //     //             fontFamily: 'Cairo',
                                    //     //             fontWeight: FontWeight.w200,
                                    //     //             height: 0,
                                    //     //           ),
                                    //     //           overflow:
                                    //     //               TextOverflow.ellipsis,
                                    //     //           maxLines: 2,
                                    //     //         ),
                                    //     //       ],
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     // Padding(
                                    //     //   padding: const EdgeInsets.all(8.0),
                                    //     //   child:
                                    //     //       Icon(Icons.keyboard_arrow_right),
                                    //     // )
                                    //   ],
                                    // ),
                                    Text(
                                      '${_serviceList[index].name}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w200,
                                        height: 0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    )
                  : Center(
                      child: Text(
                        AppLocalizations.of(context)!
                            .txt_service_will_shown_here,
                        style: Theme.of(context).primaryTextTheme.titleSmall,
                      ),
                    )
              : _shimmer()),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _getServices() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });

          if (_serviceList.isEmpty) {
            pageNumber = 1;
          } else {
            pageNumber++;
          }
          await apiHelper!.getMainServices(type: 'service').then((result) {
            if (result != null) {
              if (result.status == "1") {
                List<MainService> _tList = result.recordList;
                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }
                _serviceList.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              } else {
                _serviceList = [];
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - serviceListScreen.dart - _getServices():" +
          e.toString());
    }
  }

  _init() async {
    try {
      await _getServices();
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            !_isMoreDataLoaded) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          await _getServices();
          setState(() {
            _isMoreDataLoaded = false;
          });
        }
      });
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - serviceListScreen.dart - _init():" + e.toString());
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
            itemCount: 8,
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
                            child: Card(
                                margin: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 5)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 120,
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
      ),
    );
  }
}
