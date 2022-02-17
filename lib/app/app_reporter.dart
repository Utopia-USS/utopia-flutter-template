import 'package:utopia_firebase_crashlytics/utopia_firebase_crashlytics.dart';
import 'package:utopia_utils/utopia_utils.dart';

final appReporter = Reporter.combine([LoggerReporter(), const CrashlyticsReporter()]);
