import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/screens/bookAppointmentScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../models/details_of_main.dart';
import '../models/details_of_services.dart';
import 'barberShopDescriptionScreen.dart';
import 'serviceDetailScreen.dart';

class DetailsOfServiceScreen extends BaseRoute {
  final String? sId;
  String? serviceImage;
  String? serviceName;
  DetailsOfServiceScreen({
    a,
    o,
    this.sId,
    this.serviceImage,
    this.serviceName,
  }) : super(a: a, o: o, r: 'ServiceDetailScreen');
  @override
  _ServiceDetailScreenState createState() => new _ServiceDetailScreenState(
      sId: sId, serviceImage: serviceImage, serviceName: serviceName);
}

class _ServiceDetailScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  String? sId;
  String? serviceImage;
  String? serviceName;

  bool _isDataLoaded = false;
  int? selectedVendorId;
  List<VendorModel>? _servicesList = [];
  _ServiceDetailScreenState({this.sId, this.serviceName, this.serviceImage})
      : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          appBar: (_servicesList?.isEmpty ?? false) ? AppBar() : null,
          body: SafeArea(
            child: _isDataLoaded
                ? _servicesList!.length > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            CachedNetworkImage(
                              imageUrl: global.baseUrlForImage + serviceImage!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.24,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Colors.transparent
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.center,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: global.isRTL
                                                  ? EdgeInsets.only(
                                                      right: 8, top: 20)
                                                  : EdgeInsets.only(
                                                      right: 8, top: 20),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.black26,
                                                    child: Center(
                                                      child: Icon(
                                                        global.isRTL
                                                            ? MdiIcons
                                                                .chevronRight
                                                            : MdiIcons
                                                                .chevronLeft,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ListTile(
                                          title: Text('$serviceName',
                                              style: TextStyle(
                                                fontFamily: 'cairo',
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(),
                                height:
                                    MediaQuery.of(context).size.height * 0.24,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                    AppLocalizations.of(context)!.lbl_no_image),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: ListView.builder(
                                      // gridDelegate:
                                      //     SliverGridDelegateWithFixedCrossAxisCount(
                                      //         crossAxisCount: 2,
                                      //         childAspectRatio: 3 / 2.5,
                                      //         mainAxisSpacing: 5,
                                      //         crossAxisSpacing: 10),
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: _servicesList!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 10, right: 10),
                                          // margin: const EdgeInsets.only(
                                          //     top: 10, left: 10, right: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(color: Colors.white10)
                                              ]),
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          // color: Colors.red,
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           ServiceDetailScreen(
                                              //               serviceName:
                                              //                   _servicesList![
                                              //                           index]
                                              //                       .serviceName,
                                              //               a: widget.analytics,
                                              //               o: widget.observer,
                                              //               serviceImage:
                                              //                   _servicesList![
                                              //                           index]
                                              //                       .serviceImage)),
                                              // );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            BarberShopDescriptionScreen(
                                                                _servicesList![
                                                                        index]
                                                                    .vendorId,
                                                                a: widget
                                                                    .analytics,
                                                                o: widget
                                                                    .observer)));
                                                  },
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.5,
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: global
                                                              .baseUrlForImage +
                                                          _servicesList![index]
                                                              .vendorLogo!,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Card(
                                                        // margin:
                                                        //     EdgeInsets.only(left: 4, right: 4, bottom: 4),
                                                        child: Container(
                                                          // width: 120,
                                                          // height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    imageProvider),
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(
                                                        margin: EdgeInsets.only(
                                                            left: 4,
                                                            right: 4,
                                                            bottom: 4),
                                                        width: 120,
                                                        height: 50,
                                                        child: Card(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .lbl_no_image),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  fit: FlexFit.tight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BarberShopDescriptionScreen(
                                                                    _servicesList![
                                                                            index]
                                                                        .vendorId,
                                                                    a: widget
                                                                        .analytics,
                                                                    o: widget
                                                                        .observer)),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${_servicesList![index].vendorName ?? ''}',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Color(
                                                                      0xFFF36D86)),
                                                              Text(
                                                                '${_servicesList![index].vendorLoc ?? ''}',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Cairo',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      print(
                                                          _servicesList![index]
                                                              .vendorId);

                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BookAppointmentScreen(
                                                                    _servicesList![
                                                                            index]
                                                                        .vendorId,
                                                                    a: widget
                                                                        .analytics,
                                                                    o: widget
                                                                        .observer)),
                                                      );
                                                    },
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .lbl_book_now)),
                                              ],
                                            ),
                                          ),
                                        );
                                      })),
                            )
                          ])
                    : Center(
                        child: Text(
                          AppLocalizations.of(context)!
                              .txt_nearby_shopw_will_shown_here,
                          style: Theme.of(context).primaryTextTheme.titleSmall,
                        ),
                      )
                : _shimmer(),
          ),
          bottomNavigationBar: _servicesList!.length > 0 &&
                  selectedVendorId != null
              ? Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => BookAppointmentScreen(
                                      selectedVendorId,
                                      a: widget.analytics,
                                      o: widget.observer)),
                            );
                          },
                          child:
                              Text(AppLocalizations.of(context)!.lbl_book_now)),
                    ],
                  ),
                )
              : null),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _getSalonListForServices() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!
            .getDetailsOfMainServices(sId.toString())
            .then((result) {
          if (result != null) {
            if (result.status == "1") {
              _servicesList = result.recordList;
            } else {
              showSnackBar(
                  key: _scaffoldKey,
                  snackBarMessage: result.message.toString());
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - serviceDetailScreen.dart - _getSalonListForServices():" +
              e.toString());
    }
  }

  _init() async {
    try {
      await _getSalonListForServices();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - serviceDetailScreen.dart - _init():" + e.toString());
    }
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 140,
              child: Card(margin: EdgeInsets.only(top: 5, bottom: 15)),
            ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
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
            ),
          ],
        ),
      ),
    );
  }
}
