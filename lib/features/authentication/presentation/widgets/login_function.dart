import 'package:encrypt/encrypt.dart';

String encryptUserAuth(String pass) {
  final key = Key.fromUtf8('zaq12wsxP@ssw0rd');
  final iv = IV.fromUtf8('0000000000000000'); // IV default 16 karakter nol

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  final encrypted = encrypter.encrypt(pass, iv: iv);
  return encrypted.base64;
}
