import 'package:networking/client/networking_models/network_delegates/network_auth_delegate.dart';
import 'package:networking/client/networking_models/network_delegates/network_localization_delegate.dart';

class GlobalNetworkConfig {
  final String baseUrl;

  final bool enableCachingInterceptor;

  final NetworkAuthDelegate? auth;

  final NetworkLocalizationDelegate? locale;

  final bool isLanguageRequired;

  GlobalNetworkConfig({
    this.baseUrl = '',
    this.enableCachingInterceptor = false,
    this.locale,
    this.isLanguageRequired = true,
    this.auth,
  });
}
