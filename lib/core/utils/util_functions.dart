import 'dart:math';

String generateRandomString() {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%^&*()_+{}[];:,.<>?';
  Random random = Random();
  String result = '';

  for (int i = 0; i < 5; i++) {
    result += chars[random.nextInt(chars.length)];
  }

  return result;
}