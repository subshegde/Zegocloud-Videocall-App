import 'dart:convert';
import 'package:crypto/crypto.dart';


class UniqueUserId{
  static String generateUniqueId(String baseString) {
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final input = '$baseString-$timestamp';
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString().substring(digest.toString().length - 6);
}
}