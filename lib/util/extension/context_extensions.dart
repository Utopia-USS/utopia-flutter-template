import 'package:DART_PACKAGE_NAME/app/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension AppContextExtensions on BuildContext {
  AppLocalizationsData get strings => Localizations.of(this, AppLocalizationsData)!;
}
