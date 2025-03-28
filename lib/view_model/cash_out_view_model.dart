
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repo/cash_out_repo.dart';
import '../res/app_colors.dart';
import '../utils/utils.dart';
import '../view/game_comtorller.dart';


class CashOutViewModel with ChangeNotifier {
  final _cashOutRepo = CashOutRepo();

  bool _loading = false;

  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> cashOutApi(dynamic multipier,dynamic srNo,dynamic number,context) async {
    final game = Provider.of<GameController>(context,listen: false);
    // game. setAutoBet(false);
    print("${srNo}");
    print("${number}");
    setLoading(true);
    Map data={
      "uid": "4",
      "multiplier": multipier,
      "game_sr_num": srNo,
      "number": number
    };

    print(data);
    String jsonData = jsonEncode(data);
    String encodedData = base64.encode(utf8.encode(jsonData));
    Map saltData={
      "salt":encodedData
    };
    print(encodedData);
    _cashOutRepo.cashOutApi(saltData).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        Utils.setSnackBar(value['message'], AppColor.green, context);
        game.setButton1(0);
        game.setNextPeriod(0);
       //  number=="1"? game.setAutoBet(false):game.setAutoBetTwo(false);
        // game.gameData?.status==1? game.setButton1(3):null;'

      }
      else {
        game.setButton1(0);
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