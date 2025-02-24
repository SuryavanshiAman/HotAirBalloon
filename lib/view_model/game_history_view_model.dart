
import 'package:flutter/foundation.dart';
import 'package:hot_air_balloon/model/game_history_model.dart';
import 'package:hot_air_balloon/repo/game_history_repo.dart';

class GameHistoryViewModel with ChangeNotifier {

  final _historyRepo = GameHistoryRepo();

  GameHistoryModel? _gameHistoryData;
  GameHistoryModel? get gameHistoryData => _gameHistoryData;

  setGameHistoryData(GameHistoryModel value) {
    _gameHistoryData = value;
    notifyListeners();
  }

  Future<void> gameHistoryApi(context) async {

    _historyRepo.gameHistoryApi().then((value) {
      if (value.status == 200) {
        setGameHistoryData(value);
      } else {
        setGameHistoryData(value);
        if (kDebugMode) {
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('gameHistoryApi: $error');
      }
    });
  }
}

