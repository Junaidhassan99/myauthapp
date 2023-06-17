import 'package:firebase_auth/firebase_auth.dart';
import 'package:myauthapp/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String userEmail = "";
  String password = "";
  String retypePassword = "";

  void signupUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: userEmail, password: password);
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
                    Text(
                      'Signup!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        labelText: 'User Email',
                      ),
                      onChanged: (value) => userEmail = value,
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: new InputDecoration(
                        labelText: 'Password',
                      ),
                      onChanged: (value) => password = value,
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                      decoration: new InputDecoration(
                        labelText: 'Retype Password',
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
                          print(password);
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
