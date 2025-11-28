class PhoneUtils {
  /// Removes +8801 prefix if exists
  static String removeBdPrefix(String mobile) {
    return mobile.replaceFirst(RegExp(r'^\+8801'), '');
  }

  /// Adds +8801 prefix if missing
  static String addBdPrefix(String mobile) {
    if (!mobile.startsWith('+8801')) {
      return '+8801$mobile';
    }
    return mobile;
  }
}
