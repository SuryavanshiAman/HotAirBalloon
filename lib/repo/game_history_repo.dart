import 'package:flutter/foundation.dart';
import 'package:hot_air_balloon/model/game_history_model.dart';
import 'package:hot_air_balloon/model/image_list_model.dart';
import 'package:hot_air_balloon/res/api_url.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class GameHistoryRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<GameHistoryModel> gameHistoryApi() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${ApiUrl.gameHistoryApi}uid=4&game_id=27");
      return GameHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during gameHistoryApi: $e');
      }
      rethrow;
    }
  }
}