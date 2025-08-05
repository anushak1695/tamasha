import 'package:flutter/foundation.dart';
import 'dart:async';
import '../../domain/usecases/get_countries_usecase.dart';
import '../../domain/entities/country_entity.dart';

enum CountriesState { loading, loaded, error }

class CountriesProvider with ChangeNotifier {
  final GetCountriesUseCase _getCountriesUseCase;

  CountriesProvider(this._getCountriesUseCase);

  CountriesState _state = CountriesState.loading;
  List<CountryEntity> _countries = [];
  List<CountryEntity> _filteredCountries = [];
  String _errorMessage = '';
  String _searchQuery = '';
  Timer? _debounceTimer;

  CountriesState get state => _state;
  List<CountryEntity> get countries => _filteredCountries;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  Future<void> loadCountries() async {
    _setState(CountriesState.loading);

    try {
      _countries = await _getCountriesUseCase.execute();
      _filterCountries();
      _setState(CountriesState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(CountriesState.error);
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;

    // Cancel the previous timer if it exists
    _debounceTimer?.cancel();

    // Start a new timer for 300 milliseconds
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _filterCountries();
      notifyListeners();
    });
  }

  void _filterCountries() {
    if (_searchQuery.isEmpty) {
      _filteredCountries = List.from(_countries);
    } else {
      _filteredCountries = _countries.where((country) {
        final commonName = country.commonName.toLowerCase();
        final officialName = country.officialName.toLowerCase();
        final query = _searchQuery.toLowerCase();

        return commonName.contains(query) || officialName.contains(query);
      }).toList();
    }
  }

  void _setState(CountriesState newState) {
    _state = newState;
    notifyListeners();
  }

  List<CountryEntity> getSortedCountries() {
    final sortedList = List<CountryEntity>.from(_filteredCountries);
    sortedList.sort((a, b) => a.commonName.compareTo(b.commonName));
    return sortedList;
  }

  void clearSearch() {
    _searchQuery = '';
    _debounceTimer?.cancel();
    _filterCountries();
    notifyListeners();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
