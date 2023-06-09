import 'dart:convert';

class JwtTokenUtil {
  static Map<String, dynamic> decryptJwtToken(String jwtToken) {
    final parts = jwtToken.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT token format');
    }
    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return json.decode(payload);
  }
}
