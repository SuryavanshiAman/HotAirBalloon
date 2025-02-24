
import 'package:flutter/foundation.dart';
import 'package:hot_air_balloon/model/image_list_model.dart';
import 'package:hot_air_balloon/repo/image_list_repo.dart';
import 'package:hot_air_balloon/repo/update_image_repo.dart';

class UpdateImageViewModel with ChangeNotifier {

  final _updateRepo = UpdateImageRepo();

  ImageListModel? _imageData;
  ImageListModel? get imageData => _imageData;
String? _updatedImage;

  String? get updatedImage => _updatedImage;

  setUpdatedImage(String? value) {
    _updatedImage = value;
    notifyListeners();
  }
  setImageData(ImageListModel value) {
    _imageData = value;
    notifyListeners();
  }

  Future<void> updateImageApi(context,dynamic id) async {
    print(id);
Map data={
  "userid" : "4",
  "image_id":id.toString()
};
    _updateRepo.updateImageApi(data).then((value) {
      if (value['status']==200) {
        print(value['data']['image']);
        setUpdatedImage(value['data']['image']);
      } else {
        setUpdatedImage(value['data']['image']);
        if (kDebugMode) {
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('updateImageApi: $error');
      }
    });
  }
}

