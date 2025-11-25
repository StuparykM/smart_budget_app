import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/item.dart';
import '../utils/category_enum.dart';

class ItemService extends ChangeNotifier{
  late List<Item> _items = [];

  List<Item> get essential =>
      _items.where((item) => item.category == Category.essential).toList();

  List<Item> get nonEssential =>
      _items.where((item) => item.category == Category.nonEssential).toList();

  List<Item> get unsorted =>
      _items.where((item) => item.category == Category.unsorted).toList();


  Future<void> loadFromJson() async{
    final jsonString = await rootBundle.loadString('assets/data/mock_data.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    _items = jsonList.map((item) => Item.fromJson(item)).toList();
    notifyListeners();
  }

  void updateCategory(String id, Category newCategory){
    final item = _items.firstWhere((i) => i.id == id);
    item.category = newCategory;
    notifyListeners();
  }


}