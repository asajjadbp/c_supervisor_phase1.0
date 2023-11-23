import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'url_launcher.dart';

/// Default URL launcher implementation
class DefaultURLLauncher implements URLLauncher {
  @override
  Future<bool> launchStringUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
      return true;
    }
    return false;
  }

  @override
  Future<bool> call({
    required String phoneNumber,
  }) async {
    return await launch(
      "tel://$phoneNumber",
    );
  }

  @override
  Future<bool> openMail({
    required String email,
    String subject = "",
    String body = "",
  }) async {
    return await launch(
      Uri(
        scheme: 'mailto',
        path: email,
        query: 'subject=$subject&body=$body',
      ).toString(),
    );
  }

  @override
  Future<bool> openSystemCalendar() async {
    if (Platform.isIOS) {
      return await launch("calshow://");
    }

    if (Platform.isAndroid) {
      return await launch("content://com.android.calendar/time/");
    }

    throw UnsupportedError('Unsupported OS');
  }

  /// openMap create and launch map url
  @override
  Future<void> openMap(double latitude, double longitude,
      {String? title = ''}) async {
    // String urlGoogleMaps =
    //     'https://maps.google.com/maps?q=$latitude,$longitude($title)';

    Uri urlGoogleMaps = Platform.isAndroid
        ? Uri.parse('google.navigation:q=$latitude,$longitude')
        : Uri.parse(
            'comgooglemaps://?saddr=&daddr=$latitude,$longitude&directionsmode=driving');

    Uri urlAppleMaps =
        Uri.parse('https://maps.apple.com/?daddr=$latitude,$longitude');

    _launchMapURL(urlGoogleMaps, urlAppleMaps);
  }

  /// launchMapURL used to launch [mapUrl] if it fails try the [alternativeMapUrl]
  _launchMapURL(Uri mapUrl, Uri alternativeMapUrl) async {
    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl);
    } else if (await canLaunchUrl(alternativeMapUrl)) {
      await launchUrl(alternativeMapUrl);
    } else {
      throw 'no map found';
    }
  }
}
