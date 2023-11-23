import 'package:url_launcher/url_launcher.dart';

import '../../ui/pages/team_kpi/index.dart';

mixin UrlLauncherMixin {
  ///[openMaps]==> to open map on location given
  void openMaps({required num latitude, required num longitude}) async {
    final String url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    try {
      await launch(url);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///[callLauncher]==>> to call
  Future<bool> callLauncher(String phoneNumber) => launch("tel://$phoneNumber");
}
