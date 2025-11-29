import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_budget_app/pages/log_in_page.dart';
import '../services/item_service.dart';
import '../widgets/budget_dialog.dart';
import '../widgets/budget_summary.dart';
import '../widgets/dashboard_item_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  String? _errorMessage;
  late final essential = context.watch<ItemService>().essential;
  late final nonEssential = context.watch<ItemService>().nonEssential;
  late final unsorted = context.watch<ItemService>().unsorted;
  bool _dialogShown = false;

  void _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/log_in_page');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_dialogShown) {
        _dialogShown = true;
        final service = Provider.of<ItemService>(context, listen: false);
        showDialog(
          context: context,
          builder: (ctx) => BudgetDialog(service: service),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF344969),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(-2, 1),
                  blurRadius: 8,
                  blurStyle: BlurStyle.normal,
                  spreadRadius: 1,
                ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Consumer<ItemService>(
                    builder: (context, service, _) {
                      return BudgetSummary(
                        budget: service.budget,
                        spent: service.categorizedCost,
                      );
                    },
                  ),
                )
              )
            ),

            Container(
              height: 480,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(-2, 1),
                    blurRadius: 8,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Consumer<ItemService>(
                builder: (context, service, _) {
                  final allItems = [
                    ...service.essential,
                    ...service.nonEssential,
                  ];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: allItems.length,
                    itemBuilder: (context, index) {
                      final item = allItems[index];
                      return DashboardItemCard(item);
                    },
                  );
                },
              ),
            ),
            const Spacer(),
            Consumer<ItemService>(
              builder: (context, service, _) {
                if (service.unsorted.isEmpty) return const SizedBox.shrink();
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sorting_page');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade500,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'You have unsorted transactions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(0, -1),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black45),
              onPressed: _confirmLogout,
            ),
            const Icon(Icons.settings, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}
