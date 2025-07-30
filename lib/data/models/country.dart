class Country {
  final CountryName name;

  const Country({required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: CountryName.fromJson(json['name'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name.toJson()};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Country(name: $name)';
  }
}

class CountryName {
  final String common;
  final String official;

  const CountryName({required this.common, required this.official});

  factory CountryName.fromJson(Map<String, dynamic> json) {
    return CountryName(
      common: json['common'] as String,
      official: json['official'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'common': common, 'official': official};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryName &&
        other.common == common &&
        other.official == official;
  }

  @override
  int get hashCode => common.hashCode ^ official.hashCode;

  @override
  String toString() {
    return 'CountryName(common: $common, official: $official)';
  }
}
