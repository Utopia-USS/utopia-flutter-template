import 'package:DART_PACKAGE_NAME/app/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:utopia_localization_utils/utopia_localization_utils.dart';

extension AppContextExtensions on BuildContext {
  AppLocalizationsData get strings => localizations();
}
