import 'package:flutter/material.dart';

class SortDialog extends StatelessWidget {
  final String currentSort;
  final ValueChanged<String> onSortSelected;

  const SortDialog({
    super.key,
    required this.currentSort,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sort By'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text('Rating (High to Low)'),
            value: 'rating',
            groupValue: currentSort,
            onChanged: (value) {
              if (value != null) {
                onSortSelected(value);
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('Name (A to Z)'),
            value: 'name',
            groupValue: currentSort,
            onChanged: (value) {
              if (value != null) {
                onSortSelected(value);
              }
            },
          ),
        ],
      ),
    );
  }
}

