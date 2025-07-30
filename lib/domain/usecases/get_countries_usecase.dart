import '../repositories/countries_repository.dart';
import '../entities/country_entity.dart';

class GetCountriesUseCase {
  final CountriesRepository _repository;

  GetCountriesUseCase(this._repository);

  Future<List<CountryEntity>> execute() async {
    return await _repository.getCountries();
  }
}
