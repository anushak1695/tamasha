import '../../domain/repositories/countries_repository.dart';
import '../../domain/entities/country_entity.dart';
import '../api/countries_api_service.dart';
import '../models/country.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesApiService _apiService;

  CountriesRepositoryImpl({required CountriesApiService apiService})
    : _apiService = apiService;

  @override
  Future<List<CountryEntity>> getCountries() async {
    final countries = await _apiService.getCountries();
    return countries.map((country) => _mapToEntity(country)).toList();
  }

  CountryEntity _mapToEntity(Country country) {
    return CountryEntity(
      commonName: country.name.common,
      officialName: country.name.official,
    );
  }
}
