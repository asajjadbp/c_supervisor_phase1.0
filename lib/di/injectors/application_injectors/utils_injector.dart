import 'package:c_supervisor/di/base_injector.dart';

/// [UtilsInjector] hold all Utils dependencies
class UtilsInjector extends BaseInjector {
  static final utilsInjectors = [];

  @override
  void injectModules() {
    for (final cubitInjector in utilsInjectors) {
      cubitInjector.call();
    }
  }
}
