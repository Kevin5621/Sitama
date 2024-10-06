// lib/presentation/pages/logbook_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitama3/domain/entities/logbook.dart';
import 'package:sitama3/presentation/widgets/Models/logbook_dialog.dart';
import 'package:sitama3/presentation/widgets/guidance/logbook_card.dart';
import '../../../config/theme/theme.dart';
import '../../widgets/Models/search_field.dart';

class LogbookPage extends StatefulWidget {
  const LogbookPage({Key? key}) : super(key: key);

  @override
  State<LogbookPage> createState() => _LogbookPageState();
}

class _LogbookPageState extends State<LogbookPage> {
  List<LogbookItem> logbooks = [];
  
  get dateFormat => null;
  
  @override
  void initState() {
    super.initState();
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    // Initialize with dummy data
    logbooks = [
      LogbookItem(
        id: '1',
        weekNumber: 3,
        date: dateFormat.parse("21/01/2024"),
        description: "Membuat desain UI/UX aplikasi MY Pertanian. " + 
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. " +
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. " +
        "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        isExpanded: false,
      ),
      LogbookItem(
        id: '2',
        weekNumber: 2,
        date: dateFormat.parse("10/01/2024"),
        description: "Membuat desain UI/UX aplikasi MY Pertanian. " +
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. " +
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. " +
        "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        isExpanded: false,
      ),
      LogbookItem(
        id: '3',
        weekNumber: 1,
        date: dateFormat.parse("1/01/2024"),
        description: "Membuat desain UI/UX aplikasi MY Pertanian. " +
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. " +
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. " +
        "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        isExpanded: false,
      ),
    ];
  }

  void _toggleExpand(String id) {
    setState(() {
      final index = logbooks.indexWhere((item) => item.id == id);
      if (index != -1) {
        logbooks[index] = logbooks[index].copyWith(
          isExpanded: !logbooks[index].isExpanded,
        );
      }
    });
  }

  void _deleteLogbook(String id) {
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
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.gray),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                logbooks.removeWhere((item) => item.id == id);
              });
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppTheme.danger),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditDialog({LogbookItem? item}) {
    showDialog(
      context: context,
      builder: (context) => LogbookDialog(
        logbook: item,
        onSave: (LogbookItem newItem) {
          setState(() {
            if (item != null) {
              // Edit existing item
              final index = logbooks.indexWhere((l) => l.id == item.id);
              if (index != -1) {
                logbooks[index] = newItem;
              }
            } else {
              // Add new item
              logbooks.add(newItem);
            }
          });
        },
      ),
    );
  }

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
            onPressed: () => _showAddEditDialog(),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final logbook = logbooks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LogbookCard(
                    logbook: logbook,
                    onTap: () => _toggleExpand(logbook.id),
                    onEdit: () => _showAddEditDialog(item: logbook),
                    onDelete: () => _deleteLogbook(logbook.id),
                  ),
                );
              },
              childCount: logbooks.length,
            ),
          ),
        ],
      ),
    );
  }
}
