import 'dart:convert';

/// Parse *JWT* access token and check whether it's expired.
///
/// Created by. https://github.com/sidsbrmnn/jwt_decode
class Jwt {
  /// Parse JWT token to [Map<String, dynamic>].
  ///
  /// Throws [FormatException] if unable to parse the token.
  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid token.');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw const FormatException('Invalid payload.');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += "==";
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64 string.');
    }

    return utf8.decode(base64Url.decode(output));
  }

  /// Returns true if the token is expired.
  ///
  /// Throws [FormatException] if unable to parse the token.
  static bool isExpired(String token) {
    final DateTime? expirationDate = getExpiryDate(token);
    if (expirationDate != null) {
      return DateTime.now().isAfter(expirationDate);
    } else {
      return false;
    }
  }

  /// Returns token expiry date time.
  ///
  /// Throws [FormatException] if unable to parse the token.
  static DateTime? getExpiryDate(String token) {
    final Map<String, dynamic> payload = parseJwt(token);
    if (payload['exp'] != null) {
      return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true)
          .add(Duration(seconds: payload["exp"]));
    }
    return null;
  }
}
