# AGENTS.md - Frontend Development Guide

## Project Overview

**theoriemeister-app-frontend**: Flutter mobile application for the Theoriemeister driving license exam preparation platform.

- **Framework**: Flutter 3.11.4+
- **Language**: Dart
- **Architecture**: Early-stage project with Material Design
- **Supported Platforms**: iOS, Android, Web, Windows, macOS, Linux
- **Build Tool**: Flutter/Dart native

## Getting Started

### Prerequisites

```bash
# Install Flutter SDK (if not already installed)
# https://docs.flutter.dev/get-started/install

flutter --version  # Verify installation
dart --version     # Dart should come with Flutter
```

### Initial Setup

```bash
# Get dependencies
flutter pub get

# Generate build files
flutter pub get

# Run on default device
flutter run

# Build for specific platform
flutter build ios
flutter build apk        # Android
flutter build web        # Web
flutter build windows    # Windows
flutter build macos      # macOS
flutter build linux      # Linux
```

### Development Mode

```bash
# Hot reload enabled (automatic on save)
flutter run

# With specific device
flutter run -d chrome          # Web
flutter run -d "iPhone 15"     # iOS simulator
flutter run -d emulator        # Android emulator

# Debug output
flutter run -v                 # Verbose logging
```

### Analysis & Formatting

```bash
# Run lints (defined in analysis_options.yaml)
flutter analyze

# Format code
dart format lib/

# Fix issues automatically
dart fix --apply
```

## Project Structure

```
lib/
├── main.dart                # App entry point
├── register_screen.dart     # User registration screen
└── [future screens]/        # Additional screens

assets/
└── logo.png                 # App logo

test/
└── widget_test.dart        # Widget tests

android/                     # Android-specific configuration
ios/                        # iOS-specific configuration
web/                        # Web-specific configuration
windows/                    # Windows-specific configuration
macos/                      # macOS-specific configuration
linux/                      # Linux-specific configuration

pubspec.yaml                # Dependencies and metadata
analysis_options.yaml       # Code analysis rules
```

## Dependencies

### Current

- `flutter` - Core framework
- `cupertino_icons` ^1.0.8 - iOS-style app icons
- `flutter_lints` ^6.0.0 - Code quality rules (dev only)
- `flutter_test` - Widget testing (dev only)

### Common Flutter Packages (When Needed)

**For API Communication:**
- `http` or `dio` - HTTP client
- `retrofit` - Type-safe HTTP client

**For State Management:**
- `provider` - Simple state management
- `riverpod` - Improved state management

**For Local Storage:**
- `hive` - NoSQL database
- `sqflite` - SQLite wrapper

**For UI Components:**
- `material_design_icons_flutter` - Material icons extension

## Architecture Patterns (For Frontend Development)

### Current State: Early Stage

The project is in early development with two main screens:
- `main.dart` - App root and home screen
- `register_screen.dart` - User registration

### Recommended Patterns as Project Grows

#### 1. State Management

Consider using `provider` for simple scenarios:

```dart
// lib/providers/auth_provider.dart
final authProvider = StateNotifierProvider((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthState(const AuthState.initial());
  
  Future<void> register(String name, String email, String password) async {
    // Call backend API
  }
}
```

#### 2. Service Layer

```dart
// lib/services/api_client.dart
class ApiClient {
  static const baseUrl = 'http://localhost:8000/api';
  
  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    
    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Registration failed');
  }
}
```

#### 3. Models (for JSON serialization)

```dart
// lib/models/user.dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final String preferredLocale;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.preferredLocale,
  });
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

#### 4. Screen Structure

```dart
// lib/screens/question_screen.dart
class QuestionScreen extends StatefulWidget {
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question')),
      body: Center(child: Text('Question content')),
    );
  }
}
```

## Material Design

The app uses Flutter's Material theme. Customize in `main.dart`:

```dart
MaterialApp(
  title: 'Theorie Meister',
  locale: Locale('de', 'DE'),  // German locale
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
    ),
  ),
  home: const RegisterScreen(),
)
```

## Testing

### Widget Tests

```dart
// test/widget_test.dart
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
```

### Running Tests

```bash
flutter test
flutter test --coverage  # Generate coverage report
```

## API Integration

### Connecting to Backend

Backend runs on `http://localhost:8000/api`

1. **Authentication Endpoint**: `POST /auth/register`
2. **Get Current User**: `GET /auth/me` (requires token)
3. **License Classes**: `GET /license-classes`
4. **Questions**: `GET /questions`
5. **Exam Sessions**: `POST /exam-sessions` (start), `GET /exam-sessions`

### Example: Register User

```dart
final response = await http.post(
  Uri.parse('http://localhost:8000/api/auth/register'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'name': 'Max Muster',
    'email': 'max@example.com',
    'password': 'password123',
    'password_confirmation': 'password123',
    'preferred_locale': 'de',
  }),
);

if (response.statusCode == 201) {
  final data = jsonDecode(response.body);
  final token = data['token'];
  final user = data['user'];
  // Store token securely (use flutter_secure_storage)
} else {
  final errors = jsonDecode(response.body)['errors'];
  // Show validation errors
}
```

## Localization (German Default)

The app defaults to German. Implement localization as the project grows:

```dart
// lib/l10n/app_localizations.dart
extension AppLocalizationX on BuildContext {
  String get helloWorld => 'Hallo Welt';
  String get registerTitle => 'Registrierung';
}
```

Use in widgets:

```dart
Text(context.registerTitle)  // Shows 'Registrierung'
```

## Building & Distribution

### iOS

```bash
flutter build ios --release
# Open output in Xcode for deployment
open build/ios/workspace/Runner.xcworkspace
```

### Android

```bash
flutter build apk --release
# Or bundle for Play Store
flutter build appbundle --release
```

### Web

```bash
flutter build web --release
# Output in build/web/
```

## Performance Considerations

1. **Use `const` constructors** whenever possible for widgets
2. **Lazy load screens** using `PageView` or navigation
3. **Profile performance** with DevTools:
   ```bash
   flutter pub global activate devtools
   devtools
   ```
4. **Use `RepaintBoundary`** for widgets that repaint frequently

## Debugging

```bash
# Open Flutter DevTools
flutter pub global activate devtools
devtools

# Or automatic with run
flutter run --devtools-server-address localhost:9100

# Show logs
flutter logs

# Verbose output
flutter run -v

# Break on exceptions
flutter run
# Then type 'p' to toggle breakpoints
```

## Code Quality

```bash
# Run analysis
flutter analyze

# Format code
dart format lib/

# Fix lints automatically
dart fix --apply
```

Check rules in `analysis_options.yaml`.

## Important Notes for AI Agents

1. **Use `const` constructors** - saves memory and improves performance
2. **Responsive design**: Use `MediaQuery` and `LayoutBuilder` for different screen sizes
3. **Hot reload**: Changes to Dart code reflect immediately during development
4. **State management**: Consider when the app grows beyond two screens
5. **Secure storage**: Store authentication tokens securely, never in SharedPreferences
6. **Error handling**: Always handle API errors gracefully with user-friendly messages
7. **Locale default**: German ('de') should be default locale
8. **Platform channels**: Can call native code for platform-specific features
9. **Testing**: Write widget tests for critical UI flows
10. **Asset management**: All assets defined in `pubspec.yaml`, organized in `assets/` folder

