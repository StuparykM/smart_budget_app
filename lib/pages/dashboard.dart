import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{
  String? _errorMessage;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child:Text(
          'content here',
          style: TextStyle(color: Colors.black, fontSize: 36),
        ),
      ),
      bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, -1),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.logout, color: Colors.black45),
            Icon(Icons.account_circle_outlined, color: Colors.black45),
            Icon(Icons.settings, color: Colors.black45)
          ],
        )
      ),
    );
  }
}