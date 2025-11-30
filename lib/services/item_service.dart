import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/item.dart';
import '../utils/category_enum.dart';

class ItemService extends ChangeNotifier{
  late List<Item> _items = [];
  double? _budget;
  String? _username;


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

  void setBudget(double value){
    _budget = value;
    notifyListeners();
  }

  void setUser(String name) {
    _username = name;
    notifyListeners();
  }

  void reset() {
    _budget = null;
    _username = null;
    notifyListeners();
  }



  double? get budget => _budget;
  String? get username => _username;

  double get categorizedCost =>
      essential.fold(0.0, (sum, item) => sum + item.cost) +
          nonEssential.fold(0.0, (sum, item) => sum + item.cost);



  double get remainingBudget => _budget != null ? _budget! - categorizedCost : 0;


}