import 'package:flutter/material.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';

class SearchField extends StatelessWidget {
  final Function(String) onChanged;
  final VoidCallback onFilterPressed;

  const SearchField({
    super.key,
    required this.onChanged,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
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
