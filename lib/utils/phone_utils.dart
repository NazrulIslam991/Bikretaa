class PhoneUtils {
  /// Removes +880 prefix if exists
  static String removeBdPrefix(String mobile) {
    return mobile.replaceFirst(RegExp(r'^\+880'), '');
  }

  /// Adds +880 prefix if missing
  static String addBdPrefix(String mobile) {
    if (!mobile.startsWith('+880')) {
      return '+880$mobile';
    }
    return mobile;
  }
}
