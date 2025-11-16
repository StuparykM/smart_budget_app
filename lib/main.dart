import 'package:flutter/material.dart';
import 'package:smart_budget_app/pages/create_profile.dart';
import 'package:smart_budget_app/pages/dashboard.dart';
import 'package:smart_budget_app/pages/log_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_budget_app/pages/sorting_page.dart';
import 'package:smart_budget_app/pages/user_profile.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      debugPrint('Firebase already initialized.');
    } else {
      rethrow;
    }
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser == null ? LogInPage() : Dashboard(),
        routes: {
          '/log_in_page': (context) => LogInPage(),
          '/dashboard': (context) => Dashboard(),
          '/create_profile': (context) => CreateProfile(),
          '/user_profile': (context) => UserProfile(),
          '/sorting_page': (context) => Transaction()
        }

    );
  }

}
