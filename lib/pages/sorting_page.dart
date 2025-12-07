import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../services/item_service.dart';
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
  late MatchEngine _matchEngine;
  bool _stackFinished = false;

  @override
  void initState() {
    super.initState();
    _buildItems();
  }

  void _buildItems() {
    final service = context.read<ItemService>();

    final swipeItems = service.unsorted.map((item) {
      return SwipeItem(
        content: item,
        likeAction: () {
          service.updateCategory(item.id, Category.essential);
        },
        nopeAction: () {
          service.updateCategory(item.id, Category.nonEssential);
        },
      );
    }).toList();

    _matchEngine = MatchEngine(swipeItems: swipeItems);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF344969),
      body: Stack(
        children: [
          Center(
            child: _stackFinished
                ? ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: const Text('Back to Dashboard'),
            )
                : SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.85,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.6,
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (context, index) {
                  final item =
                  _matchEngine.currentItem?.content as Item;
                  return SortingItemCard(item: item);
                },
                onStackFinished: () {
                  setState(() {
                    _stackFinished = true;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: const Text(
              "Swipe left for Non-Essential and Swipe right for Essential",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
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
            IconButton(
              icon: const Icon(Icons.account_circle_outlined,
                  color: Colors.black45),
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
