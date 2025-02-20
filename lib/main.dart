import 'package:flutter/material.dart';
import 'package:hot_air_balloon/res/app_constant.dart';
import 'package:hot_air_balloon/view/game_comtorller.dart';
import 'package:provider/provider.dart';

import 'view/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => GameController()),

          ],
          child: GameScreen()),
    );
  }
}
double height=0.0;
double width=0.0;