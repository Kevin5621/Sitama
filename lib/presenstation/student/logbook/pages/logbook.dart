import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistem_magang/common/widgets/search_field.dart';
import 'package:sistem_magang/common/widgets/student_log_book_card.dart';

class LogBookPage extends StatelessWidget {
  const LogBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
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
                      onChanged: (value) {},
                      onFilterPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.filter_list_outlined),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          _listLogBook(),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
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
          onPressed: () {},
          icon: const Icon(Icons.add),
        )
      ],
      backgroundColor: Colors.transparent,
    );
  }

  SliverList _listLogBook() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => LogBookCard(
          item: LogBookItem(
            title: 'Minggu ${index + 1}',
            date: DateTime(2024, 1, 21 + index * 7),
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
          ),
          onEdit: (updatedItem) {
            // Implement edit functionality
          },
        ),
        childCount: 2,
      ),
    );
  }
}
