// Note 1: Import dart:convert for JSON encoding and decoding functionality
import 'dart:convert';

// Note 2: The 'as' keyword creates an alias for the imported library
// This prevents naming conflicts if multiple libraries export 'http'
import 'package:http/http.dart' as http;

// Note 3: Import our model to convert JSON responses into typed objects
import '../models/repository.dart';

// Note 4: A service class encapsulates all API communication logic
// This separates network concerns from UI and state management
class GitHubService {
  // Note 5: Static const values are compile-time constants shared across all instances
  // Using const for the base URL ensures it cannot be modified and saves memory
  static const String _baseUrl = 'https://api.github.com';

  // Note 6: async functions return a Future, which represents a potential value
  // Future<List<...>> means this will eventually return a list of repositories
  Future<List<GitHubRepository>> searchRepositories({
    required String language,
    required DateTime since,
    // Note 7: Default parameters provide fallback values if not specified
    String sortBy = 'stars',
  }) async {
    // Note 8: Extract just the date portion from DateTime (YYYY-MM-DD format)
    // split('T')[0] removes the time component from ISO 8601 format
    final sinceDate = since.toIso8601String().split('T')[0];

    // Note 9: GitHub search query syntax: combine filters with spaces
    // 'language:Dart created:>2024-01-01' finds Dart repos created after that date
    final query = 'language:$language created:>$sinceDate';

    // Note 10: Uri.parse creates a URI, then replace() modifies query parameters
    // This is safer than string concatenation for building URLs
    final uri = Uri.parse('$_baseUrl/search/repositories').replace(
      queryParameters: {
        'q': query,
        'sort': sortBy,
        'order': 'desc',
        // Note 11: per_page limits results to 100 (GitHub's maximum per request)
        'per_page': '100',
      },
    );

    // Note 12: await pauses execution until the HTTP request completes
    // This prevents blocking the UI thread while waiting for the response
    final response = await http.get(uri);

    // Note 13: HTTP status code 200 indicates a successful request
    if (response.statusCode == 200) {
      // Note 14: json.decode converts the JSON string into Dart objects
      // The result is a Map<String, dynamic> representing the response structure
      final data = json.decode(response.body);

      // Note 15: GitHub wraps search results in an 'items' array
      final items = data['items'] as List;

      // Note 16: map() transforms each JSON object into a GitHubRepository instance
      // toList() converts the iterable result into a concrete List
      return items.map((json) => GitHubRepository.fromJson(json)).toList();
    } else {
      // Note 17: Throwing an exception propagates the error to the caller
      // This allows the UI layer to handle and display the error appropriately
      throw Exception('Failed to load repositories: ${response.statusCode}');
    }
  }

  // Note 18: A separate method for fetching recently updated repositories
  // This demonstrates code reuse while supporting different search criteria
  Future<List<GitHubRepository>> getUpdatedRepositories({
    required String language,
    required DateTime since,
  }) async {
    final sinceDate = since.toIso8601String().split('T')[0];

    // Note 19: 'pushed' filter finds repositories with recent commits
    // This differs from 'created' which only considers initial creation date
    final query = 'language:$language pushed:>$sinceDate';

    final uri = Uri.parse('$_baseUrl/search/repositories').replace(
      queryParameters: {
        'q': query,
        'sort': 'stars',
        'order': 'desc',
        'per_page': '100',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List;
      return items.map((json) => GitHubRepository.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load repositories: ${response.statusCode}');
    }
  }
}
