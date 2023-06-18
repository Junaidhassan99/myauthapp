import 'package:firebase_auth/firebase_auth.dart';
import 'package:myauthapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'movie_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _userEmail = "";
  String _userPassword = "";

  bool _isValidEmail = true;
  bool _isValidPassword = true;

  bool _emailValidationChecker() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(_userEmail);
  }

  bool _passwordValidationChecker() {
    return _userPassword.length >= 8;
  }

  bool _formValidator() {
    if (_emailValidationChecker()) {
      setState(() {
        _isValidEmail = true;
      });
    } else {
      setState(() {
        _isValidEmail = false;
      });

      return false;
    }

    if (_passwordValidationChecker()) {
      setState(() {
        _isValidPassword = true;
      });
    } else {
      setState(() {
        _isValidPassword = false;
      });

      return false;
    }

    return true;
  }

  void _loginUser() async {
    if (!_formValidator()) {
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _userEmail, password: _userPassword);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MovieListScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login An Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Login!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'User Email',
                        errorText:
                            _isValidEmail ? null : 'An invalid email entered',
                      ),
                      onChanged: (value) => _userEmail = value,
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: _isValidPassword
                            ? null
                            : 'An invalid password entered',
                      ),
                      onChanged: (value) => _userPassword = value,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          print(_userEmail);
                          print(_userPassword);

                          _loginUser();
                        },
                        child: const SizedBox(
                          width: 100,
                          child: Center(
                            child: Text('Login'),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text('Don\'t have an account? Signup'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
