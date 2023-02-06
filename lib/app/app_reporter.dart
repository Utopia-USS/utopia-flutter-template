import 'package:utopia_utils/utopia_utils.dart';

final appReporter = Reporter.combined([
  LoggerReporter(),
  //const CrashlyticsReporter(), // TODO uncomment after firebase setup
]);
