import 'package:firebase_auth/firebase_auth.dart';
import 'package:myauthapp/screens/login_screen.dart';
import 'package:myauthapp/screens/movie_list_screen.dart';
import 'package:myauthapp/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const CowlarApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //only needed for web
  /*await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "", appId: "", messagingSenderId: "", projectId: ""),
  );
  */
  await Firebase.initializeApp();
  runApp(const CowlarApp());
}

class CowlarApp extends StatelessWidget {
  const CowlarApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cowlar App',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      // home: SignupScreen(),
      // home: LoginScreen(),
      // home: MovieListScreen(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MovieListScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
