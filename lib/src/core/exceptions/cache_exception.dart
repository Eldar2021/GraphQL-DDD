class CacheExc implements Exception {
  CacheExc(this.massage);

  final String? massage;

  @override
  String toString() {
    return massage ?? 'Cache Exception';
  }
}
