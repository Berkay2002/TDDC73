# GitHub Trending Repositories Explorer

A modern Flutter application for discovering trending GitHub repositories across multiple programming languages with advanced filtering capabilities.

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)
![Material Design 3](https://img.shields.io/badge/Material%20Design-3-757575?logo=material-design)

## 📱 Features

### Core Functionality
- **Real-time Repository Discovery**: Browse trending GitHub repositories using the GitHub API
- **Multi-Language Support**: Filter by 11 popular programming languages (Dart, JavaScript, TypeScript, Python, Java, Kotlin, Swift, Go, Rust, C++, C#)
- **Flexible Time Filters**: View repositories from today, this week, or this month
- **Date Type Filtering**: Sort by creation date or last update date
- **Detailed Repository View**: Access comprehensive information including stats, dates, and direct GitHub links

### User Experience
- **Smooth Animations**: Staggered list animations, hero transitions, and loading skeletons
- **Material Design 3**: Modern, adaptive UI with light and dark theme support
- **Pull-to-Refresh**: Intuitive gesture-based content updates
- **Responsive Layout**: Optimized for various screen sizes
- **Error Handling**: User-friendly error messages with retry functionality
- **Empty States**: Helpful guidance when no results are found

### Technical Highlights
- **State Management**: Implements Provider pattern for reactive state updates
- **Efficient Rendering**: Uses ListView.builder for optimized list performance
- **Network Caching**: Minimizes redundant API calls
- **Type Safety**: Leverages Dart's strong typing and null safety
- **Clean Architecture**: Separation of concerns with models, services, providers, and screens

## 🏗️ Architecture

The project follows a layered architecture pattern:

```
lib/
├── main.dart                          # App entry point and theme configuration
├── models/
│   └── repository.dart                # Data model for GitHub repositories
├── services/
│   └── github_service.dart            # GitHub API client
├── providers/
│   └── repository_provider.dart       # State management with ChangeNotifier
└── screens/
    ├── repository_list_screen.dart    # Main list view with filters
    └── repository_detail_screen.dart  # Detailed repository information
```

### Layer Responsibilities

**Models**: Define data structures and JSON serialization
- `GitHubRepository`: Represents repository data with factory constructor for API parsing

**Services**: Handle external API communication
- `GitHubService`: Manages HTTP requests to GitHub Search API

**Providers**: Manage application state
- `RepositoryProvider`: Coordinates data fetching, filtering, and state notifications

**Screens**: Present UI and handle user interactions
- `RepositoryListScreen`: Displays filterable repository list
- `RepositoryDetailScreen`: Shows comprehensive repository details

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.9.2 or higher
- **Dart SDK**: 3.9.2 or higher
- **Platform-specific requirements**:
  - Windows: Visual Studio 2022 with C++ Desktop Development
  - macOS: Xcode 14.0 or higher
  - Linux: Development libraries (see Flutter documentation)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd lab_3/lab3_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```

4. **Run the application**

   For Windows:
   ```bash
   flutter run -d windows
   ```

   For other platforms:
   ```bash
   flutter run
   ```

## 📦 Dependencies

### Core Dependencies
- **[provider](https://pub.dev/packages/provider)** `^6.0.5` - State management solution
- **[http](https://pub.dev/packages/http)** `^1.1.0` - HTTP client for API requests
- **[intl](https://pub.dev/packages/intl)** `^0.19.0` - Internationalization and number formatting
- **[url_launcher](https://pub.dev/packages/url_launcher)** `^6.3.1` - Opening URLs in external browsers

### Development Dependencies
- **flutter_lints** `^5.0.0` - Recommended linting rules for Flutter

## 🎨 Design System

### Color Scheme
- **Primary Color**: GitHub Green (#2DA44E)
- **Theme Mode**: System-adaptive (light/dark)
- **Material Design**: Version 3 with dynamic color schemes

### Typography
- **Font Weights**: 400 (normal), 500 (medium), 600 (semibold), 700 (bold)
- **Responsive Sizing**: Uses Material Design type scale

### Components
- **Cards**: Flat design with subtle borders, 12px corner radius
- **Chips**: Rounded (20px) for tags and filters
- **Icons**: Material Design icon set
- **Animations**: 200-400ms durations with easing curves

## 🔌 API Integration

### GitHub REST API v3

**Endpoint**: `https://api.github.com/search/repositories`

**Query Parameters**:
- `q`: Search query with filters (e.g., `language:Dart created:>2024-01-01`)
- `sort`: Sorting field (default: `stars`)
- `order`: Sort order (default: `desc`)
- `per_page`: Results per page (max: 100)

**Rate Limits**:
- Unauthenticated requests: 60 per hour
- Authenticated requests: 5,000 per hour (not implemented in current version)

**Search Qualifiers**:
- `language:<language>` - Filter by programming language
- `created:>YYYY-MM-DD` - Repositories created after date
- `pushed:>YYYY-MM-DD` - Repositories updated after date

### Response Format
```json
{
  "items": [
    {
      "name": "repository-name",
      "full_name": "owner/repository-name",
      "description": "Repository description",
      "stargazers_count": 1500,
      "forks_count": 300,
      "open_issues_count": 25,
      "language": "Dart",
      "html_url": "https://github.com/owner/repository-name",
      "created_at": "2024-01-15T10:30:00Z",
      "updated_at": "2024-01-20T14:45:00Z",
      "owner": {
        "login": "owner-username",
        "avatar_url": "https://avatars.githubusercontent.com/u/..."
      }
    }
  ]
}
```

## 📖 Code Structure and Patterns

### State Management with Provider

```dart
// Accessing provider data
Consumer<RepositoryProvider>(
  builder: (context, provider, child) {
    return ListView.builder(
      itemCount: provider.repositories.length,
      itemBuilder: (context, index) => RepositoryCard(
        repository: provider.repositories[index],
      ),
    );
  },
)
```

### Navigation with Custom Transitions

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  ),
);
```

### Hero Animations

```dart
// In list item
Hero(
  tag: 'avatar_${repository.fullName}',
  child: CircleAvatar(
    backgroundImage: NetworkImage(repository.avatarUrl),
  ),
)

// In detail screen (same tag)
Hero(
  tag: 'avatar_${repository.fullName}',
  child: CircleAvatar(
    backgroundImage: NetworkImage(repository.avatarUrl),
    radius: 50,
  ),
)
```

## 🧪 Testing

Run tests with:
```bash
flutter test
```

### Test Coverage
- Unit tests for models and services
- Widget tests for UI components
- Integration tests for user flows

## 🛠️ Development

### Code Style
The project follows official Dart and Flutter style guidelines enforced by `flutter_lints`.

Run linter:
```bash
flutter analyze
```

Format code:
```bash
flutter format .
```

### Adding New Features

1. **Create feature branch**
   ```bash
   git checkout -b feature/new-feature
   ```

2. **Implement changes** following existing architecture patterns

3. **Run tests and linter**
   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit and push**
   ```bash
   git add .
   git commit -m "Add new feature"
   git push origin feature/new-feature
   ```

## 🐛 Troubleshooting

### Common Issues

**Issue**: Dependencies not found
```bash
flutter clean
flutter pub get
```

**Issue**: Build errors on Windows
- Ensure Visual Studio 2022 with C++ Desktop Development is installed
- Run `flutter doctor` to verify setup

**Issue**: API rate limit exceeded
- Wait for rate limit reset (1 hour for unauthenticated requests)
- Consider implementing GitHub authentication for higher limits

**Issue**: Network errors
- Check internet connection
- Verify GitHub API is accessible
- Check for firewall/proxy restrictions

## 📚 Learning Resources

### Flutter Documentation
- [Flutter Official Docs](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design 3](https://m3.material.io/)

### Key Concepts Demonstrated
- **StatefulWidget vs StatelessWidget**: Understanding widget lifecycle
- **Provider Pattern**: Reactive state management
- **Async/Await**: Asynchronous programming in Dart
- **JSON Serialization**: Converting API responses to typed objects
- **Animations**: Creating smooth, polished user experiences
- **Material Design**: Implementing consistent, beautiful UIs

### Related Tutorials
- [Provider Package Documentation](https://pub.dev/packages/provider)
- [HTTP Requests in Flutter](https://docs.flutter.dev/cookbook/networking/fetch-data)
- [Flutter Animations](https://docs.flutter.dev/development/ui/animations)

## 📖 Educational Comments

This codebase includes extensive educational comments following these principles:

- **Why over What**: Comments explain the reasoning behind design decisions
- **Concept Introduction**: Key Flutter and Dart concepts are explained inline
- **Best Practices**: Comments highlight recommended patterns and approaches
- **Learning Progression**: Comments are structured to build understanding incrementally

Each file contains numbered notes (Note 1, Note 2, etc.) that:
- Introduce language features and Flutter concepts
- Explain architectural patterns
- Highlight Material Design principles
- Demonstrate best practices

## 📄 License

This project is created for educational purposes as part of TDDC73 course work.

## 👥 Contributing

This is an academic project. For course-related questions, please contact the course instructors.

## 🔮 Future Enhancements

- [ ] GitHub authentication for higher API rate limits
- [ ] Favorite/bookmark repositories locally
- [ ] Search by repository name
- [ ] Filter by topics/tags
- [ ] Repository comparison feature
- [ ] Offline mode with cached data
- [ ] Share functionality using native share dialog
- [ ] Repository statistics visualization
- [ ] Multi-language UI support
- [ ] Custom theme customization

## 📞 Support

For technical issues:
1. Check the [Troubleshooting](#-troubleshooting) section
2. Review [Flutter's documentation](https://docs.flutter.dev/)
3. Search [GitHub Issues](https://github.com/flutter/flutter/issues)

---

**Built with ❤️ using Flutter and Material Design 3**

