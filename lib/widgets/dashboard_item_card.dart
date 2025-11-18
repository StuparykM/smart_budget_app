import 'package:flutter/material.dart';
import 'package:smart_budget_app/pages/dashboard.dart';
import'../models/item.dart';
import '../utils/category_enum.dart';

class DashboardItemCard extends StatelessWidget{
  final Item item;

  const DashboardItemCard(this.item, {super.key});


  String getCategoryLabel(Category category) {
    switch (category) {
      case Category.essential:
        return 'Essential';
      case Category.nonEssential:
        return 'Non-Essential';
      case Category.unsorted:
        return 'Unsorted';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.description),
            Text('\$${item.cost.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),

          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: item.category == Category.essential ? Colors.green[100] : Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              getCategoryLabel(item.category),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
      ),
    );
  }
}
