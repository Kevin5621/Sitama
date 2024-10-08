import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitama3/UI/bloc/event/logbook_bloc.dart';
import 'package:sitama3/UI/bloc/event/logbook_state.dart';
import 'package:sitama3/UI/bloc/event/loogbook_event.dart';
import 'package:sitama3/UI/widgets/Models/logbook_dialog.dart';
import 'package:sitama3/UI/widgets/guidance/logbook_card.dart';
import 'package:sitama3/domain/entities/logbook.dart';
import 'package:sitama3/domain/repository/logbook_repository_impl.dart';
import '../../../config/theme/theme.dart';
import '../../widgets/Models/search_field.dart';

enum SortOrder { ascending, descending }

class LogbookPage extends StatefulWidget {
  const LogbookPage({Key? key}) : super(key: key);

  @override
  State<LogbookPage> createState() => _LogbookPageState();
}

class _LogbookPageState extends State<LogbookPage> {
  late final LogbookBloc _logbookBloc;
  String _searchQuery = '';
  SortOrder _sortOrder = SortOrder.descending;

  @override
  void initState() {
    super.initState();
    final repository = LogbookRepositoryImpl();
    _logbookBloc = LogbookBloc(repository);
    _logbookBloc.add(LoadLogbooks());
  }

  @override
  void dispose() {
    _logbookBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _logbookBloc,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          toolbarHeight: 80.0,
          title: Text(
            'Log Book',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => _showAddEditDialog(context),
              icon: const Icon(Icons.add, color: AppTheme.primary),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocConsumer<LogbookBloc, LogbookState>(
          listener: (context, state) {
            if (state is LogbookError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LogbookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LogbookLoaded) {
              return _buildLogbookList(context, state.logbooks);
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }

  Widget _buildLogbookList(BuildContext context, List<LogbookItem> logbooks) {
    final filteredLogbooks = _filterAndSortLogbooks(logbooks);

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    onFilterPressed: _showSortDialog,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: _showSortDialog,
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final logbook = filteredLogbooks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: LogbookCard(
                  logbook: logbook,
                  onTap: () => _logbookBloc.add(ToggleLogbookExpansion(logbook.id)),
                  onEdit: () => _showAddEditDialog(context, item: logbook),
                  onDelete: () => _showDeleteDialog(context, logbook.id),
                ),
              );
            },
            childCount: filteredLogbooks.length,
          ),
        ),
      ],
    );
  }

  List<LogbookItem> _filterAndSortLogbooks(List<LogbookItem> logbooks) {
    final filtered = logbooks.where((logbook) {
      final titleMatch = logbook.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final dateMatch = logbook.date.toString().contains(_searchQuery);
      return titleMatch || dateMatch;
    }).toList();

    filtered.sort((a, b) {
      final comparison = a.date.compareTo(b.date);
      return _sortOrder == SortOrder.ascending ? comparison : -comparison;
    });

    return filtered;
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Ascending'),
                leading: Radio<SortOrder>(
                  value: SortOrder.ascending,
                  groupValue: _sortOrder,
                  onChanged: (SortOrder? value) {
                    if (value != null) {
                      setState(() {
                        _sortOrder = value;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              ListTile(
                title: const Text('Descending'),
                leading: Radio<SortOrder>(
                  value: SortOrder.descending,
                  groupValue: _sortOrder,
                  onChanged: (SortOrder? value) {
                    if (value != null) {
                      setState(() {
                        _sortOrder = value;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Delete Logbook',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: Text(
          'Are you sure you want to delete this logbook entry?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppTheme.gray),
            ),
          ),
          TextButton(
            onPressed: () {
              _logbookBloc.add(DeleteLogbookEvent(id));
              Navigator.pop(dialogContext);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppTheme.danger),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditDialog(BuildContext context, {LogbookItem? item}) {
    showDialog(
      context: context,
      builder: (dialogContext) => LogbookDialog(
        logbook: item,
        onSave: (LogbookItem newItem) {
          if (item != null) {
            _logbookBloc.add(UpdateLogbookEvent(newItem));
          } else {
            _logbookBloc.add(AddLogbookEvent(newItem));
          }
          Navigator.pop(dialogContext);
        },
      ),
    );
  }
}