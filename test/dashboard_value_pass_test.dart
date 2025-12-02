import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:smart_budget_app/pages/dashboard.dart';
import 'package:smart_budget_app/services/item_service.dart';
import 'package:provider/provider.dart';

void main() {
  setUp(() {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();

    //Had to use this initalization binding because the test view would fail despite
    //the application itself not overflowing.
    binding.platformDispatcher.views.first.physicalSize =
    const Size(1080, 1920);

    binding.platformDispatcher.views.first.devicePixelRatio = 1.0;
  });


  testWidgets('Dialog values are passed to the dashboard correctly', (tester) async {
    final itemService = ItemService();

    await tester.pumpWidget(
      ChangeNotifierProvider<ItemService>.value(
        value: itemService,
        child: const MaterialApp(home: Dashboard()),
      ),
    );

    itemService.setUser('Mike');
    itemService.setBudget(500);

    await tester.pump();

    expect(find.text("Mike's Budget"), findsOneWidget);
    expect(find.text('\$500.00/'), findsOneWidget);
  });
}