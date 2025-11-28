class StringUtils {
  // Removes special characters and converts to uppercase
  static String sanitize(String input) {
    final sanitized = input.replaceAll(RegExp(r'[^a-zA-Z0-9_,\s]'), '');
    return sanitized.toUpperCase();
  }
}
