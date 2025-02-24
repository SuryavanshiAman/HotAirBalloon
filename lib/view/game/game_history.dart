import 'package:flutter/material.dart';
import 'package:hot_air_balloon/main.dart';
import 'package:hot_air_balloon/view_model/game_history_view_model.dart';
import 'package:provider/provider.dart';


class BalloonGameHistory extends StatefulWidget {
  const BalloonGameHistory({super.key});

  @override
  State<BalloonGameHistory> createState() => _BalloonGameHistoryState();
}

class _BalloonGameHistoryState extends State<BalloonGameHistory> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GameHistoryViewModel>(context, listen: false).gameHistoryApi(context);
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final data =  Provider.of<GameHistoryViewModel>(context).gameHistoryData?.data;
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding:  const EdgeInsets.only(top: 38, right: 10, left: 10),
          child: Container(
            height: 700,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade900,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Game history',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          child: const Icon(
                            Icons.cancel_outlined,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      SizedBox(
                        width: width*0.15,
                        child: const Text(
                          'S.no',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Text(
                        'Multiplier',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        'Bet/Amount',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        'Win Amount',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const Divider(thickness: 0.2),
                  Expanded(
                    child:
                    // gameHistoryData.response.isNotEmpty ?
                    ListView.builder(
                      itemCount:data?.length??0,
                      itemBuilder: (context, index) {
                        final gameResponse = data?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width*0.19,
                                child: Text(gameResponse?.gamesno.toString()??"",
                                  // gameResponse.gamesno.toString(),
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                width: width*0.1,
                                margin: EdgeInsets.only(left: width*0.047),
                                child: Center(
                                  child: Text(
                                    gameResponse?.multiplier.toString()??"",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Container(
                                width: width*0.12,
                                margin: EdgeInsets.only(left: width*0.1),
                                child: Center(
                                  child: Text(
                                    '${gameResponse?.amount} INR',
                                    // '200 INR',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              Container(
                                width: width*0.093,
                                margin: EdgeInsets.only(left: width*0.21),

                                child: Center(
                                  child: Text(
                                    // "100",
                                    gameResponse?.winAmount?.toString() ?? "0",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}