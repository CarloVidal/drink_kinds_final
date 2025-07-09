import 'package:flutter/material.dart';

void deleteItem(BuildContext context, VoidCallback onDelete) {
  // Example: Show a dialog before deleting
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancel
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onDelete();
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

void okAction(BuildContext context, VoidCallback onOk) {
  // Example: Show a dialog before confirming OK
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('OK'),
      content: const Text('Operation completed.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onOk();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}