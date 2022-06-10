class UnknownExc implements Exception {
  UnknownExc(this.massage);

  final String? massage;

  @override
  String toString() {
    return massage ?? 'Unknown Exception';
  }
}
