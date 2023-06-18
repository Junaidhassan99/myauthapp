import 'package:firebase_auth/firebase_auth.dart';
import 'package:myauthapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:myauthapp/screens/movie_list_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _userEmail = "";
  String _userPassword = "";
  String _retypePassword = "";

  bool _isValidEmail = true;
  bool _isValidPassword = true;
  bool _isValidRetypePassword = true;

  bool _emailValidationChecker() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(_userEmail);
  }

  bool _passwordValidationChecker() {
    return _userPassword.length >= 8;
  }

  bool _retypePasswordValidationChecker() {
    return _userPassword == _retypePassword;
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

    if (_retypePasswordValidationChecker()) {
      setState(() {
        _isValidRetypePassword = true;
      });
    } else {
      setState(() {
        _isValidRetypePassword = false;
      });

      return false;
    }

    return true;
  }

  void _signupUser() async {
    if (!_formValidator()) {
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
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
          'Create An Account',
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
                      'Signup!',
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
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Retype Password',
                        errorText: _isValidRetypePassword
                            ? null
                            : 'Passwords do not match',
                      ),
                      onChanged: (value) => _retypePassword = value,
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
                          print(_retypePassword);

                          _signupUser();
                          // Navigator.of(context).pop();
                        },
                        child: const SizedBox(
                          width: 100,
                          child: Center(
                            child: Text('Singup'),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text('Already have an account? Login'),
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
