import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/small_button.dart';

class LoginPage extends StatelessWidget {
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
                image: AssetImage('assets/Connected.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Login Form Positioned at Bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
              width: double.infinity,
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
                    "Sign in to Letterboxd",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  CustomTextField(hintText: "Username", controller: _usernameController),
                  CustomTextField(hintText: "Password", isPassword: true, controller: _passwordController),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SmallButton(
                        text: "JOIN",
                        color: Color(0xFF38444E),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                      ),
                      SizedBox(width: 8),
                      SmallButton(
                        text: "RESET PASSWORD",
                        color: Color(0xFF38444E),
                        onPressed: () {
                          // Add reset password functionality
                        },
                      ),
                      SizedBox(width: 8),
                      SmallButton(
                        text: "GO",
                        color: Colors.green,
                        onPressed: () async {
                          final user = await _authService.signIn(
                            _usernameController.text,
                            _passwordController.text,
                          );
                          if (user != null) {
                            // Fetch the username from Firestore
                            final username = await _authService.getUsername(user.uid);
                            if (username != null) {
                              Navigator.pushReplacementNamed(context, '/home');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to fetch user data.')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Login failed. Please try again.')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Artwork from Mitchell vs the Machines",
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