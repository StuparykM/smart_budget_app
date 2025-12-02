
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_budget_app/services/item_service.dart';
import 'package:smart_budget_app/models/item.dart';
import 'package:smart_budget_app/utils/category_enum.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ItemService category sorting with mock JSON', () {
    late ItemService service;
    late Item testItem;

    setUp(() async {
      service = ItemService();
      await service.loadFromJson();
    });

    test('updates item to essential', () {
      testItem = service.unsorted.first;

      service.updateCategory(testItem.id, Category.essential);

      expect(service.essential.any((i) => i.id == testItem.id), true);
      expect(service.nonEssential.any((i) => i.id == testItem.id), false);
      expect(service.unsorted.any((i) => i.id == testItem.id), false);
    });

    test('updates item to nonEssential', () {
      testItem = service.unsorted.first;

      service.updateCategory(testItem.id, Category.nonEssential);

      expect(service.nonEssential.any((i) => i.id == testItem.id), true);
      expect(service.essential.any((i) => i.id == testItem.id), false);
      expect(service.unsorted.any((i) => i.id == testItem.id), false);
    });
  });
}