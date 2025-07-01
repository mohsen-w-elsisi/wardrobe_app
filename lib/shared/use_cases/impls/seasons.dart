import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/shared/entities/season.dart';
import 'package:wardrobe_app/shared/use_cases/use_cases.dart';

const _sharedPrefsKey = "season";

class SeasonSetterImpl implements SeasonSetter {
  @override
  void setSeason(Season season) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setInt(_sharedPrefsKey, season.index);
    GetIt.I<ClothItemUiNotifier>().notifyUi();
  }
}

class SeasonGetterImpl implements SeasonGetter {
  static const _defautlSeason = Season.all;

  @override
  Future<Season> currentSeason() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final index = sharedPrefs.getInt(_sharedPrefsKey) ?? _defautlSeason.index;
    return Season.values[index];
  }
}
