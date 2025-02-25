
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hot_air_balloon/repo/bet_repo.dart';
import 'package:hot_air_balloon/res/app_colors.dart';
import 'package:hot_air_balloon/utils/utils.dart';
import 'package:hot_air_balloon/view/game_comtorller.dart';
import 'package:provider/provider.dart';

class BetViewModel with ChangeNotifier {
  final _betRepo = BetRepo();

  bool _loading = false;

  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> betApi(dynamic number,dynamic amount,dynamic srNo,dynamic type,context) async {
    final game = Provider.of<GameController>(context,listen: false);
    type=="2"?game.setNextPeriod(srNo):null;
    print("${number}");
    print("${srNo}");
    setLoading(true);
    Map data={
      "uid" : "4",
      "number" : number.toString(),
      "amount" : amount.toString(),
      "game_id" : "27",
      "game_sr_num" : srNo.toString()
    };
    _betRepo.betApi(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
       Utils.setSnackBar(value['message'], AppColor.green, context);
        game.gameData?.status==0? game.setButton1(2):null;
        game.gameData?.status==1? game.setButton1(3):null;
      }
      else {
        setLoading(false);
        Utils.setSnackBar(value['message'], AppColor.red, context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('betApi: $error');
      }
    });
  }
}