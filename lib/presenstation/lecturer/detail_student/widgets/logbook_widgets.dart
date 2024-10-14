import 'package:flutter/material.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';

class LogBookWidget extends StatelessWidget {
  const LogBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          color: AppColors.white,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text('Log Book Entry ${index + 1}'),
              subtitle: Text('Date: ${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}