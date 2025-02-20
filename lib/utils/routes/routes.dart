

import 'package:flutter/material.dart';
import 'package:hot_air_balloon/res/text_widget.dart';

import 'routes_name.dart';

class Routers {
  static WidgetBuilder generateRoute(String routeName) {
    switch (routeName) {
      // case RoutesName.splashScreen:
      //   return (context) => const SplashScreen();
      // case RoutesName.loginScreen:
      //   return (context) => const LoginScreen();
      // case RoutesName.registerScreen:
      //   return (context) => const RegisterScreen();
      // case RoutesName.balloonScreen:
      //   return (context) => const BalloonScreen();
      // case RoutesName.bankDetails:
      //   return (context) => const BankDetails();
      // case RoutesName.profileScreen:
      //   return (context) =>  ProfileScreen();
      // case RoutesName.depositScreen:
      //   return (context) =>  DepositScreen();
      // case RoutesName.withdrawScreen:
      //   return (context) => WithdrawPage();
      //
      // case RoutesName.withdrawHistoryScreen:
      //   return (context) => WithdrawHistory ();
      // case RoutesName.depositHistoryScreen:
      //   return (context) => DepositHistoryScreen ();

      default:
        return (context) => Scaffold(
          body: Center(
            child: textWidget(
                text: 'No Route Found!',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        );
    }
  }
}
