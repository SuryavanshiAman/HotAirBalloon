
import 'package:flutter/foundation.dart';
import 'package:hot_air_balloon/res/api_url.dart';
import 'package:matcher/matcher.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class BetRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> betApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.betApi, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during betApi: $e');
      }
      rethrow;
    }
  }}