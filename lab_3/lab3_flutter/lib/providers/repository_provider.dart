// Note 1: foundation library provides core Flutter framework features
// ChangeNotifier is used for implementing the observer pattern
import 'package:flutter/foundation.dart';
import '../models/repository.dart';
import '../services/github_service.dart';

// Note 2: Enums define a fixed set of named values
// This prevents typos and provides better autocomplete than strings
enum TimeFilter { today, thisWeek, thisMonth }

enum DateFilter { created, updated }

// Note 3: ChangeNotifier is the foundation of Flutter's state management
// It notifies listeners when data changes, triggering UI rebuilds
class RepositoryProvider extends ChangeNotifier {
  // Note 4: Private fields (prefixed with _) encapsulate internal state
  // This prevents external code from directly modifying the provider's data
  final GitHubService _gitHubService = GitHubService();

  List<GitHubRepository> _repositories = [];
  bool _isLoading = false;
  String? _error;
  String _selectedLanguage = 'Dart';
  TimeFilter _timeFilter = TimeFilter.thisWeek;
  DateFilter _dateFilter = DateFilter.created;

  // Note 5: Getter methods provide read-only access to private fields
  // This enforces unidirectional data flow and prevents external mutations
  List<GitHubRepository> get repositories => _repositories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedLanguage => _selectedLanguage;
  TimeFilter get timeFilter => _timeFilter;
  DateFilter get dateFilter => _dateFilter;

  // Note 6: async methods can use await to handle asynchronous operations
  // Future<void> indicates it completes without returning a value
  Future<void> fetchRepositories() async {
    // Note 7: Setting loading state before the request starts
    _isLoading = true;
    _error = null;

    // Note 8: notifyListeners() alerts all Consumer widgets to rebuild
    // This updates the UI to show loading indicators
    notifyListeners();

    try {
      final since = _getSinceDate();

      // Note 9: Conditional logic determines which API method to call
      // This allows filtering by creation date or last update date
      if (_dateFilter == DateFilter.created) {
        _repositories = await _gitHubService.searchRepositories(
          language: _selectedLanguage,
          since: since,
        );
      } else {
        _repositories = await _gitHubService.getUpdatedRepositories(
          language: _selectedLanguage,
          since: since,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // Note 10: Catch block handles any errors during the API request
      // Converting the error to a string makes it displayable in the UI
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Note 11: Setter methods update state and automatically refresh data
  // This ensures the UI always shows results matching the current filters
  void setLanguage(String language) {
    _selectedLanguage = language;
    fetchRepositories();
  }

  void setTimeFilter(TimeFilter filter) {
    _timeFilter = filter;
    fetchRepositories();
  }

  void setDateFilter(DateFilter filter) {
    _dateFilter = filter;
    fetchRepositories();
  }

  // Note 12: Helper method calculates the date range based on selected filter
  // DateTime.subtract() goes back in time by the specified duration
  DateTime _getSinceDate() {
    final now = DateTime.now();
    switch (_timeFilter) {
      case TimeFilter.today:
        // Note 13: Duration(days: 1) represents 24 hours
        return now.subtract(const Duration(days: 1));
      case TimeFilter.thisWeek:
        return now.subtract(const Duration(days: 7));
      case TimeFilter.thisMonth:
        // Note 14: Approximating a month as 30 days for simplicity
        return now.subtract(const Duration(days: 30));
    }
  }

  // Note 15: Utility methods convert enum values to user-friendly labels
  // These are used for displaying filter selections in the UI
  String getTimeFilterLabel() {
    switch (_timeFilter) {
      case TimeFilter.today:
        return 'Today';
      case TimeFilter.thisWeek:
        return 'This Week';
      case TimeFilter.thisMonth:
        return 'This Month';
    }
  }

  String getDateFilterLabel() {
    switch (_dateFilter) {
      case DateFilter.created:
        return 'Created';
      case DateFilter.updated:
        return 'Updated';
    }
  }
}
