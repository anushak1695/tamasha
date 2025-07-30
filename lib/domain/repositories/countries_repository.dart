import '../entities/country_entity.dart';

abstract class CountriesRepository {
  Future<List<CountryEntity>> getCountries();
}
