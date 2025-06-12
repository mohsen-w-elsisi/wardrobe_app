// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'wardrobe';

  @override
  String get wardrobeEmpty => 'no items saved yet';

  @override
  String get noSearchResults => 'no items found';

  @override
  String get savedOutfitsScreenTitle => 'saved outfits';

  @override
  String get noOutfitsSaved => 'no outfits saved yet';

  @override
  String get settings => 'settings';
}
