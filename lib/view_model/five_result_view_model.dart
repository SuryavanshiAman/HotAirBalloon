import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/last_result_model.dart';
import '../repo/five_result_repo.dart';
import '../view/game_comtorller.dart';

class LastFiveResultViewModel with ChangeNotifier {
  final _resultRepo = LastFiveResultRepo();

  LastResultModel? _resultData;
  LastResultModel? get resultData => _resultData;

  setResultData(LastResultModel value) {
    _resultData = value;
    notifyListeners();
  }

  Future<void> lastFiveResultApi(context) async {
    final game = Provider.of<GameController>(context,listen: false);
    _resultRepo.lastFiveResultApi().then((value) {
      if (value.status == "200") {
        game.setLastResult(true);
        setResultData(value);
      } else {
        setResultData(value);
        if (kDebugMode) {
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('lastFiveResultApi: $error');
      }
    });
  }
}

