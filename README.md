# Countries App - Flutter Assignment

A Flutter application that displays countries from around the world using the REST Countries API. This project demonstrates clean architecture principles, proper state management, and modern UI design.

## Features

- 🌍 **Countries List**: Displays all countries with their common and official names
- 📱 **Modern UI**: Beautiful Material Design 3 interface with cards and avatars
- 🔄 **State Management**: Uses Provider pattern for efficient state management
- 🏗️ **Clean Architecture**: Follows clean architecture principles with proper separation of concerns
- 📊 **Loading States**: Proper loading, error, and success state handling
- 🔍 **Sorted Display**: Countries are displayed in alphabetical order
- 🎨 **Responsive Design**: Works on various screen sizes

## Project Structure

```
lib/
├── core/
│   └── di/
│       └── dependency_injection.dart
├── data/
│   ├── api/
│   │   └── countries_api_service.dart
│   └── repositories/
│       └── countries_repository.dart
├── domain/
│   └── usecases/
│       └── get_countries_usecase.dart
├── models/
│   └── country.dart
├── presentation/
│   ├── providers/
│   │   └── countries_provider.dart
│   ├── screens/
│   │   └── countries_screen.dart
│   └── widgets/
│       └── country_list_item.dart
└── main.dart
```

## Architecture Layers

### 1. **Presentation Layer** (`presentation/`)
- **Screens**: UI screens and their logic
- **Widgets**: Reusable UI components
- **Providers**: State management using Provider pattern

### 2. **Domain Layer** (`domain/`)
- **Use Cases**: Business logic and application rules
- **Entities**: Core business objects (models)

### 3. **Data Layer** (`data/`)
- **Repositories**: Data access abstraction
- **API Services**: External API communication
- **Models**: Data transfer objects

### 4. **Core Layer** (`core/`)
- **Dependency Injection**: Service locator and DI setup

## API Integration

The app uses the [REST Countries API](https://restcountries.com/) to fetch country data:

- **Endpoint**: `https://restcountries.com/v3.1/all?fields=name`
- **Response**: JSON array of countries with name information
- **Fields**: Only fetches the `name` field to optimize performance

## Dependencies

- **http**: For API requests
- **provider**: For state management
- **json_annotation**: For JSON serialization
- **json_serializable**: For code generation
- **build_runner**: For generating JSON serialization code

## Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd tamasha_project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate JSON serialization code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## State Management

The app uses the **Provider** pattern for state management:

- **CountriesProvider**: Manages the state of countries data
- **States**: `initial`, `loading`, `loaded`, `error`
- **Features**: Automatic loading, error handling, retry functionality

## UI Components

### Country List Item
- Displays country common name as title
- Shows official name as subtitle
- Includes avatar with country initial
- Card-based design with elevation

### Countries Screen
- App bar with title
- Loading indicator during API calls
- Error state with retry button
- Scrollable list of countries
- Country count display

## Error Handling

- **Network Errors**: Displays user-friendly error messages
- **API Errors**: Handles HTTP status codes
- **Retry Functionality**: Users can retry failed requests
- **Graceful Degradation**: App remains functional even with errors

## Performance Optimizations

- **Lazy Loading**: Countries are loaded only when needed
- **Efficient API Calls**: Only fetches required fields
- **Optimized UI**: Uses ListView.builder for large lists
- **Memory Management**: Proper disposal of resources

## Testing

To run tests:
```bash
flutter test
```

## Build

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

### Web
```bash
flutter build web
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is created for educational purposes as part of a Flutter assignment.

## Screenshots

The app features a clean, modern interface with:
- Material Design 3 components
- Smooth animations and transitions
- Responsive layout
- Intuitive user experience

---

**All the best!** 🚀
