import 'dart:core';
import 'package:flutter/material.dart';

class User {
  late String _id;
  late String _firstName;
  late String _lastName;
  late String _phoneNumber;
  late String _address;
  late DateTime _accountCreatedDate;
  late String _email;
  late String _country;
  late String _city;
  late String _province;

  User({
    required String id,
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    required DateTime accountCreatedDate,
    required String email,
    required String country,
    required String city,
    required String province,
  }) {

  }

  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  DateTime get accountCreatedDate => _accountCreatedDate;
  String get email => _email;
  String get country => _country;
  String get city => _city;
  String get province => _province;

  void setFirstName(String firstName) {
    if (firstName.trim().isEmpty) {
      throw Exception('First Name cannot be empty');
    }
    _firstName = firstName;
  }

  void setLastName(String lastName) {
    if (lastName.trim().isEmpty) {
      throw Exception('Last Name cannot be empty');
    }
    _lastName = lastName;
  }

  void setId(String id) {
    if (id.trim().isEmpty) {
      throw Exception('ID cannot be empty');
    }
    _id = id;
  }

  void setAddress(String address) {
    if(address.trim().isEmpty){
      throw Exception('address cannot be empty');
    }
    _address = address;
  }

  void setAccountCreatedDate(DateTime accountCreatedDate) {
    if(accountCreatedDate.isAfter(DateTime.now())){
      throw Exception('Accounts cannot be created in the future');
    }
    _accountCreatedDate = accountCreatedDate;
  }

  void setPhoneNumber(String phoneNumber) {
    if(phoneNumber.trim().isEmpty){
      throw Exception('Phone Number is required');
    }
    final regex = RegExp(r'^(?:\+1[-.\s]?|1[-.\s]?|)?(?:\([2-9]\d{2}\)|[2-9]\d{2})[-.\s]?\d{3}[-.\s]?\d{4}$');
    bool isValid = regex.hasMatch(phoneNumber);

    if(isValid == false){
      throw Exception('Invalid phone number');
    }
    _phoneNumber = phoneNumber;
  }

  void setEmail(String email) {
    if(email.trim().isEmpty){
      throw Exception('Email is required');
    }
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    bool isValid = regex.hasMatch(email);

    if(isValid == false){
      throw Exception('Invalid Email');
    }
    _email = email;
  }

  void setCountry(String country) {
    //Needs Enums that can be validated and then added as a drop down menu
    _country = country;
  }

  void setCity(String value) {
    //Needs Enums that can be validated
    _city = value;
  }

  void setProvince(String value) {
    //Needs Enums that can be validated
    _province = value;
  }
}
