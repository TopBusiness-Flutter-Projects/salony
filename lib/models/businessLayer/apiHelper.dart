import 'dart:convert';
import 'dart:io';
import 'package:app/models/allBookingsModel.dart';
import 'package:app/models/bannerModel.dart';
import 'package:app/models/barberShopDescModel.dart';
import 'package:app/models/barberShopModel.dart';
import 'package:app/models/bookAppointmentModel.dart';
import 'package:app/models/bookNowModel.dart';
import 'package:app/models/businessLayer/apiResult.dart';
import 'package:app/models/businessLayer/dioResult.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/cancelReasonModel.dart';
import 'package:app/models/cartModel.dart';
import 'package:app/models/cookiesPolicyModel.dart';
import 'package:app/models/couponsModel.dart';
import 'package:app/models/currencyModel.dart';
import 'package:app/models/favoriteModel.dart';
import 'package:app/models/googleMapModel.dart';
import 'package:app/models/mapBoxModel.dart';
import 'package:app/models/mayByModel.dart';
import 'package:app/models/notificationModel.dart';
import 'package:app/models/paymentGatewayModel.dart';
import 'package:app/models/popularBarbersModel.dart';
import 'package:app/models/privacyPolicyModel.dart';
import 'package:app/models/productDetailModel.dart';
import 'package:app/models/productModel.dart';
import 'package:app/models/productOrderHistoryModel.dart';
import 'package:app/models/scratchCardModel.dart';
import 'package:app/models/serviceModel.dart';
import 'package:app/models/termsAndConditionModel.dart';
import 'package:app/models/timeSlotModel.dart';
import 'package:app/models/userModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../details_of_main.dart';
import '../main_services.dart';

class APIHelper {
  Future<dynamic> addSalonRating(
      int? user_id, int? vendor_id, double rating, String description) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}add_salon_rating"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "user_id": user_id,
          "vendor_id": vendor_id,
          "rating": rating,
          "description": description,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - addSalonRating(): " + e.toString());
    }
  }

  Future<dynamic> addStaffRating(
      int? user_id, int? staff_id, double rating, String description) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}add_staff_rating"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "user_id": user_id,
          "staff_id": staff_id,
          "rating": rating,
          "description": description,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - addStaffRating(): " + e.toString());
    }
  }

  Future<dynamic> addToCart(int? user_id, int? product_id, int qty) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}add_to_cart"),
        headers: await global.getApiHeaders(true),
        body: json
            .encode({"user_id": user_id, "product_id": product_id, "qty": qty}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = Cart.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - addToCart(): " + e.toString());
    }
  }

  Future<dynamic> addToFavorite(int? user_id, int? product_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}add_to_fav"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"user_id": user_id, "product_id": product_id}),
      );
      print({"user_id": user_id, "product_id": product_id});
      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = Favorites.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - addToFavorite(): " + e.toString());
    }
  }

  Future<dynamic> applyRewardsAndCoupons(String? cart_id, String type,
      {String? coupon_code}) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}apply_coupon_or_rewards"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "cart_id": cart_id,
          "type": type,
          "coupon_code": coupon_code,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = BookNow.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - applyRewardsAndCoupons(): " + e.toString());
    }
  }

  Future<dynamic> bookAppointment(int? vendor_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}booking_appointment"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "vendor_id": vendor_id,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList =
            BookAppointment.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - bookAppointment(): " + e.toString());
    }
  }

  Future<dynamic> bookNow(BookNow bookNow) async {
    try {
      bookNow.lang = global.languageCode;
      final response = await http.post(
        Uri.parse("${global.baseUrl}book_now"),
        headers: await global.getApiHeaders(true),
        body: json.encode(bookNow),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = BookNow.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }

      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - bookNow(): " + e.toString());
    }
  }

  Future<dynamic> cancelBooking(String? cart_id, String? reason) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}cancel_booking"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"cart_id": cart_id, "reason": reason}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - cancelBooking(): " + e.toString());
    }
  }

  Future<dynamic> cancelOrder(String? cart_id, String reason) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}cancel_product_orders"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"cart_id": cart_id, "reason": reason}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - cancelOrder(): " + e.toString());
    }
  }

  Future<dynamic> changePassword(
      String? user_email, String user_password) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}change_password"),
        headers: await global.getApiHeaders(false),
        body: json
            .encode({"user_phone": user_email, "user_password": user_password}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          jsonDecode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - changePassword(): " + e.toString());
    }
  }

  Future<dynamic> checkOut(BookNow bookNow) async {
    try {
      bookNow.lang = global.languageCode;
      final response = await http.post(
        Uri.parse("${global.baseUrl}checkout"),
        headers: await global.getApiHeaders(true),
        body: json.encode(bookNow),
      );
      print("............... ${global.baseUrl}checkout");

      print(bookNow.toString());
      print(json.encode(bookNow));
      print("............... ${global.baseUrl}checkout");
      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = BookNow.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }

      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - checkOut(): " + e.toString());
    }
  }

  Future<dynamic> clearCart(int? user_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}clear_cart"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"user_id": user_id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - delFromCart(): " + e.toString());
    }
  }

  Future<dynamic> cookiesPolicy() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}cookies',
          queryParameters: {
            'lang': global.languageCode,
          },
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = Cookies.fromJson(response.data['data']);
      } else {
        recordList = null;
      }

      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - cookiesPolicy(): " + e.toString());
    }
  }

  Future<dynamic> deleteAllNotifications(int? user_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_all_notifications"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"user_id": user_id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - deleteAllNotifications(): " + e.toString());
    }
  }

  Future<dynamic> deleteAccount(int? userId) async {
    try {
      if (userId == null) {
        throw "Empty user id passed to deleteAcccount()";
      }

      final response = await http.post(
          Uri.parse("${global.baseUrl}delete_all_user_data"),
          headers: await global.getApiHeaders(true),
          body: json.encode({"id": userId}));

      dynamic recordList;
      if (response.statusCode == 200) {
        return getAPIResult(response, recordList);
      }
    } catch (e) {
      print("Exception - deleteAccount(): " + e.toString());
    }
  }

  Future<dynamic> delFromCart(int? user_id, int? product_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}del_frm_cart"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"user_id": user_id, "product_id": product_id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = Cart.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - delFromCart(): " + e.toString());
    }
  }

  Future<dynamic> forgotPassword(String user_phone) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}forget_password"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_phone": user_phone}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - forgotPassword(): " + e.toString());
    }
  }

  Future<dynamic> getAllBookings(int? user_id) async {
    print("all_booking $user_id");
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}all_booking"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"user_id": user_id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<AllBookings>.from(json
            .decode(response.body)["data"]
            .map((x) => AllBookings.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getAllBookings(): " + e.toString());
    }
  }

  dynamic getAPIResult<T>(final response, T recordList) {
    print('..................................');

    try {
      dynamic result;
      print('..................................');
      result = APIResult.fromJson(json.decode(response.body), recordList);
      print(response.body);
      print(result);
      print('..................................');
      return result;
    } catch (e) {
      print("Exception - getAPIResult():" + e.toString());
    }
  }

  Future<dynamic> getBarbersDescription(int? staff_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}barber_desc"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "staff_id": staff_id,
          // "lang": global.languageCode,
        }),
      );

      dynamic recordList;

      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList =
            PopularBarbers.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getBarbersDescription(): " + e.toString());
    }
  }

  Future<dynamic> getBarberShopDescription(String? lat, String? lng,
      {int? vendor_id = 1}) async {
    try {
      print("${global.baseUrl}salon_desc : $vendor_id");
      final response = await http.post(
        Uri.parse('${global.baseUrl}salon_desc'),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "vendor_id": vendor_id,
          // "lat": lat,
          // "lng": lng,
          // "lang": 'EN'
        }),
      );
      print(response.body);
      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["status"] == "1") {
        recordList =
            BarberShopDesc.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getPopularBarbersList(): " + e.toString());
    }
  }

  Future<dynamic> getCancelReasons() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}cancel_reasons',
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = List<CancelReasons>.from(
            response.data["data"].map((x) => CancelReasons.fromJson(x)));
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getCancelReasons(): " + e.toString());
    }
  }

  Future<dynamic> getCartItems(int? user_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}show_cart"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"user_id": user_id}),
      );
      print('...........$user_id');

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = Cart.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getCartItems(): " + e.toString());
    }
  }

  Future<dynamic> getCouponsList(String? cart_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}couponlist"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "cart_id": cart_id,
          // "lang": global.languageCode,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<Coupons>.from(
            json.decode(response.body)["data"].map((x) => Coupons.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getCouponsList(): " + e.toString());
    }
  }

  Future<dynamic> getCurrency() async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}currency"),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = Currency.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getCurrency(): " + e.toString());
    }
  }

  dynamic getDioResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = DioResult.fromJson(response, recordList);
      return result;
    } catch (e) {
      print("Exception - getDioResult():" + e.toString());
    }
  }

  Future<dynamic> getFavoriteList(int? user_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}show_fav"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "user_id": user_id,
        }),
      );
      print(
          "${global.baseUrl}show_fav : $user_id :: ${global.languageCode} :: ${response.body.toString()}");

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = Favorites.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getFavoriteList(): " + e.toString());
    }
  }

  Future<dynamic> getGoogleMap() async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}google_map"),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList =
            GoogleMapModel.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getGoogleMap(): " + e.toString());
    }
  }

  Future<dynamic> getMapBox() async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}mapbox"),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = MapBoxModel.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getMapBox(): " + e.toString());
    }
  }

  Future<dynamic> getMapGateway() async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}mapby"),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = MapByModel.fromJson(json.decode(response.body));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getMapGateway(): " + e.toString());
    }
  }

  Future<dynamic> getNearByBanners() async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}getnearbanner"),
        headers: await global.getApiHeaders(false),
        // body: json.encode({
        //   "lat": lat,
        //   "lng": lng,
        // }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<BannerModel>.from(json
            .decode(response.body)["data"]
            .map((x) => BannerModel.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getNearByBanners(): " + e.toString());
    }
  }

  Future<dynamic> getNearByBarberShops(String? lat, String? lng, int pageNumber,
      {String? searchstring}) async {
    try {
      final response = await http.post(
        Uri.parse(
            "${global.baseUrl}getnearbysalons?page=${pageNumber.toString()}"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "lat": lat,
          "lng": lng,
          "searchstring": searchstring,
          "lang": global.languageCode,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<BarberShop>.from(json
            .decode(response.body)["data"]
            .map((x) => BarberShop.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getNearByBarberShops(): " + e.toString());
    }
  }

  Future<dynamic> getNearByCouponsList(String? lat, String? lng) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}getnearcouponlist"),
        headers: await global.getApiHeaders(true),
        body:
            json.encode({"lat": lat, "lng": lng, "lang": global.languageCode}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<Coupons>.from(
            json.decode(response.body)["data"].map((x) => Coupons.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getNearByCouponsList(): " + e.toString());
    }
  }

  Future<dynamic> getNotifications(int? user_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}allnotifications"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "user_id": user_id,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<NotificationList>.from(json
            .decode(response.body)["data"]
            .map((x) => NotificationList.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getNotifications(): " + e.toString());
    }
  }

  Future<dynamic> getPaymentGateways() async {
    try {
      final response = await http.get(
          Uri.parse("${global.baseUrl}payment_gateways"),
          headers: await global.getApiHeaders(true));

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList =
            PaymentGateway.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getPaymentGateways(): " + e.toString());
    }
  }

  Future<dynamic> getPopularBarbersList(
      String? lat, String? lng, int pageNumber, String? searchstring) async {
    try {
      final response = await http.post(
        Uri.parse(
            "${global.baseUrl}popular_barber?page=${pageNumber.toString()}"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          // "lat": lat,
          // "lng": lng,
          "searchstring": searchstring,
          // "lang": global.languageCode,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<PopularBarbers>.from(json
            .decode(response.body)["data"]
            .map((x) => PopularBarbers.fromJson(x)));
      } else {
        recordList = null;
      }
      print(response.body);
      print('000000000000000000000000000000000000000');
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getPopularBarbersList(): " + e.toString());
    }
  }

  Future<dynamic> getProductDetails(int? product_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_det"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "product_id": product_id,
          "user_id": global.user!.id,
          // "lang": global.languageCode
        }),
      );

      dynamic recordList;

      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = ProductDetail.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getProductDetails(): " + e.toString());
    }
  }

  Future<dynamic> getProductOrderHistory() async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_orders"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "user_id": global.user!.id,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<ProductOrderHistory>.from(json
            .decode(response.body)["data"]
            .map((x) => ProductOrderHistory.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getProductOrderHistory(): " + e.toString());
    }
  }

  Future<dynamic> getProducts(
      String? lat, String? lng, int pageNumber, String searchstring) async {
    try {
      final response = await http.post(
        Uri.parse(
            "${global.baseUrl}salon_products?page=${pageNumber.toString()}"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          // "lat": lat,
          // "lng": lng,
          "user_id": global.user!.id,
          "searchstring": searchstring,
          // "lang": global.languageCode
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<Product>.from(
            json.decode(response.body)["data"].map((x) => Product.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getProducts(): " + e.toString());
    }
  }

  Future<dynamic> getProductsOfMain(int mainId) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}getProductById?main_id=$mainId"),
        headers: await global.getApiHeaders(false),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<Product>.from(
            json.decode(response.body)["data"].map((x) => Product.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getProductsOfMain(): " + e.toString());
    }
  }

  Future<dynamic> getReferandEarn() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}refer_n_earn',
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = response.data["data"];
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getReferandEarn(): " + e.toString());
    }
  }

  Future<dynamic> getSalonListForServices(
      String? lat, String? lng, String? service_name) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}service_salons"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          // "lat": lat,
          // "lng": lng,
          "service_name": service_name,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<BarberShop>.from(json
            .decode(response.body)["data"]
            .map((x) => BarberShop.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getNearByBarberShops(): " + e.toString());
    }
  }

  Future<dynamic> getDetailsOfMainServices(String sId) async {
    try {
      print('..........${global.baseUrl}get_vendors_by_id?s_id=$sId');
      final response = await http.get(
        Uri.parse("${global.baseUrl}get_vendors_by_id?s_id=$sId"),
        headers: await global.getApiHeaders(true),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<VendorModel>.from(json
            .decode(response.body)["data"]
            .map((x) => VendorModel.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getDetailsOfMainServices(): " + e.toString());
    }
  }

  Future<dynamic> getScratchCards() async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}user_scratch_cards"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "user_id": global.user!.id,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<ScratchCard>.from(json
            .decode(response.body)["data"]
            .map((x) => ScratchCard.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getScratchCards(): " + e.toString());
    }
  }

  Future<dynamic> getServices(String? lat, String? lng, int pageNumber,
      {String? searchstring}) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}services?page=${pageNumber.toString()}"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          // "lat": lat,
          // "lng": lng,
          "searchstring": searchstring,
          // "lang": global.languageCode
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<Service>.from(
            json.decode(response.body)["data"].map((x) => Service.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getServices(): " + e.toString());
    }
  }

  Future<dynamic> getMainServices({required String type}) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}get_main_services?type=$type"),
        headers: await global.getApiHeaders(false),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<MainService>.from(json
            .decode(response.body)["data"]
            .map((x) => MainService.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - MainServicesModel(): " + e.toString());
    }
  }

  Future<dynamic> getTermsAndCondition() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}terms',
          queryParameters: {
            'lang': global.languageCode,
          },
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = TermsAndCondition.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getTermsAndCondition(): " + e.toString());
    }
  }

  Future<dynamic> getTimeSLot(
      String? selected_date, int? staff_id, int? vendor_id) async {
    try {
      List<String> dateParts = selected_date!.replaceAll('-', '/').split('/');
      String formattedDate = "${dateParts[2]}/${dateParts[1]}/${dateParts[0]}";
      print(
          '................. xx $staff_id xx $vendor_id  xx ${formattedDate}');
      final response = await http.post(
        Uri.parse("${global.baseUrl}timeslot"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "selected_date": formattedDate,
          "staff_id": staff_id,
          "vendor_id": vendor_id,
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = List<TimeSlot>.from(json
            .decode(response.body)["data"]
            .map((x) => TimeSlot.fromJson(x)));
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getTimeSLot(): " + e.toString());
    }
  }

  Future<dynamic> getUserProfile(int? id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}myprofile"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "id": id,
        }),
      );
      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
        recordList.token = json.decode(response.body)["token"];
        print(recordList.token);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getUserProfile(): " + e.toString());
    }
  }

  Future<dynamic> loginWithEmail(
      String email, String password, String deviceId) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}login_with_email"),
        headers: await global.getApiHeaders(false),
        body: json.encode(
            {"user_phone": email, "password": password, "device_id": deviceId}),
      );
      print(json.decode(response.body)["data"]);
      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        print(response.body);
        print(response.statusCode);
        print(json.decode(response.body));
        print(response.statusCode);
        print(json.decode(response.body)['status']);
        print(response.statusCode);
        print(CurrentUser.fromJson(json.decode(response.body)["data"]["user"])
            .email);
        recordList =
            CurrentUser.fromJson(json.decode(response.body)["data"]["user"]);
        recordList.cart_count =
            json.decode(response.body)['data']['cart_count'];
        recordList.token = json.decode(response.body)['token'];
        recordList.status = json.decode(response.body)['status'];
        // print("recordList.status");
        // print(recordList.status);
        // print(json.decode(response.body)['status']);
      } else {
        print("object");
        recordList = null;
      }

      print(".....${response.body}");
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - loginWithEmail(): " + e.toString());
    }
  }

  Future<dynamic> loginWithPhone(CurrentUser user) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}login_with_phone"),
        headers: await global.getApiHeaders(false),
        body: json.encode(user),
      );
      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - loginWithPhone(): " + e.toString());
    }
  }

  Future<dynamic> onScratch(int? scratch_id, int? user_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}scratch"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"user_id": user_id, "scratch_id": scratch_id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = ScratchCard.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - onScratch(): " + e.toString());
    }
  }

  Future<dynamic> privacyPolicy() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}privacy',
          queryParameters: {
            'lang': global.languageCode,
          },
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = PrivacyPolicy.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - privacyPolicy(): " + e.toString());
    }
  }

  Future<dynamic> productCartCheckout(
      int? user_id, String payment_status, String payment_gateway,
      {String? payment_id}) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_cart_checkout"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "user_id": user_id,
          "payment_status": payment_status,
          "payment_gateway": payment_gateway,
          "payment_id": payment_id,
          // "lang": global.languageCode
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
              json.decode(response.body)["status"] == "1" ||
          json.decode(response.body)["status"] == "2") {
        // recordList = ProductCartCheckout.fromJson(
        //     json.decode(response.body)["data"]["order"]);
        global.user!.cart_count =
            json.decode(response.body)['data']['cart_count'];
      } else {
        recordList = null;
      }
      print('XXXXXXXXXXXXXXXXXXXXXXXXXX');

      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - productCartCheckout(): " + e.toString());
    }
  }

  Future<dynamic> signUp(CurrentUser user, BuildContext context) async {
    try {
      Response response;
      var dio = Dio();
      // var formData = FormData.fromMap({
      //   'user_name': user.user_name,
      //   // 'user_email': user.user_email,
      //   'user_phone': user.user_phone,
      //   'password': user.user_password,
      //   'device_id': global.appDeviceId,
      //   // 'referral_code': user.referral_code != null ? user.referral_code : null,
      //   'fb_id': user.fb_id != null ? user.fb_id : null,
      //   // 'user_image': user.user_image != null
      //   //     ? await MultipartFile.fromFile(user.user_image!.path.toString())
      //   //     : null,
      //   // 'apple_id': user.apple_id != null ? user.apple_id : null
      // });

      response = await dio.post('${global.baseUrl}signup',
          data: json.encode({
            'user_name': user.user_name,
            'user_phone': user.user_phone,
            'password': user.user_password,
            'device_id': global.appDeviceId,
            'fb_id': user.fb_id != null ? user.fb_id : null,
            // "user_address": user.address,
            "region": user.region,
            "area": user.area,
            "city": user.city
          }),
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(response.data['data']);
        print(response.data['data'].toString());
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      Navigator.pop(context);
      print('${e.toString()}');
      Fluttertoast.showToast(msg: 'المستخدم موجود بالفعل');
      print("Exception - signUp(): " + e.toString());
    }
  }

  Future<dynamic> socialLogin(
      {String? user_email,
      String? facebook_id,
      String? email_id,
      String? type,
      String? apple_id}) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}social_login"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "user_email": user_email,
          "facebook_id": facebook_id,
          "email_id": email_id,
          "type": type,
          "apple_id": apple_id
        }),
      );
      dynamic recordList;
      if (response.statusCode == 200 &&
          jsonDecode(response.body)["status"] == "1") {
        recordList =
            CurrentUser.fromJson(json.decode(response.body)["data"]["user"]);
        recordList.cart_count =
            json.decode(response.body)['data']["cart_count"];
        recordList.token = json.decode(response.body)["token"];
      } else if (response.statusCode == 200 &&
          jsonDecode(response.body)["status"] == "4") {
        recordList = null;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - socialLogin(): " + e.toString());
    }
  }

  Future<dynamic> updateProfile(
    int? id,
    String? user_name,
    File? user_image, {
    String? user_password,
    String? region,
    String? city,
    String? area,
  }) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'id': id,
        'user_name': user_name,
        'user_password': user_password,
        'user_image': user_image != null
            ? await MultipartFile.fromFile(user_image.path.toString())
            : null,
        "region": region,
        "area": area,
        "city": city
      });

      response = await dio.post('${global.baseUrl}profile_edit',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(response.data['data']);
        recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - updateProfile(): " + e.toString());
    }
  }

  Future<dynamic> verifyOtpAfterLogin(
      String? user_phone, String? status, String? device_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}login_verifyotpfirebase"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "user_phone": user_phone,
          "status": status,
          "device_id": device_id
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList =
            CurrentUser.fromJson(json.decode(response.body)["data"]["user"]);
        recordList.cart_count =
            json.decode(response.body)['data']["cart_count"];
        recordList.token = json.decode(response.body)["token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpAfterLogin(): " + e.toString());
    }
  }

  Future<dynamic> verifyOtpAfterRegistration(String? user_phone, String? status,
      String? referral_code, String? device_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}verify_via_firebase"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "user_phone": user_phone,
          "status": status,
          "referral_code": referral_code,
          "device_id": device_id
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          jsonDecode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
        recordList.token = json.decode(response.body)["token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpAfterRegistration(): " + e.toString());
    }
  }

  Future<dynamic> verifyOtpForgotPassword(
      String? user_email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}verify_otp"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_email": user_email, "otp": otp}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          jsonDecode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpForgotPassword(): " + e.toString());
    }
  }

  Future<List<dynamic>> getRegions() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}getRegions',
          queryParameters: {
            // 'lang': global.languageCode,
          },
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      List<dynamic> recordList;
      if (response.statusCode == 200) {
        final data = response.data;
        recordList = data;
        print("88888 : ${recordList.length}");
        return recordList;
      } else {
        recordList = [];
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getRegions(): " + e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCities({required int id}) async {
    try {
      Response response;
      var dio = Dio();

      response =
          await dio.get('${global.baseUrl}getCitiesByRegion?region_id=$id',
              queryParameters: {
                // 'lang': global.languageCode,
              },
              options: Options(
                headers: await global.getApiHeaders(false),
              ));
      List<dynamic> recordList;
      if (response.statusCode == 200) {
        final data = response.data;
        recordList = data;
        print("88888 : ${recordList.length}");
        return recordList;
      } else {
        recordList = [];
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getCities(): " + e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getDistrict({required int cityId}) async {
    try {
      Response response;
      var dio = Dio();

      response =
          await dio.get('${global.baseUrl}getDistrictsByCity?city_id=$cityId',
              queryParameters: {
                // 'lang': global.languageCode,
              },
              options: Options(
                headers: await global.getApiHeaders(false),
              ));
      List<dynamic> recordList;
      if (response.statusCode == 200) {
        final data = response.data;
        recordList = data;
        print("88888 : ${recordList.length}");
        return recordList;
      } else {
        recordList = [];
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getCities(): " + e.toString());
      return [];
    }
  }

//
}
