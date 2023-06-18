import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:myauthapp/screens/login_screen.dart';
import 'package:myauthapp/screens/search_screen.dart';
import 'package:myauthapp/screens/view_movie_screen.dart';
import 'package:myauthapp/utilities/general_utilities.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/api_utilities.dart';
import '../widgets/movie_list_tile.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  void _signoutUser() {
    try {
      FirebaseAuth.instance.signOut();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> _getMoviesData() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();

    var moviesFetchJson;
    try {
      moviesFetchJson = await ApiUtilities.getUpcommingMoviesData();
      String moviesFetchJsonEncoded = jsonEncode(moviesFetchJson);
      shared_User.setString('movies', moviesFetchJsonEncoded);
    } catch (e) {
      moviesFetchJson = jsonDecode(shared_User.getString('movies')!);
    }

    var generFetchJson;
    try {
      generFetchJson = await ApiUtilities.getMovieGeresMap();
      String generFetchJsonEncoded = jsonEncode(generFetchJson);
      shared_User.setString('gener', generFetchJsonEncoded);
    } catch (e) {
      generFetchJson = jsonDecode(shared_User.getString('gener')!);
    }

    final moviesFetchObj =
        GeneralUtitities.convertUpcommingMoviesDataToMovieList(
      moviesFetchJson,
    );

    final generFetchObj = GeneralUtitities.convertMovieGeresMapToSimpleMap(
      generFetchJson,
    );

    return [moviesFetchObj, generFetchObj];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getMoviesData(),
        builder: (ctx, snapshot) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white, //change your color here
              ),
              title: const Text(
                'Watch',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) =>
                            SearchScreen(
                          dataList: snapshot.data![0],
                          genre: snapshot.data![1],
                        ),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _signoutUser();
                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                ),
              ],
            ),
            body: Builder(
              builder: (ctx) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return GridView.count(
                    // primary: false, // uncomment if some problem with even/odd tiles
                    padding: const EdgeInsets.all(5),
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    crossAxisCount: 2,
                    children: [
                      ...snapshot.data![0].map((data) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewMovieScreen(
                                  data: data,
                                  genre: snapshot.data![1],
                                ),
                              ),
                            );
                          },
                          child: MovieListTile(
                            data: data,
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('We were unable to load the data!'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        });
  }
}
