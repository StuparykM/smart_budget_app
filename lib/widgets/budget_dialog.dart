import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/item_service.dart';

class BudgetDialog extends StatelessWidget {
  final ItemService service;

  const BudgetDialog({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final numberInput = TextEditingController();

    return AlertDialog(
      title: const Text('Enter Monthly Budget'),
      content: TextField(
        controller: numberInput,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: 'e.g. 1500'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final value = double.tryParse(numberInput.text);
            if (value != null) {
              service.setBudget(value);
            }
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

