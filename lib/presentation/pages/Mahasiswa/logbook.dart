import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sitama3/presentation/bloc/event/logbook_bloc.dart';
import '../../bloc/event/logbook_state.dart';
import '../../bloc/event/loogbook_event.dart';
import '../../../domain/entities/logbook.dart';
import '../../widgets/Models/search_field.dart';

// lib/presentation/widgets/logbook/logbook_card.dart
class LogbookCard extends StatelessWidget {
  final Logbook logbook;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const LogbookCard({
    Key? key,
    required this.logbook,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ListTile(
              title: Text('Minggu ${logbook.weekNumber}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy').format(logbook.date),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
            if (logbook.isExpanded)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(logbook.description),
              ),
          ],
        ),
      ),
    );
  }
}

// lib/presentation/pages/logbook_page.dart
class LogbookPage extends StatelessWidget {
  const LogbookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogbookBloc(
        context.read<LogbookRepository>(),
      )..add(LoadLogbooks()),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          title: const Text(
            'Log Book',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // Show TambahBimbinganDialog adapted for logbook
              },
              icon: const Icon(Icons.add),
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<LogbookBloc, LogbookState>(
          builder: (context, state) {
            if (state is LogbookLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (state is LogbookError) {
              return Center(child: Text(state.message));
            }

            if (state is LogbookLoaded) {
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
                          const Icon(Icons.filter_list_outlined),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final logbook = state.logbooks[index];
                        return LogbookCard(
                          logbook: logbook,
                          onTap: () {
                            context.read<LogbookBloc>().add(
                              ToggleLogbookExpansion(logbook.id),
                            );
                          },
                          onEdit: () {
                            // Show EditBimbinganDialog adapted for logbook
                          },
                          onDelete: () {
                            // Show delete confirmation dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Logbook'),
                                content: const Text('Are you sure you want to delete this logbook entry?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<LogbookBloc>().add(
                                        DeleteLogbookEvent(logbook.id),
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      childCount: state.logbooks.length,
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}