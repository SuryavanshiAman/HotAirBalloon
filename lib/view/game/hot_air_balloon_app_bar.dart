import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hot_air_balloon/main.dart';
import 'package:hot_air_balloon/res/app_colors.dart';

import 'how_to_play.dart';
import 'menu_bar.dart';

class HotAirBalloonAppbar extends StatefulWidget {
  // final KiNoBoolProvider betPlaced;
  const HotAirBalloonAppbar({
    super.key,
    // required this.betPlaced
  });

  @override
  State<HotAirBalloonAppbar> createState() => _HotAirBallonAppbarState();
}

class _HotAirBallonAppbarState extends State<HotAirBalloonAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.05,
      margin: EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.black.withOpacity(0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Container(
              height: height * 0.035,
              padding: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                color: AppColor.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.5, color: Colors.black),
                // gradient: KiNoColors.kiNoBtn
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'HotAirBalloon',
                    style: TextStyle(
                        color: Colors.white,
                        wordSpacing: 2,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.027,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return const HiloHowToPlay();
                  },
                );
              },
              child: Container(
                height: height * 0.035,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.5, color: Colors.black),
                    color: AppColor.lightBlue),
                child: const Icon(
                  Icons.help_outline_rounded,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            const Text(
              '501000 ',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
             Text(
              'INR',
              style: TextStyle(
                  color: AppColor.white, fontWeight: FontWeight.w100),
            ),
            InkWell(
              onTap: () => showSideMenu(context),
              child: Container(
                  height: height * 0.035,
                  width: width * 0.07,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 0.5, color: Colors.black),
                      color: AppColor.lightBlue),
                  child: const Icon(
                    Icons.menu,
                    size: 15,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void showSideMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const KinoMenuBar();
      },
    );
  }
}
