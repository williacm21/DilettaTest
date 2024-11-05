extension StringExtension on String {
  /// input: a1b2 => 12
  String get onlyNumber {
    String text = "";

    split("").forEach((e) => text += int.tryParse(e) != null ? e : "");

    return text;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.capitalize()).join(' ');
}
