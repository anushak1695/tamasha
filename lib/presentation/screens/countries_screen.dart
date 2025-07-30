import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/countries_provider.dart';
import '../widgets/country_list_item.dart';
import '../widgets/search_bar_widget.dart';
import '../../core/utils/adaptive_size.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CountriesProvider>().loadCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2196F3),
              Color(0xFF00BCD4),
              Color(0xFF3F51B5),
              Color(0xFF673AB7),
              Color(0xFF9C27B0),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(AdaptiveSize.w(20)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AdaptiveSize.w(6)),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AdaptiveSize.w(12)),
                      ),
                      child: Icon(
                        Icons.public,
                        color: Colors.white,
                        size: AdaptiveSize.w(24),
                      ),
                    ),
                    SizedBox(width: AdaptiveSize.w(16)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Countries List',
                            style: TextStyle(
                              fontSize: AdaptiveSize.sp(24),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SearchBarWidget(),

              Expanded(
                child: Consumer<CountriesProvider>(
                  builder: (context, provider, child) {
                    switch (provider.state) {
                      case CountriesState.loading:
                        return const _LoadingState();
                      case CountriesState.loaded:
                        return _LoadedState(
                          countries: provider.getSortedCountries(),
                        );
                      case CountriesState.error:
                        return _ErrorState(
                          errorMessage: provider.errorMessage,
                          onRetry: () => provider.loadCountries(),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(AdaptiveSize.w(20)),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AdaptiveSize.w(20)),
            ),
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: AdaptiveSize.w(3),
            ),
          ),
          SizedBox(height: AdaptiveSize.h(24)),
          Text(
            'Loading countries...',
            style: TextStyle(
              fontSize: AdaptiveSize.sp(20),
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: AdaptiveSize.h(8)),
          Text(
            'Please wait while we fetch the data',
            style: TextStyle(
              fontSize: AdaptiveSize.sp(20),
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadedState extends StatelessWidget {
  final List<dynamic> countries;

  const _LoadedState({required this.countries});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AdaptiveSize.w(16)),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AdaptiveSize.w(20)),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AdaptiveSize.w(24)),
                topRight: Radius.circular(AdaptiveSize.w(24)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: AdaptiveSize.w(10),
                  offset: Offset(0, AdaptiveSize.h(2)),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AdaptiveSize.w(8)),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F51B5).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AdaptiveSize.w(8)),
                  ),
                  child: Icon(
                    Icons.flag,
                    color: Color(0xFF3F51B5),
                    size: AdaptiveSize.w(20),
                  ),
                ),
                SizedBox(width: AdaptiveSize.w(12)),
                Expanded(
                  child: Consumer<CountriesProvider>(
                    builder: (context, provider, child) {
                      final totalCountries = provider.countries.length;
                      final searchQuery = provider.searchQuery;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            searchQuery.isEmpty
                                ? '$totalCountries Countries'
                                : '$totalCountries Results',
                            style: TextStyle(
                              fontSize: AdaptiveSize.sp(20),
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Text(
                            searchQuery.isEmpty
                                ? 'All countries available for viewing'
                                : 'Search results for "$searchQuery"',
                            style: TextStyle(
                              fontSize: AdaptiveSize.sp(16),
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Consumer<CountriesProvider>(
              builder: (context, provider, child) {
                return RefreshIndicator(
                  onRefresh: provider.loadCountries,
                  color: const Color(0xFF3F51B5),
                  backgroundColor: Colors.white,
                  child: countries.isEmpty && provider.searchQuery.isNotEmpty
                      ? _buildEmptySearchState()
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: AdaptiveSize.w(16),
                            vertical: AdaptiveSize.h(8),
                          ),
                          itemCount: countries.length,
                          itemBuilder: (context, index) {
                            return CountryListItem(country: countries[index]);
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(AdaptiveSize.w(24)),
            decoration: BoxDecoration(
              color: const Color(0xFF3F51B5).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AdaptiveSize.w(20)),
            ),
            child: Icon(
              Icons.search_off,
              size: AdaptiveSize.w(64),
              color: Color(0xFF3F51B5),
            ),
          ),
          SizedBox(height: AdaptiveSize.h(24)),
          Text(
            'No countries found',
            style: TextStyle(
              fontSize: AdaptiveSize.sp(20),
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: AdaptiveSize.h(8)),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              fontSize: AdaptiveSize.sp(20),
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const _ErrorState({required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AdaptiveSize.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AdaptiveSize.w(20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(AdaptiveSize.w(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(AdaptiveSize.w(20)),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B6B).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AdaptiveSize.w(20)),
              ),
              child: Icon(
                Icons.error_outline,
                size: AdaptiveSize.w(64),
                color: Color(0xFFFF6B6B),
              ),
            ),
            SizedBox(height: AdaptiveSize.h(24)),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: AdaptiveSize.sp(20),
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AdaptiveSize.h(12)),
            Text(
              errorMessage,
              style: TextStyle(
                fontSize: AdaptiveSize.sp(20),
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AdaptiveSize.h(32)),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F51B5),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: AdaptiveSize.w(32),
                  vertical: AdaptiveSize.h(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
