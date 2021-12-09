
extension StringCasingExtension on String {
  String toCapitalized() =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get toTitleCase => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.toCapitalized())
      .join(" ");
}

