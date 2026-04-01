

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Cleaner/Cleaners Dashboard/CleanersDashboard.dart';
import 'Services/Color.dart';
import 'Services/resuableTextField.dart';
import 'Services/user_auth_service.dart';
import 'SignUpScreeen.dart';

class CleanersLoginPage extends StatefulWidget {
  @override
  State<CleanersLoginPage> createState() => _CleanersLoginPageState();
}

class _CleanersLoginPageState extends State<CleanersLoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_emailTextController.text.trim().isEmpty || 
        _passwordTextController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both email and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await UserAuthService.login(
        _emailTextController.text.trim(),
        _passwordTextController.text,
        'cleaner',
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CleanersDashboard()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cleaners Login Page"),
        backgroundColor: Color(0xFFCB2B93),
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width, // Make it take the full screen height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546c4"),
              hexStringToColor("5E61F4")
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery
                .of(context)
                .size
                .height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/housekeeping.png"),
                SizedBox(
                  height: 30,
                ),
                resuableTextField("Enter Username", Icons.person_outline, false,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                resuableTextField("Enter Password", Icons.lock_outline, false,
                    _passwordTextController),
                SizedBox(
                  height: 30,
                ),
                signInSignUPButton(context, true, _login, isLoading: _isLoading),
                signUpOption(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption(BuildContext context) {
    // Pass context as a parameter
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
            "Don't have an account?", style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context, // Use the passed context
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
