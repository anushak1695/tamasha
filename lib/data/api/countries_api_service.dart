import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class CountriesApiService {
  static const String _baseUrl = 'https://restcountries.com/v3.1';

  Future<List<Country>> getCountries() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/all?fields=name'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }
}
