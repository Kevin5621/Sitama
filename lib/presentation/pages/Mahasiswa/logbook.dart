// lib/presentation/pages/logbook_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/theme/theme.dart';
import '../../widgets/Models/search_field.dart';

class LogbookPage extends StatelessWidget {
  const LogbookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
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
            icon: Icon(Icons.add, color: AppTheme.primary),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomScrollView(
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
                  Icon(Icons.filter_list_outlined, color: AppTheme.gray),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildLogbookCard(
                    weekNumber: 3,
                    date: "21/01/2024",
                    description: "Membuat desain UI/UX aplikasi MY Pertanian",
                    theme: theme,
                  ),
                  _buildLogbookCard(
                    weekNumber: 2,
                    date: "21/01/2024",
                    description: "Membuat desain UI/UX aplikasi MY Pertanian",
                    theme: theme,
                  ),
                  _buildLogbookCard(
                    weekNumber: 1,
                    date: "21/01/2024",
                    description: "Membuat desain UI/UX aplikasi MY Pertanian",
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogbookCard({
    required int weekNumber,
    required String date,
    required String description,
    required ThemeData theme,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Minggu $weekNumber',
              style: theme.textTheme.headlineSmall,
            ),
            subtitle: Text(
              date,
              style: theme.textTheme.bodyMedium,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: AppTheme.primary),
                  onPressed: () {
                    // Implement edit functionality
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: AppTheme.danger),
                  onPressed: () {
                    // Implement delete functionality
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}