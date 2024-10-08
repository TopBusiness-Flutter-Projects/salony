import 'package:app/models/bookAppointmentModel.dart';
import 'package:app/models/bookNowModel.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/couponsModel.dart';
import 'package:app/models/serviceTypeModel.dart';
import 'package:app/screens/paymentGatewaysScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class BookAppointmentScreen extends BaseRoute {
  final int? vendorId;
  BookAppointmentScreen(this.vendorId, {a, o})
      : super(a: a, o: o, r: 'BookAppointmentScreen');
  @override
  _BookAppointmentScreenState createState() =>
      new _BookAppointmentScreenState(this.vendorId);
}

class _BookAppointmentScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Coupons>? _couponsList = [];
  bool _isCouponDataLoaded = false;
  BookNow? _bookNowDetails;
  BookNow? _applyRewardsOrCoupons;
  String? selectedCouponCode;
  int? vendorId;
  String? selectedTimeSlot = '';
  String? barberName;
  int selectedStaffId = 0;
  List<ServiceType> _selectedServiceType = [];
  BookAppointment? _bookingAppointment;
  bool _isDataLoaded = false;
  int _currentIndex = 0;
  int? selectedCoupon;
  PageController? _pageController;
  ScrollController? _scrollController;
  TabController? _tabController;
  DateTime? selectedDate;
  int _initialIndex = 0;
  bool step1Done = false;
  bool step2Done = false;
  bool step3Done = false;
  bool step4Done = false;
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  DatePickerController _datePickerController = DatePickerController();
  int in_door = 1;
  // String isInDoor = 'داخل الصالون';
  int _changeval = 7;
  _BookAppointmentScreenState(this.vendorId) : super();

  @override
  Widget build(BuildContext context) {
    List<String> _appointmentList = [
      AppLocalizations.of(context)!.lbl_choose_service,
      AppLocalizations.of(context)!.lbl_appointment,
      AppLocalizations.of(context)!.lbl_summary,
      AppLocalizations.of(context)!.lbl_payment
    ];

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.txt_book_an_appointment,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          leading: _currentIndex == 0
              ? null
              : IconButton(
                  onPressed: () {
                    _pageController!.animateToPage(_currentIndex - 1,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn);
                    if (_currentIndex == 0) {
                      step1Done = false;
                    }
                    if (_currentIndex == 1) {
                      step2Done = false;
                    }
                    if (_currentIndex == 2) {
                      step3Done = false;
                    }

                    setState(() {});
                  },
                  icon: Icon(Icons.arrow_back)),
          automaticallyImplyLeading: _currentIndex == 0 ? true : false,
        ),
        bottomNavigationBar: _isDataLoaded
            ? BottomAppBar(
                color: Color(0xFF171D2C),
                child: SizedBox(
                  height: _currentIndex == 3 ? 55 : 60,
                  width: double.infinity,
                  child: _currentIndex == 3
                      ? Card(
                          color: Color(0xFF3E424D),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          child: Stack(
                            children: [
                              // Padding(
                              //   padding: EdgeInsets.all(
                              //       MediaQuery.of(context).size.width / 22),
                              //   child: Align(
                              //     alignment: Alignment.center,
                              //     child: Text(
                              //       AppLocalizations.of(context)
                              //               ?.txt_swipe_to_confirm_your_booking ??
                              //           '',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Dismissible(
                                background: Card(
                                  elevation: 0,
                                  // child: Center(
                                  //   child: Text(
                                  //     AppLocalizations.of(context)
                                  //             ?.txt_swipe_to_confirm_your_booking ??
                                  //         '',
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //     ),
                                  //   ),
                                  // ),
                                  color: Color(0xFFF36D86),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                ),
                                key: Key(_currentIndex.toString()),
                                onDismissed: (_) {},
                                confirmDismiss: (_) async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentGatewayScreen(
                                              // a: widget.analytics,
                                              // o: widget.observer,
                                              bookNowDetails: _bookNowDetails,
                                              screenId: 1,
                                            )),
                                  );
                                  return true;
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF36D86),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        width: 60,
                                        height: 55,
                                        child: Transform.rotate(
                                          angle: 0,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            // size: 20.0,
                                          ),
                                        )),
                                    Center(
                                      child: Text(
                                        AppLocalizations.of(context)
                                                ?.txt_swipe_to_confirm_your_booking ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListTile(
                          tileColor: Colors.transparent,
                          title: RichText(
                              text: TextSpan(
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium,
                                  children: [
                                TextSpan(
                                    text: AppLocalizations.of(context)
                                            ?.lbl_total_cost ??
                                        ''),
                                TextSpan(
                                    text:
                                        '${global.currency.currency_sign ?? 'SAR'} ${_getTotalCost()}')
                              ])),
                          trailing: Container(
                            width: 120,
                            height: 35,
                            child: TextButton(
                              onPressed: () async {
                                if (_currentIndex == 3) {
                                  return null;
                                } else {
                                  if (_currentIndex == 0) {
                                    if (_selectedServiceType.length == 0) {
                                      showSnackBar(
                                          key: _scaffoldKey,
                                          snackBarMessage: AppLocalizations.of(
                                                  context)!
                                              .txt_please_select_atleast_one_service_to_procceed);
                                    } else {
                                      _pageController!.animateToPage(
                                          _currentIndex + 1,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn);
                                    }

                                    step1Done = true;
                                  }
                                  if (_currentIndex == 1) {
                                    if (selectedTimeSlot == '') {
                                      showSnackBar(
                                          key: _scaffoldKey,
                                          snackBarMessage: AppLocalizations.of(
                                                  context)!
                                              .txt_please_select_timeslot_to_procceed);
                                    } else {
                                      _pageController!.animateToPage(
                                          _currentIndex + 1,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn);

                                      for (int i = 0;
                                          i <
                                              _bookingAppointment!
                                                  .barber.length;
                                          i++) {
                                        if (_bookingAppointment!
                                                .barber[i].staff_id ==
                                            _bookingAppointment!.staff_id) {
                                          barberName = _bookingAppointment!
                                              .barber[i].staff_name;
                                        }
                                      }
                                      step2Done = true;
                                    }
                                  }
                                  if (_currentIndex == 2) {
                                    _pageController!.animateToPage(
                                        _currentIndex + 1,
                                        duration: Duration(seconds: 1),
                                        curve: Curves.fastOutSlowIn);
                                    step3Done = true;
                                    await _bookNow(in_door: in_door);
                                  }
                                  setState(() {});
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(AppLocalizations.of(context)!.lbl_next),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              )
            : null,
        body: _isDataLoaded
            ? (_bookingAppointment?.services.length ?? 0) > 0
                ? Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 20,
                        margin: EdgeInsets.only(
                            left: 10, right: 10, bottom: 0, top: 10),
                        child: Center(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _scrollController,
                              itemCount: _appointmentList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int i) {
                                return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: (i == _currentIndex) ||
                                                (i == 0 && step1Done) ||
                                                (i == 1 && step2Done) ||
                                                (i == 2 && step3Done)
                                            ? Color(0xFFF36D86)
                                            : Colors.grey,
                                      ),
                                      i == 3
                                          ? SizedBox()
                                          : Container(
                                              height: 2,
                                              color: (i == _currentIndex - 1) ||
                                                      (i == 1 - 1 &&
                                                          step2Done) ||
                                                      ((i == 2 - 1 &&
                                                          step3Done))
                                                  ? Color(0xFFF36D86)
                                                  : Colors.black,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75 /
                                                  4,
                                              margin: EdgeInsets.all(0),
                                            ),
                                    ]);
                              }),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(0),
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int j) {
                              return Container(
                                alignment: Alignment.center,
                                width:
                                    (MediaQuery.of(context).size.width) / 4.3,
                                child: Text('${_appointmentList[j]}',
                                    style: TextStyle(
                                        fontSize:
                                            j == _currentIndex ? 10.5 : 9.5,
                                        color: j == _currentIndex
                                            ? Color(0xFF171D2C)
                                            : Color(0xFF898A8D),
                                        fontWeight: j == _currentIndex
                                            ? FontWeight.w600
                                            : FontWeight.w400)),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (index) {
                            _currentIndex = index;
                            double currentIndex = _currentIndex.toDouble();
                            _scrollController!.animateTo(currentIndex,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn);
                            setState(() {});
                          },
                          children: [
                            _chooseService(),
                            _appointment(),
                            _summary(),
                            _payment(),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      AppLocalizations.of(context)!
                          .txt_nothing_is_yet_to_see_here,
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  )
            : _shimmer(),
        floatingActionButton: _currentIndex != 0
            ? null
            : FlutterToggleTab(
                // isShadowEnable: false,

                borderRadius: 15,
                height: MediaQuery.of(context).size.width / 12,
                selectedIndex: in_door,
                selectedTextStyle: TextStyle(
                    color: Colors.white,
                    // fontSize: 18,
                    fontWeight: FontWeight.w600),

                unSelectedTextStyle: TextStyle(
                    color: Colors.white54,
                    // fontSize: 14,
                    fontWeight: FontWeight.w400),
                width: MediaQuery.of(context).size.width / 10,
                labels: ['بالمنزل', 'بالصالون'],

                selectedLabelIndex: (index) {
                  setState(() {
                    in_door = (in_door == 0) ? 1 : 0;
                    //! 1 > inDoor
                  });
                  print(in_door);
                },
                marginSelected:
                    EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('vendorId : xx $vendorId');
    _getTimeSlot();
    _tabController = new TabController(length: 2, vsync: this);
    _scrollController =
        new ScrollController(initialScrollOffset: _currentIndex.toDouble());
    _pageController = new PageController(initialPage: _currentIndex);
    _pageController!.addListener(() {});
    _init();
  }

  _applyRewardsAndCoupons(String type) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        type == "coupon"
            ? await apiHelper!
                .applyRewardsAndCoupons(_bookNowDetails!.cart_id, "coupon",
                    coupon_code: selectedCouponCode)
                .then((result) {
                if (result != null) {
                  if (result.status == "1") {
                    _applyRewardsOrCoupons = result.recordList;
                    _bookNowDetails!.reward_discount = '${0}';
                    _bookNowDetails!.reward_discount =
                        _applyRewardsOrCoupons!.reward_discount;
                    _bookNowDetails!.coupon_discount =
                        _applyRewardsOrCoupons!.coupon_discount;
                    _bookNowDetails!.total_price =
                        _applyRewardsOrCoupons!.total_price;
                    _bookNowDetails!.rem_price =
                        _applyRewardsOrCoupons!.rem_price;

                    setState(() {});
                  } else {
                    showSnackBar(
                        key: _scaffoldKey,
                        snackBarMessage: result.message.toString());
                  }
                }
              })
            : await apiHelper!
                .applyRewardsAndCoupons(_bookNowDetails!.cart_id, "rewards")
                .then((result) {
                if (result != null) {
                  if (result.status == "1") {
                    _applyRewardsOrCoupons = result.recordList;
                    _applyRewardsOrCoupons!.coupon_discount = '${0}';
                    _bookNowDetails!.coupon_discount =
                        _applyRewardsOrCoupons!.coupon_discount;
                    _bookNowDetails!.total_price =
                        _applyRewardsOrCoupons!.total_price;
                    _bookNowDetails!.rem_price =
                        _applyRewardsOrCoupons!.rem_price;
                    _bookNowDetails!.reward_discount =
                        _applyRewardsOrCoupons!.reward_discount;

                    setState(() {});
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
          "Exception - bookAppointmentScreen.dart - _applyRewardsAndCoupons():" +
              e.toString());
    }
  }

  Widget _appointment() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _changeval < 1
                    ? SizedBox(
                        width: 48,
                      )
                    : IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text(
                        DateFormat('MMMM').format(DateTime.now()),
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headlineMedium!
                                .color),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              height: 100,
              child: DatePicker(
                DateTime.now(),
                controller: _datePickerController,
                dateTextStyle: Theme.of(context).primaryTextTheme.titleSmall!,
                dayTextStyle: Theme.of(context).primaryTextTheme.titleMedium!,
                monthTextStyle: Theme.of(context).primaryTextTheme.bodyLarge!,
                initialSelectedDate:
                    DateTime.parse(_bookingAppointment!.selected_date!),
                selectionColor: Color(0xFFF36D86),
                selectedTextColor: Colors.white,
                daysCount: 10,
                onDateChange: (date) {
                  setState(() {
                    _bookingAppointment!.selected_date =
                        DateFormat('yyyy-MM-dd').format(date);
                    selectedDate = date;
                    _getTimeSlot();
                  });
                },
              ),
            ),
          ),
          Container(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 5 / 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 8,
              children: List.generate(
                  _bookingAppointment!.time_slot!.length,
                  (index) => GestureDetector(
                        onTap: _bookingAppointment!
                                    .time_slot![index].availibility ==
                                true
                            ? () {
                                selectedTimeSlot = _bookingAppointment!
                                    .time_slot![index].timeslot;

                                setState(() {});
                              }
                            : null,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: selectedTimeSlot != '' &&
                                  selectedTimeSlot ==
                                      _bookingAppointment!
                                          .time_slot![index].timeslot
                              ? Color(0xFFF36D86)
                              : _bookingAppointment!
                                          .time_slot![index].availibility ==
                                      true
                                  ? Color(0xFFDADADA)
                                  : Colors.white,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              _bookingAppointment!.time_slot![index].timeslot!,
                              style: selectedTimeSlot != '' &&
                                      selectedTimeSlot ==
                                          _bookingAppointment!
                                              .time_slot![index].timeslot
                                  ? TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400)
                                  : _bookingAppointment!
                                              .time_slot![index].availibility ==
                                          true
                                      ? Theme.of(context)
                                          .primaryTextTheme
                                          .bodyMedium
                                      : TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.withOpacity(0.5),
                                          fontWeight: FontWeight.w400),
                            ),
                          )),
                        ),
                      )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 15,
                    width: 15,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Color(0xFFF36D86),
                    )),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    AppLocalizations.of(context)!.lbl_available_slot,
                    style: Theme.of(context).primaryTextTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: AppLocalizations.of(context)!.lbl_choose_hair_specialist,
                style: Theme.of(context).primaryTextTheme.titleSmall,
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.lbl_optional,
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
            ])),
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                scrollDirection: Axis.horizontal,
                itemCount: _bookingAppointment!.barber.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      _bookingAppointment!.staff_id =
                          _bookingAppointment!.barber[index].staff_id;
                      await _getTimeSlot();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 7, right: 7),
                      child: SizedBox(
                        width: 200,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: global.isRTL
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(10),
                                    )
                                  : BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(30),
                                    )),
                          color: _bookingAppointment!.staff_id ==
                                  _bookingAppointment!.barber[index].staff_id
                              ? Color(0xFFF36D86)
                              : Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: global.baseUrlForImage +
                                    _bookingAppointment!
                                        .barber[index].staff_image!,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 30,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${_bookingAppointment!.barber[index].staff_name}',
                                  style: _bookingAppointment!.staff_id ==
                                          _bookingAppointment!
                                              .barber[index].staff_id
                                      ? Theme.of(context)
                                          .primaryTextTheme
                                          .labelSmall
                                      : Theme.of(context)
                                          .primaryTextTheme
                                          .titleSmall,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  _bookAppointment() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.bookAppointment(vendorId).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _bookingAppointment = result.recordList;
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
      print("Exception - bookAppointmentScreen.dart - _bookAppointment():" +
          e.toString());
    }
  }

  _bookNow({required int in_door}) async {
    try {
      BookNow _bookNow = new BookNow();
      _bookNow.time_slot = selectedTimeSlot;
      _bookNow.delivery_date = _bookingAppointment!.selected_date;
      _bookNow.staff_id = _bookingAppointment!.staff_id;
      _bookNow.user_id = global.user!.id;
      _bookNow.vendor_id = _bookingAppointment!.vendor_id;
      _bookNow.serviceTypeVarientIdList = _selectedServiceType;
      _bookNow.in_door = in_door;

      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.bookNow(_bookNow).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _bookNowDetails = result.recordList;
              await _getCouponsList(_bookNowDetails!.cart_id);

              setState(() {});
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
      print("Exception - bookAppointmentScreen.dart - _bookNow():" +
          e.toString());
    }
  }

  Widget _chooseService() {
    return ListView.builder(
        itemCount: _bookingAppointment!.services.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
            child: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[400]!, width: 0.5),
                  borderRadius: BorderRadius.circular(3)),
              color: Color(0xFFEEEEEE),
              child: ExpansionTile(
                initiallyExpanded: true,
                backgroundColor: Colors.transparent,
                collapsedBackgroundColor: Colors.transparent,
                tilePadding: EdgeInsets.only(left: 16, right: 5),
                textColor: Color(0xFFFEDAA3A),
                collapsedTextColor: Color(0xFFF543520),
                iconColor: Color(0xFF565656),
                collapsedIconColor: Color(0xFF565656),
                childrenPadding: EdgeInsets.all(0),
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(global.baseUrlForImage +
                          (_bookingAppointment!.services[index].service_image ??
                              "")),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                            "${_bookingAppointment!.services[index].service_name}",
                            maxLines: 1,
                            style:
                                Theme.of(context).primaryTextTheme.titleSmall),
                      ),
                    ),
                  ],
                ),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _bookingAppointment!
                          .services[index].service_type.length,
                      itemBuilder: (BuildContext context, int i) {
                        int? hr;
                        hr = _bookingAppointment!
                            .services[index].service_type[i].time;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: SizedBox(
                                height: 65,
                                child: ListTile(
                                  leading: Image.network(
                                    global.baseUrlForImage +
                                        (_bookingAppointment!
                                                .services[index]
                                                .service_type[i]
                                                .varient_image ??
                                            ""),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/logo.png',
                                      );
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(2),
                                  tileColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey[100]!, width: 0.5),
                                  ),
                                  title: Container(
                                    // color: Colors.red,
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Text(
                                      '${_bookingAppointment!.services[index].service_type[i].varient}',
                                      textAlign: TextAlign.justify,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                // iconSize: 12,
                                                onPressed: () {
                                                  _bookingAppointment!
                                                          .services[index]
                                                          .service_type[i]
                                                          .qty =
                                                      _bookingAppointment!
                                                              .services[index]
                                                              .service_type[i]
                                                              .qty! +
                                                          1;
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.add_circle_outlined,
                                                  color: Color(0xFFF36D86),
                                                )),
                                            Flexible(
                                                // fit: FlexFit.tight,
                                                child: Text(_bookingAppointment!
                                                    .services[index]
                                                    .service_type[i]
                                                    .qty
                                                    .toString())),
                                            IconButton(
                                                // iconSize: 12,
                                                onPressed: () {
                                                  _bookingAppointment!
                                                              .services[index]
                                                              .service_type[i]
                                                              .qty! >
                                                          1
                                                      ? _bookingAppointment!
                                                              .services[index]
                                                              .service_type[i]
                                                              .qty =
                                                          _bookingAppointment!
                                                                  .services[
                                                                      index]
                                                                  .service_type[
                                                                      i]
                                                                  .qty! -
                                                              1
                                                      : null;
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.remove_circle_outlined,
                                                  color: Color(0xFFF36D86),
                                                ))
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: Color(0xFF898A8D),
                                        indent: 13,
                                        endIndent: 13,
                                        thickness: 1,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              // width: 50,
                                              child: Text(
                                                  ' ${global.currency.currency_sign ?? 'SAR'}${_bookingAppointment!.services[index].service_type[i].price}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w400))),
                                          Container(
                                              alignment: Alignment.centerRight,
                                              // width: 65,
                                              child: Text('$hr m',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFF898A8D),
                                                      fontWeight:
                                                          FontWeight.w400))),
                                        ],
                                      ),
                                      Container(
                                        child: IconButton(
                                            iconSize: 20,
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              if (_selectedServiceType.contains(
                                                  _bookingAppointment!
                                                      .services[index]
                                                      .service_type[i])) {
                                                _selectedServiceType.remove(
                                                    _bookingAppointment!
                                                        .services[index]
                                                        .service_type[i]);
                                              } else {
                                                _selectedServiceType.add(
                                                  _bookingAppointment!
                                                      .services[index]
                                                      .service_type[i],
                                                );
                                              }
                                              setState(() {});
                                            },
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            icon: _selectedServiceType.contains(
                                                    _bookingAppointment!
                                                        .services[index]
                                                        .service_type[i])
                                                ? Icon(Icons.circle)
                                                : Icon(Icons.circle_outlined)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
          );
        });
  }

  TextEditingController coupunController = TextEditingController();
  _getCouponsList(String? cartId) async {
    try {
      print(".........$cartId");
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper!.getCouponsList(cartId).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _couponsList = result.recordList;
              _isCouponDataLoaded = true;
              setState(() {});
            } else {
              _couponsList = [];
              _isCouponDataLoaded = true;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - bookAppointmentScreen.dart - _getCouponsList():" +
          e.toString());
    }
  }

  _getTimeSlot() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        print('.....xx..${_bookingAppointment!.selected_date}');
        await apiHelper!
            .getTimeSLot(_bookingAppointment!.selected_date,
                _bookingAppointment!.staff_id, _bookingAppointment!.vendor_id)
            .then((result) {
          if (result != null) {
            if (result.status == "1") {
              _bookingAppointment!.time_slot = result.recordList;
              selectedTimeSlot = '';
              setState(() {});
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
      print("Exception - bookAppointmentScreen.dart - _getTimeSlot():" +
          e.toString());
    }
  }

  String _getTotalCost() {
    int cost = 0;
    for (int i = 0; i < _selectedServiceType.length; i++) {
      cost += _selectedServiceType[i].price! * _selectedServiceType[i].qty!;
    }
    return cost.toString();
  }

  _init() async {
    try {
      await _bookAppointment();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - bookAppointmentScreen.dart - _init():" + e.toString());
    }
  }

  Widget _payment() {
    return _isCouponDataLoaded
        ? SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: SizedBox(
                    height: 40,
                    child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 0.1,
                        indicatorColor: Colors.transparent,
                        labelPadding: EdgeInsets.only(
                            left: 0.5, right: 0.5, top: 0, bottom: 0),
                        onTap: (index) {
                          _tabController!.animateTo(index);
                          _tabController!.addListener(() {});
                          setState(() {});
                        },
                        controller: _tabController,
                        tabs: [
                          SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Card(
                                  color: _tabController!.index == 0
                                      ? Colors.white
                                      : Color(0xFFDADADA),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Center(
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .lbl_rewards,
                                          style:
                                              _tabController!.index == 0
                                                  ? Theme.of(context)
                                                      .primaryTextTheme
                                                      .headlineSmall
                                                  : Theme.of(context)
                                                      .primaryTextTheme
                                                      .titleSmall)))),
                          SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Card(
                                  color: _tabController!.index == 1
                                      ? Colors.white
                                      : Color(0xFFDADADA),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Center(
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .lbl_coupons,
                                          style:
                                              _tabController!.index == 1
                                                  ? Theme.of(context)
                                                      .primaryTextTheme
                                                      .headlineSmall
                                                  : Theme.of(context)
                                                      .primaryTextTheme
                                                      .titleSmall)))),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: SizedBox(
                    height: 200,
                    child: DefaultTabController(
                      initialIndex: _initialIndex,
                      length: 2,
                      child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${global.user!.rewards}',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headlineMedium,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      MdiIcons.wallet,
                                      size: 18,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .txt_available_reward_points,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                                global.user!.rewards != null &&
                                        global.user!.rewards != 0
                                    ? TextButton(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .lbl_apply),
                                        onPressed: () async {
                                          await _applyRewardsAndCoupons(
                                              AppLocalizations.of(context)!
                                                  .lbl_rewards);
                                        },
                                      )
                                    : SizedBox()
                              ],
                            ),

                            // Center(
                            //     child: _couponsList!.length > 0
                            //         ? ListView.separated(
                            //             itemCount: _couponsList!.length,
                            //             itemBuilder:
                            //                 (BuildContext context, int index) {
                            //               return ListTile(
                            //                 title: Text(
                            //                     '${_couponsList![index].coupon_name}'),
                            //                 subtitle: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text(
                            //                       '${_couponsList![index].coupon_description}',
                            //                       overflow:
                            //                           TextOverflow.ellipsis,
                            //                     ),
                            //                     Text(AppLocalizations.of(
                            //                                 context)!
                            //                             .lbl_validity +
                            //                         ' : ${DateFormat('dd MMM yy').format(_couponsList![index].start_date!)} - ${DateFormat('dd MMM yy').format(_couponsList![index].end_date!)}')
                            //                   ],
                            //                 ),
                            //                 trailing: GestureDetector(
                            //                   onTap: () async {
                            // if (selectedCouponCode ==
                            //     _couponsList![index]
                            //         .coupon_code) {
                            //   selectedCouponCode = null;
                            // } else {
                            //   selectedCouponCode =
                            //       _couponsList![index]
                            //           .coupon_code;
                            //   await _applyRewardsAndCoupons(
                            //       "coupon");
                            // }
                            // setState(() {});
                            //                   },
                            //                   child: selectedCouponCode ==
                            //                           _couponsList![index]
                            //                               .coupon_code
                            //                       ? SizedBox(
                            //                           height: 33,
                            //                           child: Card(
                            //                             shape:
                            //                                 RoundedRectangleBorder(
                            //                                     borderRadius:
                            //                                         BorderRadius
                            //                                             .circular(
                            //                                                 5)),
                            //                             color: Theme.of(context)
                            //                                 .primaryColor,
                            //                             child: Padding(
                            //                               padding:
                            //                                   const EdgeInsets
                            //                                       .all(5),
                            //                               child: Text(
                            //                                   '${_couponsList![index].coupon_code}'),
                            //                             ),
                            //                           ),
                            //                         )
                            //                       : SizedBox(
                            //                           height: 40,
                            //                           child: FDottedLine(
                            //                             color: Theme.of(context)
                            //                                 .primaryColor,
                            //                             dottedLength: 4,
                            //                             space: 2,
                            //                             corner:
                            //                                 FDottedLineCorner
                            //                                     .all(5),
                            //                             child: Padding(
                            //                               padding:
                            //                                   const EdgeInsets
                            //                                       .all(5),
                            //                               child: Text(
                            //                                   '${_couponsList![index].coupon_code}'),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                 ),
                            //               );
                            //             },
                            //             separatorBuilder:
                            //                 (BuildContext context, int index) {
                            //               return Divider(
                            //                 indent: 15,
                            //                 endIndent: 15,
                            //                 color:
                            //                     Theme.of(context).primaryColor,
                            //               );
                            //             },
                            //           )
                            //         : Text(
                            //             AppLocalizations.of(context)!
                            //                 .txt_no_coupons_available,
                            //             style: Theme.of(context)
                            //                 .primaryTextTheme
                            //                 .titleSmall,
                            //           )),
                            // TODO i will make...coupunController
                            Center(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  TextFormField(
                                    controller: coupunController,
                                    decoration: InputDecoration(
                                        hintText: "ادخل كود الكوبون",
                                        border: InputBorder.none),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.20),
                                    child: MaterialButton(
                                      color: Color(0xFFF36D86),
                                      onPressed: () async {
                                        if (selectedCouponCode ==
                                            coupunController.text) {
                                          selectedCouponCode = null;
                                        } else {
                                          selectedCouponCode =
                                              coupunController.text;
                                          await _applyRewardsAndCoupons(
                                              "coupon");
                                        }
                                        setState(() {});
                                      },
                                      child: Text("تطبيق الكوبون"),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.lbl_price_details,
                          style: Theme.of(context).primaryTextTheme.titleLarge),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.lbl_total_cost,
                          style:
                              Theme.of(context).primaryTextTheme.titleMedium),
                      Text(
                          '${global.currency.currency_sign ?? 'SAR'} ${_getTotalCost()}')
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.lbl_rewards + " ",
                          style:
                              Theme.of(context).primaryTextTheme.titleMedium),
                      Text(
                          _bookNowDetails!.reward_discount != null
                              ? '${global.currency.currency_sign ?? 'SAR'} ${_bookNowDetails!.reward_discount}'
                              : '${global.currency.currency_sign ?? 'SAR'} 0',
                          style: Theme.of(context).primaryTextTheme.titleSmall)
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.lbl_coupons + " ",
                          style:
                              Theme.of(context).primaryTextTheme.titleMedium),
                      Text(
                          _bookNowDetails!.coupon_discount != null
                              ? "${global.currency.currency_sign ?? 'SAR'} ${_applyRewardsOrCoupons!.coupon_discount}"
                              : "${global.currency.currency_sign ?? 'SAR'} 0",
                          style: Theme.of(context).primaryTextTheme.titleSmall)
                    ],
                  ),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.lbl_total_amount,
                          style: Theme.of(context).primaryTextTheme.titleLarge),
                      Text(
                          '${global.currency.currency_sign ?? 'SAR'} ${_bookNowDetails!.rem_price}',
                          style: Theme.of(context).primaryTextTheme.titleLarge)
                    ],
                  ),
                ),
              ],
            ),
          )
        : _shimmer1();
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    height: 40,
                    child: Card(
                        margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 220,
                    height: 40,
                    child: Card(
                        margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 220,
                    height: 40,
                    child: Card(
                        margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 200,
                    height: 40,
                    child: Card(
                        margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _shimmer1() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  child: Card(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  child: Card(),
                ),
              ),
              Divider(
                indent: 15,
                endIndent: 15,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 40,
                      child: Card(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: Card(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: Card(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: Card(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: Card(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: Card(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: Card(),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 15,
                endIndent: 15,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 5, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: Card(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: Card(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _summary() {
    List<String?> list = [];
    for (int i = 0; i < _selectedServiceType.length; i++) {
      list.add(_selectedServiceType[i].service_name);
      list = list.toSet().toList();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
              horizontalTitleGap: 0,
              minLeadingWidth: 20,
              contentPadding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              leading: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 4, left: 0, right: 4),
                child: Icon(Icons.alarm, size: 15),
              ),
              title: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 5, left: 4, right: 4),
                child: Text(
                    AppLocalizations.of(context)!.lbl_picking_time +
                        ' : ${DateFormat('dd MMM yy').format(
                          DateTime.parse(_bookingAppointment!.selected_date!),
                        )} $selectedTimeSlot',
                    style: Theme.of(context).primaryTextTheme.labelLarge),
              ),
              trailing: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 0),
                child: Text('',
                    style: Theme.of(context).primaryTextTheme.bodyMedium),
              )),
          ListTile(
            horizontalTitleGap: 0,
            minLeadingWidth: 20,
            contentPadding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            leading: Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 0, right: 4),
              child: Icon(MdiIcons.scissorsCutting, size: 15),
            ),
            title: Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 5, left: 4, right: 4),
              child: Text(
                  AppLocalizations.of(context)!.lbl_barbershop +
                      ' : ${_bookingAppointment!.salon_name}',
                  style: Theme.of(context).primaryTextTheme.labelLarge),
            ),
          ),
          ListTile(
              horizontalTitleGap: 0,
              minLeadingWidth: 20,
              contentPadding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              leading: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 4, left: 0, right: 4),
                child: Icon(Icons.phone_enabled, size: 15),
              ),
              title: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 5, left: 4, right: 4),
                child: Text(
                    AppLocalizations.of(context)!.lbl_services +
                        ' : ${list.join(",")} ',
                    style: Theme.of(context).primaryTextTheme.labelLarge),
              ),
              trailing: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 0),
                child: Text('',
                    style: Theme.of(context).primaryTextTheme.bodyMedium),
              )),
          _bookingAppointment!.vendor_loc == null
              ? Container()
              : ListTile(
                  horizontalTitleGap: 0,
                  minLeadingWidth: 20,
                  contentPadding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 0, right: 4),
                    child: Icon(Icons.location_on_outlined, size: 15),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 5, left: 4, right: 4),
                    child: Text(
                        AppLocalizations.of(context)!.lbl_location +
                            ': ${_bookingAppointment!.vendor_loc}',
                        style: Theme.of(context).primaryTextTheme.labelLarge),
                  ),
                ),
          ListTile(
              horizontalTitleGap: 0,
              minLeadingWidth: 20,
              contentPadding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              leading: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 4, left: 0, right: 4),
                child: Icon(Icons.female, size: 15),
              ),
              title: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 5, left: 4, right: 4),
                child: Text(
                    AppLocalizations.of(context)!.lbl_barber + ': $barberName ',
                    style: Theme.of(context).primaryTextTheme.labelLarge),
              ),
              trailing: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 0),
                child: Text('',
                    style: Theme.of(context).primaryTextTheme.bodyMedium),
              )),
        ],
      ),
    );
  }
}
