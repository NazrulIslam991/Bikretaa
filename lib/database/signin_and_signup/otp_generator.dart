import 'dart:math';

class OtpGenerator {
  static String generate({int length = 6}) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10).toString()).join();
  }
}
