import 'package:flurr_assignment/modules/viewFrame/provider/view_frame_provider.dart';
import 'package:flurr_assignment/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'modules/viewFrame/ui/view_frame.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BaseSharedPreference.instance.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<
    NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ViewFrameProvider>(
          create: (context) => ViewFrameProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: mainNavigatorKey,
        home: ViewFrame(),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Flurr Assignment',
      ),
    );
  }
}
