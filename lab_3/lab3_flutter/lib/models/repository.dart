class GitHubRepository {
  final String name;
  final String fullName;
  final String? description;
  final int stargazersCount;
  final int forksCount;
  final int openIssuesCount;
  final String language;
  final String? avatarUrl;
  final String ownerLogin;
  final String htmlUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

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

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String?,
      stargazersCount: json['stargazers_count'] as int,
      forksCount: json['forks_count'] as int,
      openIssuesCount: json['open_issues_count'] as int,
      language: json['language'] as String? ?? 'Unknown',
      avatarUrl: json['owner']['avatar_url'] as String?,
      ownerLogin: json['owner']['login'] as String,
      htmlUrl: json['html_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
