import 'package:flutter/foundation.dart';
import '../models/repository.dart';
import '../services/github_service.dart';

enum TimeFilter { today, thisWeek, thisMonth }

enum DateFilter { created, updated }

class RepositoryProvider extends ChangeNotifier {
  final GitHubService _gitHubService = GitHubService();

  List<GitHubRepository> _repositories = [];
  bool _isLoading = false;
  String? _error;
  String _selectedLanguage = 'Dart';
  TimeFilter _timeFilter = TimeFilter.thisWeek;
  DateFilter _dateFilter = DateFilter.created;

  List<GitHubRepository> get repositories => _repositories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedLanguage => _selectedLanguage;
  TimeFilter get timeFilter => _timeFilter;
  DateFilter get dateFilter => _dateFilter;

  Future<void> fetchRepositories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final since = _getSinceDate();

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
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

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

  DateTime _getSinceDate() {
    final now = DateTime.now();
    switch (_timeFilter) {
      case TimeFilter.today:
        return now.subtract(const Duration(days: 1));
      case TimeFilter.thisWeek:
        return now.subtract(const Duration(days: 7));
      case TimeFilter.thisMonth:
        return now.subtract(const Duration(days: 30));
    }
  }

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
