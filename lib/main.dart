import 'package:flutter/material.dart';
import 'package:hot_air_balloon/res/app_constant.dart';
import 'package:hot_air_balloon/view/game_comtorller.dart';
import 'package:hot_air_balloon/view_model/bet_view_model.dart';
import 'package:provider/provider.dart';

import 'view/game_screen.dart';
import 'view_model/cancel_bet_view_model.dart';
import 'view_model/game_history_view_model.dart';
import 'view_model/image_list_view_model.dart';
import 'view_model/update_image_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameController()),
        ChangeNotifierProvider(create: (context) => BetViewModel()),
        ChangeNotifierProvider(create: (context) => ImageListViewModel()),
        ChangeNotifierProvider(create: (context) => UpdateImageViewModel()),
        ChangeNotifierProvider(create: (context) => GameHistoryViewModel()),
        ChangeNotifierProvider(create: (context) => CancelBetViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      home: GameScreen(),
    );
  }
}
double height=0.0;
double width=0.0;