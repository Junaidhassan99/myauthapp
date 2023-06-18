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
  String userEmail = "";
  String userPassword = "";
  String retypePassword = "";

  bool isValidEmail = true;
  bool isValidPassword = true;
  bool isValidRetypePassword = true;

  bool emailValidationChecker() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(userEmail);
  }

  bool passwordValidationChecker() {
    return userPassword.length >= 8;
  }

  bool retypePasswordValidationChecker() {
    return userPassword == retypePassword;
  }

  bool formValidator() {
    if (emailValidationChecker()) {
      setState(() {
        isValidEmail = true;
      });
    } else {
      setState(() {
        isValidEmail = false;
      });

      return false;
    }

    if (passwordValidationChecker()) {
      setState(() {
        isValidPassword = true;
      });
    } else {
      setState(() {
        isValidPassword = false;
      });

      return false;
    }

    if (retypePasswordValidationChecker()) {
      setState(() {
        isValidRetypePassword = true;
      });
    } else {
      setState(() {
        isValidRetypePassword = false;
      });

      return false;
    }

    return true;
  }

  void signupUser() async {
    if (!formValidator()) {
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);

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
                            isValidEmail ? null : 'An invalid email entered',
                      ),
                      onChanged: (value) => userEmail = value,
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: isValidPassword
                            ? null
                            : 'An invalid password entered',
                      ),
                      onChanged: (value) => userPassword = value,
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Retype Password',
                        errorText: isValidRetypePassword
                            ? null
                            : 'Passwords do not match',
                      ),
                      onChanged: (value) => retypePassword = value,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          print(userEmail);
                          print(userPassword);
                          print(retypePassword);

                          signupUser();
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 100,
                          child: const Center(
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
                            builder: (context) => LoginScreen(),
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
