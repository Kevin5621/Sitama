import 'package:flutter/material.dart';
import 'package:sitama3/core/config/theme/app_color.dart';

class StudentCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String nim;
  final String kelas;

  const StudentCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.nim,
    required this.kelas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      nim,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF71727A),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      kelas,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF71727A),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
