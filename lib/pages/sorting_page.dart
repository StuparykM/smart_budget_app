import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_budget_app/pages/log_in_page.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../utils/category_enum.dart';
import '../widgets/sorting_item_card.dart';
import '../models/item.dart';

class SortingPage extends StatefulWidget {
  const SortingPage({super.key});

  @override
  State<SortingPage> createState() => _SortingPageState();
}

class _SortingPageState extends State<SortingPage> {
  String? _errorMessage;
  MatchEngine _matchEngine = MatchEngine(swipeItems: []);
  final List<SwipeItem> _swipeItems = [];
  List<Item> items = [];
  bool _stackFinished = false;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
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

  Future<void> _loadItems() async {
    final jsonString = await rootBundle.loadString('assets/data/mock_data.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    items = jsonList.map((e) => Item.fromJson(e)).toList();

    _swipeItems.clear();
    for (var item in items.where((i) => i.category == Category.unsorted)) {
      _swipeItems.add(
        SwipeItem(
          content: item,
          likeAction: () {
            setState(() => item.category = Category.essential);
          },
          nopeAction: () {
            setState(() => item.category = Category.nonEssential);
          },
        ),
      );
    }
    setState(() {
      _matchEngine = MatchEngine(swipeItems: _swipeItems);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF344969),
      body: Center(
        child: _stackFinished ?
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
            },
            child: const Text('Back to Dashboard'),
            )
        : SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.6,
          child: SwipeCards(
            matchEngine: _matchEngine,
            itemBuilder: (context, index) {
              final item = _swipeItems[index].content as Item;
              return SortingItemCard(item: item);
            },
            onStackFinished: () {
                _stackFinished = true;
            },
          ),
        ),
      ),
      bottomNavigationBar:
      Container(
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
            IconButton(
              icon: const Icon(Icons.account_circle_outlined, color: Colors.black45),
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            const Icon(Icons.settings, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}
