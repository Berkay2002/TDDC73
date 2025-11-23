import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/repository.dart';

class GitHubService {
  static const String _baseUrl = 'https://api.github.com';

  Future<List<GitHubRepository>> searchRepositories({
    required String language,
    required DateTime since,
    String sortBy = 'stars',
  }) async {
    final sinceDate = since.toIso8601String().split('T')[0];
    final query = 'language:$language created:>$sinceDate';

    final uri = Uri.parse('$_baseUrl/search/repositories').replace(
      queryParameters: {
        'q': query,
        'sort': sortBy,
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

  Future<List<GitHubRepository>> getUpdatedRepositories({
    required String language,
    required DateTime since,
  }) async {
    final sinceDate = since.toIso8601String().split('T')[0];
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
