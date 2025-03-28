
import 'package:flutter/material.dart';
import 'package:hot_air_balloon/res/app_colors.dart';
import 'package:hot_air_balloon/view_model/update_image_view_model.dart';
import 'package:provider/provider.dart';

import '../view_model/image_list_view_model.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ImageListViewModel>(context, listen: false).imageListApi(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final imageList =Provider.of<ImageListViewModel>(context);
    final updateImage =Provider.of<UpdateImageViewModel>(context);
    return Align(
      alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: imageList.imageData?.image?.length??0,
              itemBuilder: (context, index) {
                final bool isSelected = index == selectedIndex;
                final data= imageList.imageData?.image?[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    updateImage.updateImageApi(context,data?.id,);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                      NetworkImage(data?.image.toString()??"",)
                                  ))),
                          isSelected ?
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(Icons.check_circle,color: AppColor.white,)):Container()

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

  }


}

