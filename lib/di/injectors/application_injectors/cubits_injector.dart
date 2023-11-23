import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/di/base_injector.dart';
import 'package:c_supervisor/di/injectors/dependancy_injector.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';

/// [CubitsInjector] hold all application cubits dependencies
///
/// global cubits are injected here not the APIs cubits, other cubits are used via blocProviders
class CubitsInjector extends BaseInjector {
  static final cubitsInjectors = [
    () => diInstance.registerLazySingleton<AuthCubit>(
          () => AuthCubit(
              appSecureStorageClient: diInstance<AppSecureStorageClient>(),
              loginUC: diInstance<LoginUC>()),
        ),
    // () => diInstance.registerLazySingleton<LocalizationCubit>(
    //       () => LocalizationCubit(
    //         sharedPrefsClient: diInstance<AppSharedPrefsClient>(),
    //       ),
    //     ),
  ];

  @override
  void injectModules() {
    for (final cubitInjector in cubitsInjectors) {
      cubitInjector.call();
    }
  }
}
