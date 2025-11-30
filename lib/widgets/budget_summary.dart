import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/item_service.dart';

class BudgetSummary extends StatelessWidget {
  final double? budget;
  final double spent;

  const BudgetSummary({
    super.key,
    required this.budget,
    required this.spent,
  });

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ItemService>(context);
    final overBudget = budget != null && spent > budget!;
    final remaining = budget != null ? budget! - spent : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (service.username != null && service.username!.isNotEmpty)
          Text(
            "${service.username}'s Budget",
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                budget == null ? ' --' : '\$${budget!.toStringAsFixed(2)}/',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Spent: \$${spent.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: overBudget ? Colors.red : Colors.lightGreen,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Remaining: \$${remaining.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: overBudget ? Colors.red : Colors.lightGreen,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

