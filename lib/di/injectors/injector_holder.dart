import 'package:c_supervisor/di/base_injector.dart';

import 'application_injectors/index.dart';

class InjectorHolder {
  static final List<BaseInjector> _applicationInjectors = [
    DataSourcesInjector(),
    ReposInjector(),
    UseCasesInjector(),
    CubitsInjector(),
    // UtilsInjector(),
  ];

  /// iterate and inject all application modules
  static void injectAllApplicationModules() {
    for (var injector in _applicationInjectors) {
      injector.injectModules();
    }
  }
}
