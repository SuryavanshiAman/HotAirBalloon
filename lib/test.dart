import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hot_air_balloon/main.dart';
import 'package:hot_air_balloon/view/game_comtorller.dart';
import 'package:provider/provider.dart';

import 'generated/assets.dart';


class MovingBackgroundScreen extends StatefulWidget {
  @override
  _MovingBackgroundScreenState createState() => _MovingBackgroundScreenState();
}

class _MovingBackgroundScreenState extends State<MovingBackgroundScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
final game=Provider.of<GameController>(context,listen: false);
game.connectToServer(context);
  }
List<String>text=[
  "0",
  "1",
  "3",
  "5",
  // "10",
];
  @override
  Widget build(BuildContext context) {
    final game=Provider.of<GameController>(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height*0.5,),
          Center(child: Text(game.timeData.toString()??""),),
          SizedBox(height: height*0.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(text.length, (index){
              return  InkWell(
                  onTap: (){
game.setSelectedIndex(index);
                  },
                  child: customContainer(text[index].toString()));
            }),
          ),

        ],
      )
    );
  }
Widget customContainer( text){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(3),
      child: Text("${text} min Timer",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
    );
}
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
