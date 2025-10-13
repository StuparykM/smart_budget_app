import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_budget_app/models/city_enum.dart';
import 'package:smart_budget_app/models/province_enum.dart';
import 'package:smart_budget_app/pages/log_in_page.dart';
import 'package:smart_budget_app/models/user.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/country_enum.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile>
    with SingleTickerProviderStateMixin {
  String? _errorMessage;
  bool _isLoading = false;
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _address = TextEditingController();
  late Country selectedCountry;
  late CanadianCity selectedCity;
  late CanadianProvince selectedProvince;
  final _password = TextEditingController();
  final _confirmPass = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
    selectedCountry = Country.canada;
    selectedCity = CanadianCity.edmonton;
    selectedProvince = CanadianProvince.alberta;
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> saveUserToRealtimeDB(AppUser user) async {
    final userMap = user.toJson();
    final dbRef = FirebaseDatabase.instance.ref().child('users');
    await dbRef.push().set(userMap);
  }

  void _handleSubmit() async {
    final firstName = _firstName.text.trim().toLowerCase();
    final lastName = _lastName.text.trim().toLowerCase();
    final email = _email.text.trim().toLowerCase();
    final phoneNumber = _phoneNumber.text.trim().toLowerCase();
    final address = _address.text.trim().toLowerCase();
    final country = selectedCountry;
    final city = selectedCity;
    final province = selectedProvince;
    final password = _password.text.trim().toLowerCase();
    final confirmPass = _confirmPass.text.trim().toLowerCase();

    if ([
      firstName,
      lastName,
      email,
      phoneNumber,
      address,
      password,
      confirmPass,
    ].any((f) => f.isEmpty)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('All fields must be filled')));
      return;
    }

    if (password != confirmPass) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }

    final accountCreatedDate = DateTime.now();
    final hashedPassword = hashPassword(password);

    final user = AppUser(
      accountCreatedDate: accountCreatedDate,
      firstName: firstName,
      lastName: lastName,
      email: email,
      address: address,
      city: city,
      province: province,
      country: country,
      phoneNumber: phoneNumber,
      password: hashedPassword,
    );

    await saveUserToRealtimeDB(user);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('User saved successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2A4861), Color(0xFF1E3245)],
              ).createShader(rect);
            },
            blendMode: BlendMode.overlay,
            child: Image.asset(
              'assets/textures/noise_soft.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 6,
                  color: const Color(0x10B1B1B3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          controller: _firstName,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: false,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _lastName,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: false,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _email,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: false,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _phoneNumber,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: false,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _address,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: false,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<Country>(
                          initialValue: selectedCountry,
                          decoration: InputDecoration(
                            filled: false,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(),
                          ),
                          hint: Text('Select a Country'),
                          items: Country.values.map((country) {
                            return DropdownMenuItem(
                              value: country,
                              child: Text(country.name, style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCountry = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<CanadianProvince>(
                          initialValue: selectedProvince,
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(),
                            ),
                          hint: Text('Select your province'),
                          items: CanadianProvince.values.map((province){
                            return DropdownMenuItem(
                              value: province,
                              child: Text(province.name,
                                  style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              selectedProvince = value!;
                            });
                          }
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<CanadianCity>(
                          initialValue: selectedCity,
                          decoration: InputDecoration(
                            filled: false,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(),
                          ),
                          hint: Text('Select your City'),
                          items: CanadianCity.values.map((city){
                            return DropdownMenuItem(
                              value: city,
                              child: Text(city.name, style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              selectedCity = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _password,
                          obscureText: _obscureText,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: false,
                            fillColor: Colors.transparent,
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _confirmPass,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: false,
                            fillColor: Colors.transparent,
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black54,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
