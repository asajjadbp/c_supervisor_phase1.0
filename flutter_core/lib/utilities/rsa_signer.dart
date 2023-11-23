import 'package:encrypt/encrypt.dart';
import 'package:logging/logging.dart';
import 'package:pointycastle/asymmetric/api.dart';

/// Wrapper class used to verify signature
class RsaSigner {
  RsaSigner(this.publicKey);

  /// Parsing public key
  final String publicKey;

  ///
  /// [plainText]  the plain text message that's going to be verified
  /// ex: it's the response
  /// [signature] the signature received that needs to be validated against [plainText]
  /// ex: it's the hash signature received from server along with the response
  bool verifySignature(String plainText, String signature) {
    RSAAsymmetricKey publicKeyParser = RSAKeyParser().parse(publicKey);

    final modulus = publicKeyParser.modulus;
    final exponent = publicKeyParser.exponent;
    if (modulus == null || exponent == null) {
      Logger.root.warning('⛔️ Unable to get RSAPublicKey components');
      return false;
    }

    final rsaPublicKey = RSAPublicKey(modulus, exponent);
    final rsaSigner = RSASigner(RSASignDigest.SHA256, publicKey: rsaPublicKey);
    final signer = Signer(rsaSigner);

    /// first argument is the plain text and the 2nd is the digest (the signature captured from the server)
    return signer.verify64(plainText, signature);
  }
}
