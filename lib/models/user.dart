import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_budget_app/enums/city_enum.dart';
import 'package:smart_budget_app/enums/country_enum.dart';
import 'package:crypto/crypto.dart';

import '../enums/province_enum.dart';


class AppUser {
  late DateTime _accountCreatedDate;
  late String _email;
  late String _password;

  AppUser({
    required DateTime accountCreatedDate,
    required String email,
    required String password,
  }) {
  setAccountCreatedDate(accountCreatedDate);
  setEmail(email);
  setPassword(password);
  }

  DateTime get accountCreatedDate => _accountCreatedDate;
  String get email => _email;
  String get password => _password;

  Map<String, dynamic> toJson() {
    return {
      'accountCreatedDate': _accountCreatedDate.toIso8601String(),
      'email': _email,
      'password': _password,
    };
  }


  void setAccountCreatedDate(DateTime accountCreatedDate) {
    if(accountCreatedDate.isAfter(DateTime.now())){
      throw Exception('Accounts cannot be created in the future');
    }
    _accountCreatedDate = accountCreatedDate;
  }


  void setEmail(String email) {
    if(email.trim().isEmpty){
      throw Exception('Email is required');
    }
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    bool isValid = regex.hasMatch(email);

    if(!isValid){
      throw Exception('Invalid Email');
    }
    _email = email;
  }

  void setPassword(String password){
    final regex = RegExp(
        r'^(?=(?:.*[A-Za-z]){8,})(?=(?:.*\d){4,})(?=(?:.*[^A-Za-z0-9]){1,}).+$'
    );

    bool isValid =  regex.hasMatch(password);

    if(!isValid){
      throw Exception('Invalid password. Password must contain at least 8 letters, 4 numbers and a unique character');
    }

    _password = password;
  }
}
