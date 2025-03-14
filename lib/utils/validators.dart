class Validators {
  static bool isValidIpAddress(String input) {
    final ipv4Regex = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');
    final ipv6Regex = RegExp(r'^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
    return ipv4Regex.hasMatch(input) || ipv6Regex.hasMatch(input);
  }

    static bool isValidHostname(String input) {
    final hostnameRegex = RegExp(r'^[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return hostnameRegex.hasMatch(input);
  }
}