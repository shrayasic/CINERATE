import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/small_button.dart';
import '../widgets/toggle_switch.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onward.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Signup Form Positioned at Bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
              decoration: BoxDecoration(
                color: Color(0xFF1B2228),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Join Letterboxd",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  CustomTextField(hintText: "Email Address", controller: _emailController),
                  CustomTextField(hintText: "Username", controller: _usernameController),
                  CustomTextField(hintText: "Password", isPassword: true, controller: _passwordController),
                  ToggleSwitch(text: "I'm at least 16 years old and accept the Terms of Use"),
                  ToggleSwitch(
                      text: "I accept the Privacy Policy "
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      SmallButton(
                        text: "SIGN IN",
                        color: Color(0xFF38444E),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                      SizedBox(width: 8),
                      SmallButton(
                        text: "GO",
                        color: Color(0xFF38444E),
                        onPressed: () async {
                          final user = await _authService.signUp(
                            _emailController.text,
                            _usernameController.text,
                            _passwordController.text,
                          );
                          if (user != null) {
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Sign-up failed. Please try again.')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Artwork from Onward (2020)",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}