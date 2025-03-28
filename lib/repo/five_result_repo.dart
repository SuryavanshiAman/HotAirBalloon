
import 'package:flutter/foundation.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';
import '../model/last_result_model.dart';
import '../res/api_url.dart';


class LastFiveResultRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<LastResultModel> lastFiveResultApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.lastResult);
      return LastResultModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during lastFiveResultApi: $e');
      }
      rethrow;
    }
  }
}