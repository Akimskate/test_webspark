class UrlValidator {
  static String? validateUrl(String? value) {
    const pattern = r"^(?:http|https):\/\/[\w-]+(?:\.[\w-]+)+[\w.,@?^=%&:/~+#-]*$";

    final regex = RegExp(pattern);
    if (value == '' || value == null) {
      return 'Enter url';
    }
    if (value.isNotEmpty && !regex.hasMatch(value)) {
      return 'Enter a valid url address';
    }
    return null;
  }
}
