import 'package:flutter/material.dart';
import 'package:smart_budget_app/pages/dashboard.dart';
import 'package:smart_budget_app/pages/log_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: FirebaseAuth.instance.currentUser == null ? LogInPage() : Dashboard(),
        initialRoute: '/dashboard',
        routes: {
          '/log_in_page': (context) => LogInPage(),
          '/dashboard': (context) => Dashboard(),
        }

    );
  }

}
