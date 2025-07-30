class CountryEntity {
  final String commonName;
  final String officialName;

  const CountryEntity({required this.commonName, required this.officialName});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryEntity &&
        other.commonName == commonName &&
        other.officialName == officialName;
  }

  @override
  int get hashCode => commonName.hashCode ^ officialName.hashCode;

  @override
  String toString() {
    return 'CountryEntity(commonName: $commonName, officialName: $officialName)';
  }
}
