import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: onFilterPressed,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}