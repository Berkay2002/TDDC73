// Note 1: A model class represents the data structure for a GitHub repository
// It encapsulates all the properties we need to display repository information
class GitHubRepository {
  // Note 2: Final fields are immutable after initialization
  // This ensures our model instances cannot be accidentally modified
  final String name;
  final String fullName;

  // Note 3: The question mark (?) denotes a nullable type
  // Some repositories may not have a description, so we allow null values
  final String? description;

  // Note 4: GitHub statistics are stored as integers for precise counting
  final int stargazersCount;
  final int forksCount;
  final int openIssuesCount;

  final String language;
  final String? avatarUrl;
  final String ownerLogin;
  final String htmlUrl;

  // Note 5: DateTime objects store timestamps with full date and time precision
  final DateTime createdAt;
  final DateTime updatedAt;

  // Note 6: A named constructor with required parameters ensures all data is provided
  // Using 'required' prevents instantiation with missing values
  GitHubRepository({
    required this.name,
    required this.fullName,
    required this.description,
    required this.stargazersCount,
    required this.forksCount,
    required this.openIssuesCount,
    required this.language,
    required this.avatarUrl,
    required this.ownerLogin,
    required this.htmlUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // Note 7: Factory constructors can return cached instances or subclasses
  // Here we use it to parse JSON data from the GitHub API
  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      // Note 8: Type casting ('as String') ensures type safety
      // If the value isn't a String, Dart throws a type error at runtime
      name: json['name'] as String,
      fullName: json['full_name'] as String,

      // Note 9: Nullable cast allows the value to be null without throwing an error
      description: json['description'] as String?,

      stargazersCount: json['stargazers_count'] as int,
      forksCount: json['forks_count'] as int,
      openIssuesCount: json['open_issues_count'] as int,

      // Note 10: The null-coalescing operator (??) provides a default value
      // If language is null, we use 'Unknown' instead
      language: json['language'] as String? ?? 'Unknown',

      // Note 11: Nested JSON access - we navigate into the 'owner' object
      // to retrieve the avatar URL from the repository owner's data
      avatarUrl: json['owner']['avatar_url'] as String?,
      ownerLogin: json['owner']['login'] as String,

      htmlUrl: json['html_url'] as String,

      // Note 12: DateTime.parse converts ISO 8601 string format to DateTime object
      // GitHub API returns dates like "2024-01-15T10:30:00Z"
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
