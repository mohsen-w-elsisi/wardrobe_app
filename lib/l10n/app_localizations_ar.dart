// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'واردروب';

  @override
  String get wardrobeEmpty => 'لم يتم تسجيل أي ملابس حتى الآن';

  @override
  String get noSearchResults => 'لم يوجد أي قطع';

  @override
  String get savedOutfitsScreenTitle => 'الأزياء المسجلة';

  @override
  String get noOutfitsSaved => 'لم يتم تسجيل أي أزياء بعد';

  @override
  String get settings => 'الإعدادات';
}
