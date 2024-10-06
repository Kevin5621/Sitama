import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sitama3/domain/entities/logbook.dart';
import 'package:sitama3/domain/repository/logbook_repository_impl.dart';
import 'package:sitama3/presentation/bloc/event/logbook_bloc.dart';
import 'package:sitama3/presentation/bloc/event/logbook_state.dart';
import 'package:sitama3/presentation/bloc/event/loogbook_event.dart';
import 'package:sitama3/presentation/widgets/Models/logbook_dialog.dart';
import 'package:sitama3/presentation/widgets/guidance/logbook_card.dart';
import 'package:sitama3/domain/repository/logbook_repository.dart';
import '../../../config/theme/theme.dart';
import '../../widgets/Models/search_field.dart';

class LogbookPage extends StatefulWidget {
  const LogbookPage({Key? key}) : super(key: key);

  @override
  State<LogbookPage> createState() => _LogbookPageState();
}

class _LogbookPageState extends State<LogbookPage> {
  final dateFormat = DateFormat('dd/MM/yyyy');
  late final LogbookRepository repository;

  @override
  void initState() {
    super.initState();
    repository = LogbookRepositoryImpl(); 
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogbookBloc(repository)..add(LoadLogbooks()),
      child: BlocBuilder<LogbookBloc, LogbookState>(
        builder: (context, state) {
          return Scaffold(
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
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, LogbookState state) {
    if (state is LogbookLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is LogbookError) {
      return Center(child: Text(state.message));
    } else if (state is LogbookLoaded) {
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
                        // Implement search functionality
                      },
                      onFilterPressed: () {
                        // Implement filter functionality
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.filter_list_outlined, color: AppTheme.gray),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final logbook = state.logbooks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LogbookCard(
                    logbook: logbook,
                    onTap: () => context.read<LogbookBloc>().add(
                          ToggleLogbookExpansion(logbook.id),
                        ),
                    onEdit: () => _showAddEditDialog(context, item: logbook),
                    onDelete: () => _showDeleteDialog(context, logbook.id),
                  ),
                );
              },
              childCount: state.logbooks.length,
            ),
          ),
        ],
      );
    }
    return const Center(child: Text('Initial State'));
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppTheme.gray),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<LogbookBloc>().add(DeleteLogbookEvent(id));
              Navigator.pop(context);
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
      builder: (context) => LogbookDialog(
        logbook: item,
        onSave: (LogbookItem newItem) {
          if (item != null) {
            context.read<LogbookBloc>().add(UpdateLogbookEvent(newItem));
          } else {
            context.read<LogbookBloc>().add(AddLogbookEvent(newItem));
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}