import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/data/data_sources/remote/delegates/network_auth_imp.dart';
import 'package:c_supervisor/di/environment_type.dart';
import 'package:c_supervisor/ui/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:networking/client/networking_models/config_models/global_network_config.dart';
import 'package:networking/networking.dart';

import 'injector_holder.dart';

final diInstance = GetIt.instance;

final networkManager = NetworkManager.instance;

class DependencyInjector {
  DependencyInjector({
    required this.environment,
  }) : super();

  EnvironmentType environment;

  /// injectModules that used in app-runner
  Future<void> injectModules() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// Injects all modules in app
    InjectorHolder.injectAllApplicationModules();

    await GetIt.I.getAsync<AppSharedPrefsClient>();

    /// Register the environment type to be accessed across the app
    diInstance.registerSingleton(environment);

    _configureNetworkManger();
  }

  /// Configures network manager and it's [AppSecureStorageClient]
  void _configureNetworkManger() {
    diInstance.registerSingleton<AppSecureStorageClient>(
      AppSecureStorageClient(
        storageInstance: SecureStorage(),
      ),
    );

    /// configure network manager
    networkManager.configure(
      GlobalNetworkConfig(
        baseUrl: environment.environment.baseURL,
        auth: NetworkAuthImp(
          secureStorageClient: diInstance<AppSecureStorageClient>(),
          authCubit: diInstance<AuthCubit>(),
        ),
      ),
    );
  }
}
