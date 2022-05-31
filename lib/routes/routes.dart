import 'package:get/get.dart';
import 'package:tiendaweb/screens/auth/login_screen.dart';
import 'package:tiendaweb/screens/auth/otp_screen.dart';
import 'package:tiendaweb/screens/auth/signup_screen.dart';
import 'package:tiendaweb/screens/home/category_screen.dart';
import 'package:tiendaweb/screens/home/home_screen.dart';
import 'package:tiendaweb/screens/splash/splash.dart';
import 'package:tiendaweb/screens/stores/add_store.dart';
import 'package:tiendaweb/screens/stores/store_screen.dart';

class Routes {
  static const String initial = "/";
  static const String homescreen = "/home-screen";
  static const String categoryscreen = "/category-screen";
  static const String loginScreen = "/login-screen";
  static const String signupScreen = "/signup-screen";
  static const String otpScreen = "/otp-screen";
  static const String addStoreScreen = "/add-store-screen";
  static const String storeScreen = "/store-screen";

  //====Using this method we can pass parameter
  static String getInitial() => initial;
  static String getLoginRoute() => loginScreen;
  static String getHomeRoute() => homescreen;
  static String getCategoryRoute() => categoryscreen;
  static String getSignupRoute() => signupScreen;
  static String getOtpRoute(String mobile) => "$otpScreen?mobile=$mobile";
  static String getAddStoreRoute() => addStoreScreen;
  static String getStoreRoute() => storeScreen;

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(
        name: loginScreen,
        page: () {
          return const LoginScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: homescreen,
        page: () {
          return const HomeScreen();
        },
        transition: Transition.rightToLeft),
    GetPage(
        name: signupScreen,
        page: () {
          return const SignupScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: otpScreen,
        page: () {
          var mobile = Get.parameters['mobile'].toString();
          return OTPScreen(mobile: mobile);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addStoreScreen,
        page: () {
          return const AddStore();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: storeScreen,
        page: () {
          return const StoreScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: categoryscreen,
        page: () {
          return const CategoryScreen();
        },
        transition: Transition.fadeIn),
  ];
}
