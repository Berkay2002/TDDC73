# GitHub Trending Repositories Explorer

A Flutter application that displays trending GitHub repositories filtered by programming language, time range, and date type (created/updated). This app allows users to explore popular repositories similar to GitHub's Trending page.

## Features

- **Multi-language support**: Browse repositories in Dart, JavaScript, TypeScript, Python, Java, Kotlin, Swift, Go, Rust, C++, and C#
- **Time filtering**: Filter repositories by Today, This Week, or This Month
- **Date type filtering**: Filter by repository creation date or last update date
- **Sorting by popularity**: Repositories are sorted by star count
- **Detailed repository view**: View comprehensive details including stats, description, and metadata
- **Pull to refresh**: Refresh the repository list with a swipe down gesture
- **Material Design 3**: Modern UI with Material Design 3 components

## Screenshots

The app includes:
- A scrollable list of repositories with language selector chips
- Filter options for time range and date type
- Repository cards showing owner, name, description, stars, forks, and language
- Detailed repository screen with complete information

## Requirements

- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- Internet connection for GitHub API access

## Dependencies

- `http: ^1.1.0` - For making HTTP requests to GitHub API
- `provider: ^6.0.5` - State management
- `intl: ^0.19.0` - Internationalization and date formatting

## Installation

1. Clone or download this project
2. Navigate to the project directory:
   ```bash
   cd lab3_flutter
   ```
3. Get dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Usage

### Browsing Repositories

1. **Select a programming language**: Tap on any language chip at the top to filter repositories
2. **Adjust time filter**: Tap the time filter chip to choose between Today, This Week, or This Month
3. **Change date type**: Tap the date filter chip to switch between Created and Updated dates
4. **View details**: Tap on any repository card to see detailed information
5. **Refresh**: Pull down on the list to refresh the data

### Repository Details

The detail screen shows:
- Repository owner and name
- Description
- Statistics (stars, forks, open issues)
- Programming language
- Creation and last update dates
- Repository URL with copy functionality

## GitHub API Usage

This app uses the GitHub REST API v3 to search for repositories. The API endpoints used:

- `/search/repositories` - Search repositories with filters

### API Rate Limiting

GitHub API has rate limits:
- Unauthenticated requests: 60 requests per hour
- Authenticated requests: 5,000 requests per hour

This app uses unauthenticated requests, so you may encounter rate limiting if you refresh frequently.

## Project Structure

```
lib/
├── main.dart                           # App entry point
├── models/
│   └── repository.dart                 # Repository data model
├── providers/
│   └── repository_provider.dart        # State management with Provider
├── screens/
│   ├── repository_list_screen.dart     # Main screen with repository list
│   └── repository_detail_screen.dart   # Detail screen for a repository
└── services/
    └── github_service.dart             # GitHub API service
```

## Code Quality

This project follows the self-explanatory code guidelines:
- Minimal comments focused on explaining WHY, not WHAT
- Clear and descriptive naming conventions
- Well-structured and modular code
- Proper error handling and loading states

## Platform Support

This project can run on:
- Windows
- macOS
- Linux
- iOS
- Android
- Web

## Future Enhancements

Potential improvements:
- Add authentication for higher API rate limits
- Implement GraphQL instead of REST API
- Add favorites/bookmarks functionality
- Include user profiles and search
- Add more filter options (stars range, license type, etc.)
- Implement caching for offline viewing
- Add dark mode theme

## License

This is an educational project created for TDDC73 course.

## Author

Created as part of Lab 3 assignment for learning mobile development with Flutter.

