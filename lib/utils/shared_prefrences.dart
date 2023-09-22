import 'package:flurr_assignment/utils/shared_pref_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseSharedPreference {
  SharedPreferences? sharepref;
  static BaseSharedPreference? _instance;

  BaseSharedPreference._();

  static BaseSharedPreference get instance =>
      _instance ??= BaseSharedPreference._();

  Future<void> init() async {
    sharepref ??= await SharedPreferences.getInstance();
  }

  @override
  List<dynamic>? getSavedImage() {
    return sharepref
        ?.getStringList(BaseSharedPrefConstants.prefKeyImageCreatedPath);
  }

  @override
  Future<bool?> setSavedImage(List<String> imagePath) async {
    return await sharepref?.setStringList(
        BaseSharedPrefConstants.prefKeyImageCreatedPath, imagePath);
  }

  @override
  bool? getHasImage() {
    return sharepref?.getBool(BaseSharedPrefConstants.prefKeyHasImage);
  }

  @override
  Future<bool?> setHasImage(bool hasImage) async {
    return await sharepref?.setBool(
        BaseSharedPrefConstants.prefKeyHasImage, hasImage);
  }
}
