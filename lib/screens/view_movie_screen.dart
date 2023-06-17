import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/view_movie_bottom.dart';
import '../widgets/view_movie_top.dart';

class ViewMovieScreen extends StatelessWidget {
  final Movie data;
  final Map<num, String> genre;
  const ViewMovieScreen({super.key, required this.data, required this.genre});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme:const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Watch',
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          scrollDirection: isLandscape ? Axis.horizontal : Axis.vertical,
          padding: EdgeInsets.zero,
          physics: isLandscape
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          children: [
            FittedBox(
              fit: isLandscape ? BoxFit.cover : BoxFit.contain,
              child: SizedBox(
                width: isLandscape
                    ? MediaQuery.of(context).size.width * 0.5
                    : MediaQuery.of(context).size.width,
                child: ViewMovieTop(data: data),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: isLandscape
                    ? MediaQuery.of(context).size.width * 0.5
                    : MediaQuery.of(context).size.width,
                child: ViewMovieBottom(data: data, genreMap: genre),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
