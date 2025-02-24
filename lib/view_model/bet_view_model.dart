
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hot_air_balloon/repo/bet_repo.dart';
import 'package:hot_air_balloon/res/app_colors.dart';
import 'package:hot_air_balloon/utils/utils.dart';
import 'package:provider/provider.dart';

class BetViewModel with ChangeNotifier {
  final _betRepo = BetRepo();

  bool _loading = false;

  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> betApi(dynamic number,dynamic amount,dynamic srNo ,context) async {
    // UserViewModel userViewModal = UserViewModel();
    // String? userId = await userViewModal.getUser();
    setLoading(true);
    Map data={
      "uid" : "4",
      "number" : number,
      "amount" : amount,
      "game_id" : "27",
      "game_sr_num" : srNo
    };
    _betRepo.betApi(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
       Utils.setSnackBar(value['message'], AppColor.green, context);
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