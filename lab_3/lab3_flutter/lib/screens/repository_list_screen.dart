import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/repository.dart';
import '../providers/repository_provider.dart';
import 'repository_detail_screen.dart';

class RepositoryListScreen extends StatefulWidget {
  const RepositoryListScreen({super.key});

  @override
  State<RepositoryListScreen> createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  final List<String> _languages = [
    'Dart',
    'JavaScript',
    'TypeScript',
    'Python',
    'Java',
    'Kotlin',
    'Swift',
    'Go',
    'Rust',
    'C++',
    'C#',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RepositoryProvider>().fetchRepositories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Trending'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildLanguageSelector(),
          _buildFilterChips(),
          Expanded(child: _buildRepositoryList()),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Consumer<RepositoryProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _languages.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final language = _languages[index];
              final isSelected = provider.selectedLanguage == language;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(language),
                  selected: isSelected,
                  onSelected: (_) {
                    provider.setLanguage(language);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFilterChips() {
    return Consumer<RepositoryProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.filter_alt, size: 20),
              const SizedBox(width: 8),
              Chip(
                label: Text(provider.getTimeFilterLabel()),
                onDeleted: () => _showTimeFilterDialog(),
                deleteIcon: const Icon(Icons.arrow_drop_down, size: 20),
              ),
              const SizedBox(width: 8),
              Chip(
                label: Text(provider.getDateFilterLabel()),
                onDeleted: () => _showDateFilterDialog(),
                deleteIcon: const Icon(Icons.arrow_drop_down, size: 20),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRepositoryList() {
    return Consumer<RepositoryProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${provider.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.fetchRepositories(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (provider.repositories.isEmpty) {
          return const Center(child: Text('No repositories found'));
        }

        return RefreshIndicator(
          onRefresh: () => provider.fetchRepositories(),
          child: ListView.builder(
            itemCount: provider.repositories.length,
            itemBuilder: (context, index) {
              final repo = provider.repositories[index];
              return _buildRepositoryCard(repo);
            },
          ),
        );
      },
    );
  }

  Widget _buildRepositoryCard(GitHubRepository repo) {
    final numberFormat = NumberFormat.compact();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RepositoryDetailScreen(repository: repo),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (repo.avatarUrl != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(repo.avatarUrl!),
                      radius: 20,
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repo.ownerLogin,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          repo.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (repo.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  repo.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildStatChip(
                    Icons.star,
                    numberFormat.format(repo.stargazersCount),
                  ),
                  const SizedBox(width: 12),
                  _buildStatChip(
                    Icons.fork_right,
                    numberFormat.format(repo.forksCount),
                  ),
                  const SizedBox(width: 12),
                  _buildLanguageChip(repo.language),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(value, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildLanguageChip(String language) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: _getLanguageColor(language),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(language, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return Colors.blue;
      case 'javascript':
        return Colors.yellow[700]!;
      case 'typescript':
        return Colors.blue[700]!;
      case 'python':
        return Colors.blue[900]!;
      case 'java':
        return Colors.orange;
      case 'kotlin':
        return Colors.purple;
      case 'swift':
        return Colors.orange[700]!;
      case 'go':
        return Colors.cyan;
      case 'rust':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filters'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Time Range:'),
            const SizedBox(height: 8),
            _buildTimeFilterRadios(),
            const SizedBox(height: 16),
            const Text('Date Type:'),
            const SizedBox(height: 8),
            _buildDateFilterRadios(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFilterRadios() {
    return Consumer<RepositoryProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            RadioListTile<TimeFilter>(
              title: const Text('Today'),
              value: TimeFilter.today,
              groupValue: provider.timeFilter,
              onChanged: (value) {
                if (value != null) provider.setTimeFilter(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<TimeFilter>(
              title: const Text('This Week'),
              value: TimeFilter.thisWeek,
              groupValue: provider.timeFilter,
              onChanged: (value) {
                if (value != null) provider.setTimeFilter(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<TimeFilter>(
              title: const Text('This Month'),
              value: TimeFilter.thisMonth,
              groupValue: provider.timeFilter,
              onChanged: (value) {
                if (value != null) provider.setTimeFilter(value);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateFilterRadios() {
    return Consumer<RepositoryProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            RadioListTile<DateFilter>(
              title: const Text('Created Date'),
              value: DateFilter.created,
              groupValue: provider.dateFilter,
              onChanged: (value) {
                if (value != null) provider.setDateFilter(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<DateFilter>(
              title: const Text('Updated Date'),
              value: DateFilter.updated,
              groupValue: provider.dateFilter,
              onChanged: (value) {
                if (value != null) provider.setDateFilter(value);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showTimeFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Time Range'),
        content: _buildTimeFilterRadios(),
      ),
    );
  }

  void _showDateFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Date Type'),
        content: _buildDateFilterRadios(),
      ),
    );
  }
}
