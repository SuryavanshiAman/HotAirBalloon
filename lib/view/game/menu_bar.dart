import 'package:flutter/material.dart';
import 'package:hot_air_balloon/main.dart';
import 'package:hot_air_balloon/res/switch.dart';
import 'package:hot_air_balloon/view/background_change_screen.dart';
import 'package:provider/provider.dart';

import '../game_comtorller.dart';
import 'game_history.dart';
import 'how_to_play.dart';


class KinoMenuBar extends StatefulWidget {
  const KinoMenuBar({super.key});

  @override
  State<KinoMenuBar> createState() => _KinoMenuBarState();
}

class _KinoMenuBarState extends State<KinoMenuBar> {




  @override
  Widget build(BuildContext context) {
    final game =Provider.of<GameController>(context);
    return  Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding:  EdgeInsets.only(top: height*0.045,right: width*0.02,),
          child: Container(
            width: width*0.5,
            height: height*0.33,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade900,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height*0.028),
                MenuItem(
                  label: 'Sound',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  actionIcon:  CustomSwitch(
                    width: width * 0.09,
                    height: height * 0.022,
                    toggleSize: height * 0.015,
                    value: game.sound,
                    borderRadius: 20.0,
                    padding: 2.0,
                    toggleColor: Colors.white,
                    switchBorder: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    toggleBorder: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey.withOpacity(0.2),
                    onToggle: (bool value) {
                      setState(() {
                        game.setSound(value);
                        print(game.sound);
                      });
                    },
                  ),
                  // Switch(
                  //   value: light0,
                  //   focusColor: Colors.white,
                  //   hoverColor:Colors.white,
                  //   onChanged: (bool value) {
                  //     setState(() {
                  //       light0 = value;
                  //     });
                  //   },
                  // ),
                ),
                MenuItem(
                  icon: Icons.history,
                  label: 'Change Bg',
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>BackgroundScreen()));
                    showDialog(
                      context: context,
                      barrierDismissible: true, // Dismiss when tapping outside
                      builder: (BuildContext context) {
                        return const BackgroundScreen();
                      },
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.history,
                  label: 'Game History',
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true, // Dismiss when tapping outside
                      builder: (BuildContext context) {
                        return const BalloonGameHistory();
                      },
                    );
                  },
                ),
                const Divider(indent: 10,endIndent: 10,thickness: 0.3,),
                MenuItem(
                  icon: Icons.help_outline_rounded,
                  label: 'how to Play',
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true, // Dismiss when tapping outside
                      builder: (BuildContext context) {
                        return const HiloHowToPlay();
                      },
                    );
                    // Handle Contact Us tap
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData? icon; // Leading icon
  final Widget? actionIcon; // Trailing action widget (like an icon or text)
  final String label; // Menu label
  final VoidCallback onTap; // Tap callback

  const MenuItem({
    super.key,
    this.icon,
    this.actionIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    label,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(width: 20,),
                  if (actionIcon != null) actionIcon!, // Display trailing widget if provided

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}