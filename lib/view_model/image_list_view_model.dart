
import 'package:flutter/foundation.dart';
import 'package:hot_air_balloon/model/image_list_model.dart';
import 'package:hot_air_balloon/repo/image_list_repo.dart';

class ImageListViewModel with ChangeNotifier {

  final _imageRepo = ImageListRepo();

  ImageListModel? _imageData;
  ImageListModel? get imageData => _imageData;

  setImageData(ImageListModel value) {
    _imageData = value;
    notifyListeners();
  }

  Future<void> imageListApi(context) async {

    _imageRepo.imageListApi().then((value) {
      if (value.status == 200) {
        setImageData(value);
      } else {
        setImageData(value);
        if (kDebugMode) {
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('imageListApi: $error');
      }
    });
  }
}

