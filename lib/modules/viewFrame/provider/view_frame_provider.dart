import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flurr_assignment/modules/viewFrame/ui/piece_view.dart';
import 'package:flurr_assignment/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../../main.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/constants.dart';
import '../../editFrame/ui/edit_frame.dart';

class ViewFrameProvider with ChangeNotifier {
  List<Widget> pieces = [];
  Uint8List? imageData;
  List<Widget> itemsData = [];
  List<Widget> storiesItem = [];

  Future getImageSize(Image image) {
    Completer completer = Completer();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

// here we will split the image into small pieces using the rows and columns defined above; each piece will be added to a stack
  Future<void> addImagesToView(List<XFile> image, int height) async {
    pieces.clear();
    image.asMap().forEach((i, element) async {
      Size imageSize = await getImageSize(Image.file(File(element.path)));
      pieces.add(PieceView(
        key: GlobalKey(),
        image: Image.file(File(element.path)),
        bringToTop: bringToTop,
      ));
      notifyListeners();
    });
  }

  selectImages() async {
    final List<XFile> pickedFileList = await ImagePicker().pickMultiImage();
    addImagesToView(pickedFileList, 2).then((value) {
      mainNavigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => EditFrame(),
      ));
    });
  }

// when the pan of a piece starts, we need to bring it to the front of the stack
  void bringToTop(Widget widget) {
    pieces.remove(widget);
    pieces.add(widget);
    notifyListeners();
  }

  //save frames in SharedPrefrences
  getFrame(Uint8List uint8list) {
    imageData = uint8list;
    List<String> newList = [
      base64Encode(uint8list),
      ...?BaseSharedPreference.instance.getSavedImage()
    ];
    BaseSharedPreference.instance.setSavedImage(newList);
    BaseSharedPreference.instance.setHasImage(true);
    EasyLoading.showSuccess(Constants.completed);
    notifyListeners();
  }


  //get frames from SharedPrefrences

  void getPostsData(BuildContext context) {
    List<dynamic> responseList = BaseSharedPreference.instance.getSavedImage()!;

    List<Widget> listItems = [];
    responseList.forEach((post) {
      storiesItem.add(const Padding(
        padding: EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: AppSizes.buttonSize,
          backgroundImage: NetworkImage(
              "https://i.pinimg.com/originals/7d/34/d9/7d34d9d53640af5cfd2614c57dfa7f13.png"),
        ),
      ));
      listItems.add(Container(
        height: AppSizes.getHeight(context, percent: 50),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Constants.singleTag,
                  style: AppSizes.setStyle(16, FontWeight.bold, Colors.purple),
                ),
                Container(
                  width: AppSizes.getWidth(context, percent: 20),
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppSizes.microPadding),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize:
                          const Size.fromHeight(AppSizes.defaultPadding),
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.purple,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius:
                            BorderRadius.circular(AppSizes.defaultPadding),
                      ),
                    ),
                    child: Text(Constants.follow,
                        style: AppSizes.setStyle(
                            16, FontWeight.normal, Colors.white)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppSizes.getHeight(context, percent: 30),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.memory(
                    base64Decode(post),
                    fit: BoxFit.fitHeight,
                    errorBuilder: (context, object, stacktrace) {
                      return Container(
                        padding: const EdgeInsets.all(AppSizes.defaultPadding),
                        child: Center(
                          child: Text(Constants.noFrameCreated,
                              textAlign: TextAlign.start,
                              style: AppSizes.setStyle(
                                  16, FontWeight.normal, Colors.black)),
                        ),
                      );
                    },
                    height: AppSizes.getHeight(context),
                    width: AppSizes.getWidth(context),
                  ),
                  Positioned(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const CircleAvatar(
                              radius: AppSizes.defaultPadding,
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1578253809350-d493c964357f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Constants.viewFrameName,
                                    style: AppSizes.setStyle(
                                        14, FontWeight.normal, Colors.black)),
                                Text(Constants.igTag,
                                    style: AppSizes.setStyle(
                                        14, FontWeight.normal, Colors.black)),
                              ],
                            )
                          ],
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.save),
                            Icon(Icons.bookmark),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Text(
              Constants.dummyText,
              textAlign: TextAlign.center,
              style: AppSizes.setStyle(16, FontWeight.bold, Colors.purple),
            ),
          ],
        ),
      ));
    });
    //setState(() {
    itemsData = listItems;
    notifyListeners();
    //});
  }
}
