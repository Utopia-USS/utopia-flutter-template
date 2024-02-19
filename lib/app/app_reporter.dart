import 'package:utopia_arch/utopia_arch.dart';

final appReporter = Reporter.combined([
  LoggerReporter.standard(),
  //const CrashlyticsReporter(), // TODO uncomment after firebase setup
]);
