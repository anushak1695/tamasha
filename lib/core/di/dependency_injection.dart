import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../data/api/countries_api_service.dart';
import '../../data/repositories/countries_repository_impl.dart';
import '../../domain/repositories/countries_repository.dart';
import '../../domain/usecases/get_countries_usecase.dart';
import '../../presentation/providers/countries_provider.dart';
import '../../presentation/screens/countries_screen.dart';

class DependencyInjection {
  static Widget getProviders() {
    return MultiProvider(
      providers: [
        Provider<CountriesApiService>(create: (_) => CountriesApiService()),

        Provider<CountriesRepository>(
          create: (context) => CountriesRepositoryImpl(
            apiService: context.read<CountriesApiService>(),
          ),
        ),

        Provider<GetCountriesUseCase>(
          create: (context) =>
              GetCountriesUseCase(context.read<CountriesRepository>()),
        ),

        ChangeNotifierProvider<CountriesProvider>(
          create: (context) =>
              CountriesProvider(context.read<GetCountriesUseCase>()),
        ),
      ],
      child: const CountriesScreen(),
    );
  }
}
