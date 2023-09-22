import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../components/animations_manager.dart';
import '../../../components/scale_up_transition.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/constants.dart';
import '../../viewFrame/provider/view_frame_provider.dart';

class EditFrame extends StatefulWidget {
  const EditFrame({super.key});

  @override
  State<EditFrame> createState() => _EditFrameState();
}

class _EditFrameState extends State<EditFrame> {
  WidgetsToImageController controller = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          Constants.viewFrameTitle,
          style: AppSizes.setStyle(16, FontWeight.bold, Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.microPadding),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.microPadding),
            child: Icon(Icons.bookmark_border),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.microPadding),
            child: Icon(Icons.shopping_bag_outlined),
          ),
        ],
        actionsIconTheme: const IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      backgroundColor: Colors.grey.shade100.withOpacity(0.9),
      body: ScaleUpTransition(
        delay: AnimationsManager.bgLayerAnimationDuration,
        child: Consumer<ViewFrameProvider>(
          builder: (c, ViewFrameProvider viewFrameProvider, _) => Builder(
            builder: (context) {
              return editCanvasView(context, viewFrameProvider);
            },
          ),
        ),
      ),
    );
  }

  editCanvasView(BuildContext context, ViewFrameProvider viewFrameProvider) =>
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(AppSizes.smallPadding),
        margin: const EdgeInsets.only(top: AppSizes.smallPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: WidgetsToImage(
              controller: controller,
              child: Stack(
                children: viewFrameProvider.pieces,
              ),
            )),
            TextButton(
              onPressed: () {
                EasyLoading.show(status: Constants.processing);
                controller.capture().then((value) {
                  viewFrameProvider.getFrame(value!);
                  Navigator.pop(context);
                }, onError: (object, stacktrace) {
                  EasyLoading.showError(Constants.failed);
                });
              },
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(AppSizes.buttonSize),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Colors.purple, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(AppSizes.microPadding),
                ),
              ),
              child: const Text(Constants.save,
                  style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                viewFrameProvider.selectImages();
              },
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(AppSizes.buttonSize),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Colors.purple, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(AppSizes.microPadding),
                ),
              ),
              child: const Text(Constants.cancel,
                  style: TextStyle(color: Colors.purple)),
            )
          ],
        ),
      );
}
