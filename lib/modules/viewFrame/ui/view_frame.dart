
import 'package:flurr_assignment/modules/homePage/home_page.dart';
import 'package:flurr_assignment/modules/viewFrame/provider/view_frame_provider.dart';
import 'package:flurr_assignment/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';


import '../../../main.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/constants.dart';

class ViewFrame extends StatelessWidget {
  ViewFrame({super.key});

  BaseSharedPreference? sharedPreferences = BaseSharedPreference.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: Consumer<ViewFrameProvider>(
        builder: (c, ViewFrameProvider viewFrameProvider, _) => Builder(
          builder: (context) {
            // puzzleProvider.splitImage(puzzleProvider.image);
            return Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        topView(context),
                        hashtagView(),
                        bottomView(context, viewFrameProvider)
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }

  topView(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(AppSizes.smallPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: AppSizes.buttonSize,
                  backgroundImage: AssetImage(
                      "assets/images/profile.png"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.smallPadding),
                  child: Text(Constants.viewFrameName,
                      style:
                          AppSizes.setStyle(16, FontWeight.bold, Colors.black)),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
              child: GestureDetector(
                onTap: () {

                  Provider.of<ViewFrameProvider>(context, listen: false)
                      .getPostsData(context);


                },
                child: Text(Constants.dashboard,
                    style:
                        AppSizes.setStyle(14, FontWeight.bold, Colors.black)),
              ),
            )
          ],
        ),
      );

  hashtagView() => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(AppSizes.smallPadding),
        margin: const EdgeInsets.only(top: AppSizes.smallPadding),
        child: Column(
          children: [
            Text(Constants.dummyText,
                textAlign: TextAlign.center,
                style: AppSizes.setStyle(
                    16, FontWeight.normal, Colors.black.withOpacity(0.8))),
            const SizedBox(
              height: 10,
            ),
            Text(Constants.dummyTextSubTitle,
                textAlign: TextAlign.center,
                style: AppSizes.setStyle(16, FontWeight.normal, Colors.purple)),
          ],
        ),
      );

  bottomView(BuildContext context, ViewFrameProvider viewFrameProvider) =>
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(AppSizes.smallPadding),
        margin: const EdgeInsets.only(top: AppSizes.smallPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Constants.yourFrame,
                textAlign: TextAlign.start,
                style: AppSizes.setStyle(16, FontWeight.bold, Colors.black)),
            const SizedBox(
              height: AppSizes.smallPadding,
            ),
            viewFrameProvider.imageData != null
                ? Center(
                    child: Image.memory(
                      viewFrameProvider.imageData!,
                      errorBuilder: (context, object, stacktrace) {
                        return Container(
                          padding:
                              const EdgeInsets.all(AppSizes.defaultPadding),
                          child: Center(
                            child: Text(Constants.noFrameCreated,
                                textAlign: TextAlign.start,
                                style: AppSizes.setStyle(
                                    16, FontWeight.normal, Colors.black)),
                          ),
                        );
                      },
                      height: AppSizes.getHeight(context, percent: 50),
                      width: AppSizes.getWidth(context, percent: 50),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(AppSizes.defaultPadding),
                    child: Center(
                      child: Text(Constants.noFrameCreated,
                          textAlign: TextAlign.start,
                          style: AppSizes.setStyle(
                              16, FontWeight.normal, Colors.black)),
                    ),
                  ),
            const SizedBox(
              height: AppSizes.smallPadding,
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
              child: const Text(Constants.editFrames,
                  style: TextStyle(color: Colors.purple)),
            )
          ],
        ),
      );
}
