// Note 1: Material.dart provides Flutter's Material Design components
import 'package:flutter/material.dart';

// Note 2: intl package handles internationalization and number formatting
// NumberFormat.compact() converts numbers like 1000 to "1K"
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../models/repository.dart';
import '../providers/repository_provider.dart';
import 'repository_detail_screen.dart';

// Note 3: StatefulWidget can change its internal state during its lifetime
// This is necessary for managing animations and loading states
class RepositoryListScreen extends StatefulWidget {
  const RepositoryListScreen({super.key});

  @override
  State<RepositoryListScreen> createState() => _RepositoryListScreenState();
}

// Note 4: SingleTickerProviderStateMixin provides a Ticker for animations
// Tickers drive animations by calling a callback on every frame
class _RepositoryListScreenState extends State<RepositoryListScreen>
    with SingleTickerProviderStateMixin {
  // Note 5: A curated list of popular programming languages
  // final makes this list reference immutable (though contents can still be modified)
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

  // Note 6: 'late' indicates this will be initialized before first use
  // AnimationController manages animation timing and state
  late AnimationController _animationController;

  // Note 7: initState is called once when the widget is inserted into the widget tree
  // This is the ideal place for one-time setup like creating controllers
  @override
  void initState() {
    super.initState();

    // Note 8: vsync: this synchronizes the animation with the screen refresh rate
    // This prevents off-screen animations from consuming resources
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Note 9: addPostFrameCallback ensures the callback runs after the first frame
    // This prevents calling read() on a provider before the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RepositoryProvider>().fetchRepositories();
    });
  }

  // Note 10: dispose is called when the widget is permanently removed
  // Always dispose controllers and streams to prevent memory leaks
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Note 11: Scaffold provides the basic Material Design layout structure
    // It includes slots for app bars, body, floating action buttons, etc.
    return Scaffold(
      appBar: AppBar(
        // Note 12: Row arranges children horizontally
        // Here it combines an icon and text for a custom title
        title: Row(
          children: [
            Icon(
              Icons.trending_up,
              // Note 13: Theme.of(context) accesses the current theme
              // This ensures colors adapt to light/dark mode automatically
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text(
              'GitHub Trending',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        // Note 14: actions are widgets displayed on the right side of the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              // Note 15: context.read() gets the provider without listening for changes
              // Use read() for one-time actions, watch() for reactive rebuilds
              context.read<RepositoryProvider>().fetchRepositories();
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Filters',
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      // Note 16: Column stacks widgets vertically
      // Expanded makes the repository list fill remaining space
      body: Column(
        children: [
          _buildLanguageSelector(),
          _buildFilterChips(),
          Expanded(child: _buildRepositoryList()),
        ],
      ),
    );
  }

  // Note 17: Consumer rebuilds only this widget when provider data changes
  // This is more efficient than using context.watch() at the top level
  Widget _buildLanguageSelector() {
    return Consumer<RepositoryProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            // Note 18: Border.only allows customizing individual borders
            // withOpacity(0.1) creates a subtle, semi-transparent divider
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
              ),
            ),
          ),
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 8),
          // Note 19: ListView.builder efficiently creates items on-demand
          // Only visible items are built, improving performance for long lists
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _languages.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final language = _languages[index];
              final isSelected = provider.selectedLanguage == language;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                // Note 20: AnimatedContainer automatically animates property changes
                // Duration determines how long the transition takes
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  // Note 21: ChoiceChip is a Material Design component for single selection
                  child: ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Note 22: Language color indicators provide visual distinction
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getLanguageColor(language),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          language,
                          style: TextStyle(
                            // Note 23: Dynamic styling based on selection state
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (_) {
                      provider.setLanguage(language);
                    },
                    showCheckmark: false,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Note 24: This widget displays active filters as interactive chips
  Widget _buildFilterChips() {
    return Consumer<RepositoryProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            children: [
              Icon(
                Icons.filter_alt_outlined,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              // Note 25: Expanded makes this widget take all available horizontal space
              // Wrap automatically flows chips to the next line when needed
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    // Note 26: ActionChip is for triggering actions (vs FilterChip for toggles)
                    ActionChip(
                      avatar: Icon(
                        Icons.schedule,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        provider.getTimeFilterLabel(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: _showTimeFilterDialog,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                    ),
                    ActionChip(
                      avatar: Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      label: Text(
                        provider.getDateFilterLabel(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: _showDateFilterDialog,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Note 27: This method handles all states: loading, error, empty, and success
  Widget _buildRepositoryList() {
    return Consumer<RepositoryProvider>(
      builder: (context, provider, child) {
        // Note 28: Early return pattern for different states
        // This makes the logic easier to read and maintain
        if (provider.isLoading) {
          return _buildLoadingSkeleton();
        }

        if (provider.error != null) {
          // Note 29: User-friendly error display with retry option
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_off_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Oops! Something went wrong',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.error!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => provider.fetchRepositories(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          );
        }

        // Note 30: Empty state with helpful guidance
        if (provider.repositories.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 80,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.3),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No Repositories Found',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try adjusting your filters or selecting a different language',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Note 31: RefreshIndicator adds pull-to-refresh gesture support
        // This is a common mobile UX pattern for updating content
        return RefreshIndicator(
          onRefresh: () => provider.fetchRepositories(),
          child: ListView.builder(
            itemCount: provider.repositories.length,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              final repo = provider.repositories[index];
              return _buildRepositoryCard(repo, index);
            },
          ),
        );
      },
    );
  }

  // Note 32: Loading skeleton provides visual feedback during data fetch
  // It mimics the layout of actual content to reduce perceived loading time
  Widget _buildLoadingSkeleton() {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Note 33: Shimmer effect created with animated opacity
                    _buildShimmer(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShimmer(
                            child: Container(
                              width: 100,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildShimmer(
                            child: Container(
                              width: 150,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildShimmer(
                  child: Container(
                    width: double.infinity,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildShimmer(
                  child: Container(
                    width: double.infinity,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildShimmer(
                      child: Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildShimmer(
                      child: Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Note 34: TweenAnimationBuilder creates animations without a controller
  // Tween defines the start and end values for the animation
  Widget _buildShimmer({required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      // Note 35: onEnd callback triggers when animation completes
      // Calling setState() restarts the animation, creating a pulsing effect
      onEnd: () {
        if (mounted) setState(() {});
      },
      child: child,
    );
  }

  // Note 36: Each repository is displayed as an animated, interactive card
  Widget _buildRepositoryCard(GitHubRepository repo, int index) {
    // Note 37: NumberFormat.compact() formats large numbers with K, M suffixes
    // Example: 1500 becomes "1.5K", 1000000 becomes "1M"
    final numberFormat = NumberFormat.compact();

    // Note 38: Staggered animation - each card animates slightly after the previous
    // Duration increases by 50ms per index for a cascading effect
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 50)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        // Note 39: Transform.translate moves the widget during animation
        // Combined with opacity for a fade-in-up effect
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Note 40: InkWell adds Material Design ripple effect on tap
        // It makes the card visually respond to user interaction
        child: InkWell(
          onTap: () {
            // Note 41: PageRouteBuilder allows custom page transition animations
            // This provides a smoother, more polished navigation experience
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RepositoryDetailScreen(repository: repo),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      // Note 42: Slide transition moves the new page from right to left
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Note 43: Conditional rendering - only show avatar if URL exists
                    if (repo.avatarUrl != null)
                      // Note 44: Hero widget creates shared element transitions
                      // The avatar smoothly animates between list and detail screens
                      Hero(
                        // Note 45: Unique tag identifies corresponding Hero widgets
                        tag: 'avatar_${repo.fullName}',
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          // Note 46: CircleAvatar displays images in a circular frame
                          // NetworkImage loads the image from a URL
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(repo.avatarUrl!),
                            radius: 22,
                          ),
                        ),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            repo.ownerLogin,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            repo.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primaryContainer.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            numberFormat.format(repo.stargazersCount),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (repo.description != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    repo.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildStatChip(
                      Icons.fork_right,
                      numberFormat.format(repo.forksCount),
                    ),
                    _buildStatChip(
                      Icons.error_outline,
                      numberFormat.format(repo.openIssuesCount),
                    ),
                    _buildLanguageChip(repo.language),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageChip(String language) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getLanguageColor(language).withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _getLanguageColor(language).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getLanguageColor(language),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            language,
            style: TextStyle(
              color: _getLanguageColor(language).withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Note 47: Color mapping for different programming languages
  // This provides consistent, recognizable branding for each language
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
        // Note 48: Grey fallback for unknown languages
        return Colors.grey;
    }
  }

  // Note 49: showDialog displays a modal dialog overlaying the current screen
  // The dialog remains visible until explicitly dismissed
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.tune, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            const Text('Filters'),
          ],
        ),
        // Note 50: SingleChildScrollView makes content scrollable on small screens
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Time Range',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _buildTimeFilterRadios(),
              const SizedBox(height: 16),
              Text(
                'Date Type',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _buildDateFilterRadios(),
            ],
          ),
        ),
        actions: [
          TextButton(
            // Note 51: Navigator.pop closes the dialog
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Note 52: RadioListTile combines a radio button with text in a single widget
  // groupValue determines which option is currently selected
  Widget _buildTimeFilterRadios() {
    return Consumer<RepositoryProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            RadioListTile<TimeFilter>(
              title: const Text('Today'),
              value: TimeFilter.today,
              groupValue: provider.timeFilter,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                if (value != null) provider.setTimeFilter(value);
                // Note 53: Automatically close dialog after selection
                Navigator.pop(context);
              },
            ),
            RadioListTile<TimeFilter>(
              title: const Text('This Week'),
              value: TimeFilter.thisWeek,
              groupValue: provider.timeFilter,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                if (value != null) provider.setTimeFilter(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<TimeFilter>(
              title: const Text('This Month'),
              value: TimeFilter.thisMonth,
              groupValue: provider.timeFilter,
              contentPadding: EdgeInsets.zero,
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
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                if (value != null) provider.setDateFilter(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<DateFilter>(
              title: const Text('Updated Date'),
              value: DateFilter.updated,
              groupValue: provider.dateFilter,
              contentPadding: EdgeInsets.zero,
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
        title: Row(
          children: [
            Icon(Icons.schedule, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            const Text('Time Range'),
          ],
        ),
        content: _buildTimeFilterRadios(),
      ),
    );
  }

  void _showDateFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 8),
            const Text('Date Type'),
          ],
        ),
        content: _buildDateFilterRadios(),
      ),
    );
  }
}
