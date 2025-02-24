import 'package:flutter/foundation.dart';
import 'package:hot_air_balloon/model/image_list_model.dart';
import 'package:hot_air_balloon/res/api_url.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class UpdateImageRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> updateImageApi(dynamic data) async {
    print(data);
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.updateImageApi,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during updateImageApi: $e');
      }
      rethrow;
    }
  }
}