import 'dart:core';
import 'dart:ui';
import '../utils/category_enum.dart';

class Item{
  late final String id;
  late final String title;
  late final double cost;
  late final String description;
  late final String image;
  late Category category;

  Item({
    required this.id,
    required this.title,
    required this.cost,
    required this.description,
    required this.image,
    this.category = Category.unsorted,
  });


  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json['id'],
      title: json['title'],
      cost: (json['cost'] as num).toDouble(),
      description: json['description'],
      image: json['image'],
      category: Category.values.firstWhere(
            (c) => c.name == json['category'],
        orElse: () => Category.unsorted,
      ),
    );
  }
}


