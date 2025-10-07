import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_budget_app/pages/log_in_page.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile>
with SingleTickerProviderStateMixin{
  String? _errorMessage;
  //bool _isLoading = false;
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _password = TextEditingController();
  final _confirmPass = TextEditingController();
  bool _obscureText = true;

  @override
  void initState(){
    super.initState();
    _obscureText = true;
  }
  void _handleSubmit() async {}

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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            hintText: 'Phone Number (optional)',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: false,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(),
                          ),
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
                                  icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                      color: Colors.white),
                                  onPressed: (){
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  }
                              )
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
                                icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                    color: Colors.white),
                                onPressed: (){
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                }
                            ),
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
