import  'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_budget_app/pages/dashboard.dart';


class AuthenticationService {

  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password);

        await Future.delayed(const Duration(seconds: 1));

        Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (BuildContext context) => const Dashboard())
        );
      } on FirebaseAuthException catch(e){
        String message = '';
        if (e.code == 'weak-password'){
          message = 'The password provided is too weak.';
        }else if (e.code == 'email-already-in-use'){
          message = 'An account already exists with that email';
        }
        Fluttertoast.showToast(msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
        );
      }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (BuildContext context) => const Dashboard())
      );
    } on FirebaseAuthException catch(e){
      String message = '';
      if (e.code == 'user-not-found'){
        message = 'No user found with that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided';
      } else {
        message = 'Authentication failed. Please try again.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

}
