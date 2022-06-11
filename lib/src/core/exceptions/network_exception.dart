class NetworkExc implements Exception {
  NetworkExc(this.massage);

  final String? massage;

  @override
  String toString() {
    return massage ?? 'Network is not connection';
  }
}
