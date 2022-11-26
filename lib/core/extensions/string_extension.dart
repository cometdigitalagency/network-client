extension DefaultNullString on String? {
  String get defaultString {
    return this ?? "N/A";
  }
}
