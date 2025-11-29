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
    final overBudget = budget != null && spent > budget!;
    final remaining = budget != null ? budget! - spent : 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            budget == null
                ? 'Budget: --'
                : 'Budget: \$${budget!.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spent: \$${spent.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: overBudget ? Colors.red : Colors.lightGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Remaining: \$${remaining.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: overBudget ? Colors.red : Colors.lightGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }


}