
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

import '../../utils/app_sizes.dart';
import '../../utils/constants.dart';
import '../viewFrame/provider/view_frame_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  void didChangeDependencies() {

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
      body: Consumer<ViewFrameProvider>(
          builder: (c, ViewFrameProvider viewFrameProvider, _) =>
              Builder(builder: (context) {
                return viewFrameProvider.itemsData.isNotEmpty?Column(
                  children: [
                    Container(
                      height: AppSizes.getHeight(context, percent: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultPadding,
                          vertical: AppSizes.mediumPadding),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: viewFrameProvider.storiesItem,
                      ),
                    ),
                    Expanded(
                        child: StackedCardCarousel(
                      items: viewFrameProvider.itemsData,
                    )

                        // ListView.builder(
                        //     controller: controller,
                        //     itemCount: itemsData.length,
                        //     shrinkWrap: true,
                        //     physics: BouncingScrollPhysics(),
                        //     itemBuilder: (context, index) {
                        //       double scale = 1.0;
                        //       if (topContainer > 0.5) {
                        //         scale = index + 14 - topContainer;
                        //         if (scale < 0) {
                        //           scale = 0;
                        //         } else if (scale > 1) {
                        //           scale = 1;
                        //         }
                        //       }
                        //       return Opacity(
                        //         opacity: scale,
                        //         child: Transform(
                        //           transform: Matrix4.identity()..scale(scale, scale),
                        //           alignment: Alignment.bottomCenter,
                        //           child: Align(
                        //               heightFactor: 1,
                        //               alignment: Alignment.topCenter,
                        //               child: itemsData[index]),
                        //         ),
                        //       );
                        //     }),
                        ),
                  ],
                ):Center(child: Text(
                  Constants.noFrameCreated,
                  style: AppSizes.setStyle(16, FontWeight.bold, Colors.black),
                ),);
              })),
    ));
  }
}
