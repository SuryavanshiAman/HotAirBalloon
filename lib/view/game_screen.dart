import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hot_air_balloon/generated/assets.dart';
import 'package:hot_air_balloon/main.dart';
import 'package:hot_air_balloon/res/app_colors.dart';
import 'package:hot_air_balloon/view/game/hot_air_balloon_app_bar.dart';
import 'package:hot_air_balloon/view/game_comtorller.dart';
import 'package:hot_air_balloon/view_model/bet_view_model.dart';
import 'package:hot_air_balloon/view_model/cancel_bet_view_model.dart';
import 'package:hot_air_balloon/view_model/update_image_view_model.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 50),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 0.4).animate(_controller);

    Provider.of<GameController>(context, listen: false).connectToServer();
    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final game = Provider.of<GameController>(context);

    if (game.gameData?.status == 2) {
      _controller.reset(); // Reset animation when status == 2
    }
    {
      _controller.forward();
    }
  }

  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final game = Provider.of<GameController>(context, listen: false);
    print("Aman: ${state}");
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // game.disposeAudio();
      game.disConnectToServer(context);
    }
    if (state == AppLifecycleState.resumed) {
      game.connectToServer();
      print("Amanioooo");
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameController>(context);
    final bet = Provider.of<BetViewModel>(context);
    final cancelBet = Provider.of<CancelBetViewModel>(context);
    final updatedImage = Provider.of<UpdateImageViewModel>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: AppColor.appBg,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            HotAirBalloonAppbar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColor.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "SNo.${game.gameData?.period.toString() ?? ""}",
                    style: TextStyle(
                        color: AppColor.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColor.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "All Bet",
                    style: TextStyle(
                        color: AppColor.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            expansionWidget(),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              height: height * 0.5,
              width: width * 0.95,
              decoration: BoxDecoration(),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        child: updatedImage.updatedImage != null
                            ? Image.network(
                                updatedImage.updatedImage ?? "",
                                fit: BoxFit.fill,
                                height: height * 0.5,
                              )
                            : Image.asset(
                                Assets.imagesBalloonBg,
                                fit: BoxFit.fill,
                                height: height * 0.5,
                              ),
                      ),
                      game.gameData?.status == 1
                          ? Positioned(
                              left: 0,
                              right: 0,
                              bottom: game.gameData?.status == 1
                                  ? 600 * _animation.value
                                  : game.gameData?.status == 2
                                      ? 0
                                      : 0,
                              child: Center(
                                  child: Container(
                                padding: EdgeInsets.only(bottom: 25),
                                alignment: Alignment.center,
                                height: height * 0.15,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(Assets.imagesBalloonTwo),
                                        fit: BoxFit.fill)),
                                child: GradientText(
                                  text:
                                      "${game.gameData?.timer.toString() ?? ""} X",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(3, 1),
                                        blurRadius: 8.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColor.white,
                                      AppColor.white,
                                      AppColor.white,
                                    ],
                                  ),
                                ),
                              )))
                          : game.gameData?.status == 2 && game.blast == false
                              ? Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage(Assets.imagesBlasat),
                                          fit: BoxFit.fill)),
                                )
                              : game.gameData?.status == 2
                                  ? Positioned(
                                      top: 250,
                                      left: 40,
                                      child: Center(
                                          child: GradientText(
                                        text:
                                            "Balloon has burst ${game.gameData?.timer.toString() ?? ""} X",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(5,
                                                  1), // Creates the 3D effect
                                              blurRadius: 8.0,
                                              color: AppColor.gray,
                                            ),
                                          ],
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColor.white, // Gold
                                            AppColor.white, // Lighter Gold
                                            AppColor.white,
                                          ],
                                        ),
                                      )),
                                    )
                                  : Positioned(
                                      top: 200,
                                      left: 40,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Center(
                                              child: GradientText(
                                            text: "WAITING FOR NEXT ROUND",
                                            // text: gameController.walletAmount,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(5,
                                                      1), // Creates the 3D effect
                                                  blurRadius: 8.0,
                                                  color: AppColor.gray,
                                                ),
                                              ],
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColor.white, // Gold
                                                AppColor.white, // Lighter Gold
                                                AppColor.white,
                                              ],
                                            ),
                                          )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffea0b3e),
                                                  width: 1),
                                            ),
                                            child: LinearProgressIndicator(
                                              value: (game.gameData?.betTime ??
                                                      0) *
                                                  0.01,
                                              // value: 0.5,
                                              backgroundColor: Colors.grey,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Color(0xffea0b3e)),
                                              minHeight: 6,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          GradientText(
                                            text:
                                                '00:${(game.gameData?.betTime ?? 0 * 0.01).toStringAsFixed(1)}',
                                            // text: gameController.walletAmount,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(5, 1),
                                                  blurRadius: 8.0,
                                                  color: AppColor.gray,
                                                ),
                                              ],
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColor.white, // Gold
                                                AppColor.white, // Lighter Gold
                                                AppColor.white,
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.02),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     game.gameData?.status==0?bet.betApi("7", game.selectedNumber.toString(),
                    //         game.gameData?.period.toString() ?? "", context):bet.betApi("7", game.selectedNumber.toString(),
                    //         game.gameData?.period??0+1, context);
                    //     // game.betPlaced != true && game.gameData?.status == 0
                    //     //     ? bet.betApi("7", game.selectedNumber.toString(),
                    //     //         game.gameData?.period.toString() ?? "", context)
                    //     //     : game.betPlaced == true &&
                    //     //             game.gameData?.status == 1
                    //     //         ? "CASH OUT"
                    //     //         : cancelBet.cancelBetApi(
                    //     //             game.gameData?.period.toString() ?? "",
                    //     //             context);
                    //     // game.toggleBetPlaced();
                    //   },
                    //   child: Container(
                    //     height: height * 0.055,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(width: 1, color: Colors.black),
                    //       color: AppColor.darkGreen,
                    //       // game.betPlaced != true
                    //       //     ? AppColor.darkGreen
                    //       //     : game.betPlaced == true &&
                    //       //             game.gameData?.status == 1
                    //       //         ? AppColor.orange
                    //       //         : AppColor.red,
                    //       boxShadow: const [
                    //         BoxShadow(
                    //           color: Colors.black54,
                    //           blurRadius: 8,
                    //           offset: Offset(2, 2),
                    //         ),
                    //       ],
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         game.betPlaced == true && game.gameData?.status == 1
                    //             ? Container()
                    //             : Icon(
                    //                 game.betPlaced != true
                    //                     ? Icons.play_arrow_outlined
                    //                     : Icons.pause,
                    //                 size: 40,
                    //                 color: Colors.white,
                    //               ),
                    //         Text("BET",
                    //           // game.betPlaced != true
                    //           //     ? 'BET'
                    //           //     : game.betPlaced == true &&
                    //           //             game.gameData?.status == 1
                    //           //         ? "CASH OUT"
                    //           //         : 'CANCEL',
                    //           style: const TextStyle(
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.w900,
                    //               color: Colors.white),
                    //         ),
                    //         SizedBox(
                    //           width: width * 0.1,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    button(),
                    Container(
                      height: height * 0.08,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        color: AppColor.darkGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5, right: 12, left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'BET INR',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Container(
                                  height: height * 0.04,
                                  width: width * 0.38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColor.darkGreen,
                                    border: Border.all(
                                        width: 1, color: Colors.black),
                                  ),
                                  child: Center(
                                      child: Text(
                                    '${game.selectedNumber}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  )),
                                ),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: game.decrement,
                              child: Container(
                                  height: height * 0.048,
                                  width: width * 0.1,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 0.5, color: Colors.black),
                                      color: AppColor.green),
                                  child: const Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          AlertDialog(
                                            alignment: Alignment.bottomCenter,
                                            backgroundColor:
                                                const Color(0xff2b7009),
                                            content: Column(
                                              children: [
                                                const Text(
                                                  'BET INR',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(height: 20),
                                                Container(
                                                  color:
                                                      const Color(0xff2b7009),
                                                  height: 100,
                                                  width: double.maxFinite,
                                                  child: GridView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: 10,
                                                    // items.length,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 10,
                                                      childAspectRatio: 4 / 2,
                                                    ),
                                                    itemBuilder:
                                                        (context, index) {
                                                      final isSelected =
                                                          game.selectedNumber ==
                                                              5;
                                                      // items[
                                                      // index];
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            game.setSelectedNumber(
                                                                2);
                                                            // items[
                                                            // index]);
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: 20,
                                                          width: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            color: const Color(
                                                                0xff569123),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              '${2}',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: isSelected
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 150,
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                  height: height * 0.048,
                                  width: width * 0.1,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 0.5, color: Colors.black),
                                      color: AppColor.green),
                                  child: const Icon(
                                    Icons.dynamic_feed_rounded,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                            ),
                            InkWell(
                              onTap: game.increment,
                              child: Container(
                                  height: height * 0.048,
                                  width: width * 0.1,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 0.5, color: Colors.black),
                                      color: AppColor.green),
                                  child: const Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  int button1=0;
Widget button(){
  final game = Provider.of<GameController>(context);
  final bet = Provider.of<BetViewModel>(context);
  final cancelBet = Provider.of<CancelBetViewModel>(context);
    return  game.button1==0? InkWell(
      onTap: () {
        print((game.gameData?.period??0)+1);
        game.gameData?.status==0?bet.betApi("7", game.selectedNumber.toString(), game.gameData?.period.toString() ?? "","1", context):
        bet.betApi("8", game.selectedNumber.toString(), (game.gameData?.period??0)+1,"2", context);



      },
      child: Container(
        height: height * 0.055,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.black),
          color: AppColor.darkGreen,
          // game.betPlaced != true
          //     ? AppColor.darkGreen
          //     : game.betPlaced == true &&
          //             game.gameData?.status == 1
          //         ? AppColor.orange
          //         : AppColor.red,
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            game.betPlaced == true && game.gameData?.status == 1
                ? Container()
                : Icon(
              game.betPlaced != true
                  ? Icons.play_arrow_outlined
                  : Icons.pause,
              size: 40,
              color: Colors.white,
            ),
            Text("BET",
              // game.betPlaced != true
              //     ? 'BET'
              //     : game.betPlaced == true &&
              //             game.gameData?.status == 1
              //         ? "CASH OUT"
              //         : 'CANCEL',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            SizedBox(
              width: width * 0.1,
            ),
          ],
        ),
      ),
    ):
    game.button1==1? InkWell(
      onTap: () {
        game.setButton1(0);
        game.setNextPeriod(0);
   /// cash out
      },
      child: Container(
        height: height * 0.055,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.black),
          color: AppColor.orange,
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Icon(Icons.pause,
              size: 40,
              color: Colors.white,
            ),
            Text("Cash out",
              // game.betPlaced != true
              //     ? 'BET'
              //     : game.betPlaced == true &&
              //             game.gameData?.status == 1
              //         ? "CASH OUT"
              //         : 'CANCEL',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            Text("${game.gameData?.timer.toString()??" "} X",
              // game.betPlaced != true
              //     ? 'BET'
              //     : game.betPlaced == true &&
              //             game.gameData?.status == 1
              //         ? "CASH OUT"
              //         : 'CANCEL',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            SizedBox(
              width: width * 0.1,
            ),
          ],
        ),
      ),
    )
        :InkWell(
      onTap: () {
        /// cancel
        cancelBet.cancelBetApi(
            game.gameData?.period.toString() ?? "",
            context);
        game.setButton1(0);
        game.setNextPeriod(0);
      },
      child: Container(
        height: height * 0.055,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.black),
          color: AppColor.red,
          // game.betPlaced != true
          //     ? AppColor.darkGreen
          //     : game.betPlaced == true &&
          //             game.gameData?.status == 1
          //         ? AppColor.orange
          //         : AppColor.red,
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.pause,
              size: 40,
              color: Colors.white,
            ),
            Text("Cancel",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            SizedBox(
              width: width * 0.1,
            ),
          ],
        ),
      ),
    );
}
  Widget expansionWidget() {
    final game = Provider.of<GameController>(context);
    return ExpansionTile(
      collapsedBackgroundColor: Color(0xff262830).withOpacity(0.4),
      tilePadding: EdgeInsets.only(left: 5, right: 5),
      collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: game.isExpanded
          ? const Text("Round History",
              style: TextStyle(
                  fontSize: 14,
                  color: AppColor.black,
                  fontWeight: FontWeight.w600))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.04,
                  width: width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final double price = 0.02;
                        // double.parse(number[index].price.toString());
                        Color textColor;
                        if (price > 1 && price < 2) {
                          textColor = Colors.blue;
                        } else if (price >= 2 && price < 10) {
                          textColor = Colors.white;
                        } else {
                          textColor = Colors.white;
                        }
                        return Container(
                          // height: height * 0.02,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.only(
                              left: width * 0.02, right: width * 0.02),
                          decoration: BoxDecoration(
                            // color: AppColor.lightCream,
                            // color: Color(0xff262830).withOpacity(0.6),
                            color: AppColor.black,
                            // border: Border.all(
                            //     color: Colors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Center(
                            child: Text(
                              '1.01 X',
                              // '${number[index].price.toStringAsFixed(2)} X',
                              style: TextStyle(fontSize: 10, color: textColor),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
      onExpansionChanged: (value) {
        game.setIsExpanded(value);
      },
      trailing: Container(
        alignment: Alignment.center,
        height: height * 0.04,
        width: width * 0.15,
        decoration: BoxDecoration(
          color: AppColor.black.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Align icons in the center
          children: [
            Icon(
              Icons.history,
              size: 18,
              color:
                  !game.isExpanded ? Colors.grey.withOpacity(0.8) : Colors.pink,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Icon(
                !game.isExpanded
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 30,
                color: !game.isExpanded
                    ? Colors.grey.withOpacity(0.8)
                    : Colors.pink,
              ),
            ),
          ],
        ),
      ),
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xff262830).withOpacity(0.6),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 2,
              childAspectRatio: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              final double price = 2.00;
              // final double price = double.parse(number[index].price.toString());
              Color textColor;
              if (price > 1 && price < 2) {
                textColor = Colors.blue;
              } else if (price >= 2 && price < 10) {
                textColor = Colors.white;
              } else {
                textColor = Colors.pink;
              }
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: height * 0.02,
                  padding:
                      EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                  decoration: const BoxDecoration(
                    color: Color(0xff080808),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Center(
                    child: Text(
                      '2.01 X',
                      style: TextStyle(fontSize: 11, color: textColor),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
