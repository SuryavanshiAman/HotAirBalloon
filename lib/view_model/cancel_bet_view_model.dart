
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hot_air_balloon/repo/cancel_bet_repo.dart';
import 'package:hot_air_balloon/res/app_colors.dart';
import 'package:hot_air_balloon/utils/utils.dart';
import 'package:provider/provider.dart';

import '../view/game_comtorller.dart';

class CancelBetViewModel with ChangeNotifier {
  final _cancelBetRepo = CancelBetRepo();

  bool _loading = false;

  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> cancelBetApi(dynamic srNo,dynamic number, context) async {
    // UserViewModel userViewModal = UserViewModel();
    // String? userId = await userViewModal.getUser();
    final game = Provider.of<GameController>(context,listen: false);

    setLoading(true);
    Map data={
      "userid" : "4",
      "number" : number,
      "gamesno" : srNo.toString()
    };
    _cancelBetRepo.cancelBetApi(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        game.setButton1(0);
        game.setNextPeriod(0);
        Utils.setSnackBar(value['message'], AppColor.green, context);
      }
      else {
        setLoading(false);
        Utils.setSnackBar(value['message'], AppColor.red, context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('cancelBetApi: $error');
      }
    });
  }
}