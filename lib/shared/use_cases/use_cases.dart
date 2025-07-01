import 'package:wardrobe_app/shared/entities/season.dart';

abstract class SeasonSetter {
  void setSeason(Season season);
}

abstract class SeasonGetter {
  Future<Season> currentSeason();
}
