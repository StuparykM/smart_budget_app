import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_budget_app/models/city_enum.dart';
import 'package:smart_budget_app/models/country_enum.dart';
import 'package:smart_budget_app/models/province_enum.dart';
import 'package:crypto/crypto.dart';


class AppUser {
  late String _firstName;
  late String _lastName;
  late String _phoneNumber;
  late String _address;
  late DateTime _accountCreatedDate;
  late String _email;
  late Country _country;
  late CanadianCity _city;
  late CanadianProvince _province;
  late String _password;

  AppUser({
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    required DateTime accountCreatedDate,
    required String email,
    required Country country,
    required CanadianCity city,
    required CanadianProvince province,
    required String password,
  }) {
  setAccountCreatedDate(accountCreatedDate);
  setFirstName(firstName);
  setLastName(lastName);
  setEmail(email);
  setAddress(address);
  setCity(city);
  setProvince(province);
  setCountry(country);
  setPhoneNumber(phoneNumber);
  setPassword(password);
  }

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  DateTime get accountCreatedDate => _accountCreatedDate;
  String get email => _email;
  Country get country => _country;
  CanadianCity get city => _city;
  CanadianProvince get province => _province;
  String get password => _password;

  Map<String, dynamic> toJson() {
    return {
      'firstName': _firstName,
      'lastName': _lastName,
      'phoneNumber': _phoneNumber,
      'address': _address,
      'accountCreatedDate': _accountCreatedDate.toIso8601String(),
      'email': _email,
      'country': _country,
      'city': _city,
      'province': _province,
      'password': _password,
    };
  }


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

    if(!isValid){
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

    if(!isValid){
      throw Exception('Invalid Email');
    }
    _email = email;
  }

  void setCountry(Country country) {
    bool isValid = Country.values.any((e) => e.name == country);

    if(!isValid){
      throw Exception('Invalid country: $country');
    }
    _country = country;
  }

  void setCity(CanadianCity city) {
    bool isValid = CanadianCity.values.any((e) => e.name == city);

    if(!isValid){
      throw Exception('Invalid City: $city');
    }
    _city = city;
  }

  void setProvince(CanadianProvince province) {
    bool isValid = CanadianProvince.values.any((e) => e.name == province);

    if(!isValid){
      throw Exception('Invalid Province: $province');
    }
    _province = province;
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
