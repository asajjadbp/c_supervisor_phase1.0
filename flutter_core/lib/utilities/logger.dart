import 'package:flutter/material.dart';
import 'package:logging/logging.dart' as log;

/// Logger
///
abstract class Logger {
  /// Applies default configuration to logger
  ///
  void configureLogger();

  /// Log error
  ///
  void logError(dynamic message);

  /// Log warning
  ///
  void logWarning(dynamic message);

  /// Log info
  ///
  void logInfo(dynamic message);

  /// Log verbose message
  ///
  void logVerbose(dynamic message);
}

/// Default App Logger
///
class DefaultLogger implements Logger {
  /// App Logger
  ///
  static final log.Logger instance = log.Logger('App Log');

  /// Applies default configuration to logger
  ///
  @override
  configureLogger() {
    instance.onRecord.listen((record) {
      debugPrint('${record.time}: ${record.message}');
    });
  }

  /// Log error
  ///
  @override
  void logError(dynamic message) => instance.log(log.Level.SHOUT, message);

  /// Log warning
  ///
  @override
  void logWarning(dynamic message) => instance.log(log.Level.WARNING, message);

  /// Log info
  ///
  @override
  void logInfo(dynamic message) => instance.log(log.Level.INFO, message);

  /// Log verbose
  ///
  @override
  void logVerbose(dynamic message) => instance.log(log.Level.FINE, message);
}
