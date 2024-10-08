import 'package:flutter/material.dart';
import '../../../config/theme/theme.dart';

class SearchField extends StatelessWidget {
  final Function(String) onChanged;
  final VoidCallback onFilterPressed;

  const SearchField({
    Key? key,
    required this.onChanged,
    required this.onFilterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: AppTheme.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          isDense: true,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
