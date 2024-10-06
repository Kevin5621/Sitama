import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitama3/config/theme/theme.dart';
import 'package:sitama3/presentation/bloc/event/logbook_bloc.dart';
import '../../bloc/event/logbook_state.dart';
import '../../bloc/event/loogbook_event.dart';
import '../../../domain/entities/logbook.dart';
import '../../widgets/Models/search_field.dart';
import '../../widgets/guidance/logbook_card.dart';

class LogbookPage extends StatelessWidget {
  const LogbookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocProvider(
      create: (context) => LogbookBloc(
        context.read<LogbookRepository>(),
      )..add(LoadLogbooks()),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          toolbarHeight: 80.0,
          title: Text(
            'Log Book',
            style: theme.textTheme.headlineLarge,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // Show TambahBimbinganDialog adapted for logbook
              },
              icon: const Icon(Icons.add, color: AppTheme.primary),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocBuilder<LogbookBloc, LogbookState>(
          builder: (context, state) {
            if (state is LogbookLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppTheme.primary),
              );
            }
            
            if (state is LogbookError) {
              return Center(
                child: Text(
                  state.message,
                  style: theme.textTheme.bodyLarge?.copyWith(color: AppTheme.danger),
                ),
              );
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
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Delete Logbook',
                                  style: theme.textTheme.headlineMedium,
                                ),
                                content: Text(
                                  'Are you sure you want to delete this logbook entry?',
                                  style: theme.textTheme.bodyLarge,
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
                                      context.read<LogbookBloc>().add(
                                        DeleteLogbookEvent(logbook.id),
                                      );
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