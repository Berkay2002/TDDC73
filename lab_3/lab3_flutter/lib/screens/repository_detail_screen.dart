import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Note 1: Services package provides platform-specific functionality
// Clipboard allows copying text to the system clipboard
import 'package:flutter/services.dart';

// Note 2: url_launcher opens URLs in external browsers or apps
import 'package:url_launcher/url_launcher.dart';
import '../models/repository.dart';

// Note 3: This screen displays detailed information about a single repository
class RepositoryDetailScreen extends StatefulWidget {
  // Note 4: Required parameter ensures a repository is always provided
  final GitHubRepository repository;

  const RepositoryDetailScreen({super.key, required this.repository});

  @override
  State<RepositoryDetailScreen> createState() => _RepositoryDetailScreenState();
}

class _RepositoryDetailScreenState extends State<RepositoryDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // Note 5: Separate animations for different effects (fade and slide)
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Note 6: Tween defines the range of values for the animation
    // CurvedAnimation applies an easing curve for smoother motion
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Note 7: Offset(0, 0.1) starts the content slightly below its final position
    // This creates a subtle upward slide effect
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    // Note 8: Start the animation immediately when the screen appears
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Note 9: NumberFormat.decimalPattern() adds thousand separators
    // Example: 1500000 becomes "1,500,000"
    final numberFormat = NumberFormat.decimalPattern();

    // Note 10: DateFormat creates human-readable date strings
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.repository.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            tooltip: 'Open in Browser',
            onPressed: () => _launchUrl(widget.repository.htmlUrl),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () => _shareRepository(),
          ),
        ],
      ),
      // Note 11: FadeTransition wraps the entire body for smooth entrance
      body: FadeTransition(
        opacity: _fadeAnimation,
        // Note 12: SlideTransition moves content during the animation
        child: SlideTransition(
          position: _slideAnimation,
          // Note 13: SingleChildScrollView enables vertical scrolling
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 16),
                _buildStatsCards(context, numberFormat),
                const SizedBox(height: 16),
                if (widget.repository.description != null)
                  _buildDescriptionCard(context),
                const SizedBox(height: 16),
                _buildDetailsCard(context, dateFormat),
                const SizedBox(height: 16),
                _buildUrlCard(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Note 14: Header creates a visually striking banner with gradient background
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      // Note 15: LinearGradient transitions smoothly between two colors
      // This creates visual depth and draws attention to the header
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
      ),
      child: Column(
        children: [
          if (widget.repository.avatarUrl != null)
            // Note 16: Hero animation links this avatar to the one in the list
            // Both widgets must share the same tag for the animation to work
            Hero(
              tag: 'avatar_${widget.repository.fullName}',
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3,
                  ),
                  // Note 17: BoxShadow adds depth with a soft shadow
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.repository.avatarUrl!),
                  radius: 50,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            widget.repository.ownerLogin,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.repository.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          _buildLanguageChip(context),
        ],
      ),
    );
  }

  Widget _buildLanguageChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _getLanguageColor(widget.repository.language).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getLanguageColor(widget.repository.language),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: _getLanguageColor(widget.repository.language),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            widget.repository.language,
            style: TextStyle(
              color: _getLanguageColor(widget.repository.language),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Note 18: Stats cards display key metrics in a visually balanced layout
  Widget _buildStatsCards(BuildContext context, NumberFormat numberFormat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // Note 19: Row with Expanded children creates equal-width columns
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              context,
              Icons.star,
              'Stars',
              numberFormat.format(widget.repository.stargazersCount),
              Colors.amber.shade700,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              Icons.fork_right,
              'Forks',
              numberFormat.format(widget.repository.forksCount),
              Colors.blue.shade600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              Icons.error_outline,
              'Issues',
              numberFormat.format(widget.repository.openIssuesCount),
              Colors.red.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // Note 20: Reusable widget for displaying a single statistic with icon
  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Note 21: Circular container creates a colored background for the icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // Note 22: withOpacity creates a tinted background
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.repository.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context, DateFormat dateFormat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Repository Details',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDetailRow(
                context,
                Icons.person_outline,
                'Owner',
                widget.repository.ownerLogin,
              ),
              const Divider(height: 24),
              _buildDetailRow(
                context,
                Icons.tag,
                'Full Name',
                widget.repository.fullName,
              ),
              const Divider(height: 24),
              _buildDetailRow(
                context,
                Icons.calendar_today,
                'Created',
                dateFormat.format(widget.repository.createdAt),
              ),
              const Divider(height: 24),
              _buildDetailRow(
                context,
                Icons.update,
                'Last Updated',
                dateFormat.format(widget.repository.updatedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUrlCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.link,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Repository URL',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: SelectableText(
                  widget.repository.htmlUrl,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _copyToClipboard(context),
                      icon: const Icon(Icons.copy, size: 18),
                      label: const Text('Copy URL'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () => _launchUrl(widget.repository.htmlUrl),
                      icon: const Icon(Icons.open_in_browser, size: 18),
                      label: const Text('Open'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Note 23: Clipboard.setData copies text to the system clipboard
  // This allows users to paste the URL elsewhere
  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.repository.htmlUrl));

    // Note 24: SnackBar provides temporary feedback at the bottom of the screen
    // It automatically dismisses after the specified duration
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
            const SizedBox(width: 12),
            const Text('URL copied to clipboard'),
          ],
        ),
        // Note 25: SnackBarBehavior.floating creates a rounded, elevated snackbar
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Note 26: async function with Future return type for asynchronous operations
  Future<void> _launchUrl(String url) async {
    // Note 27: Uri.parse converts string URL to Uri object required by launchUrl
    final uri = Uri.parse(url);

    // Note 28: await keyword pauses execution until the URL launches (or fails)
    // The ! operator asserts the result is not null
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Note 29: mounted check prevents errors if widget was disposed during await
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open $url'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  // Note 30: Simple share implementation using clipboard
  // In a production app, you might use the share plugin for native sharing
  void _shareRepository() {
    Clipboard.setData(
      ClipboardData(
        // Note 31: String interpolation with $ embeds variable values in strings
        text: '${widget.repository.name} - ${widget.repository.htmlUrl}',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
            const SizedBox(width: 12),
            const Text('Repository info copied to clipboard'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
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
}
