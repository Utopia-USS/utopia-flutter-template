import 'package:utopia_arch/reporter/logger_reporter.dart';
import 'package:utopia_firebase_crashlytics/reporter/crashlytics_reporter.dart';
import 'package:utopia_utils/reporter/reporter.dart';

final appReporter = Reporter.combine([LoggerReporter(), CrashlyticsReporter()]);