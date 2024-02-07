import 'package:shared_preferences/shared_preferences.dart';

int myCartCount = 0;

Future<void> setCartCount({int count = 0}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('myCartCount', myCartCount);
}

Future<int?> getCartCount() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myCartCount = prefs.getInt('myCartCount') ?? 0;
  } catch (e) {
    myCartCount = 0;
  }
  return myCartCount;
}

Future<void> removeCartCount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('myCartCount');
}
