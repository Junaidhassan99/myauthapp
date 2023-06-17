import 'package:cached_network_image/cached_network_image.dart';
import 'package:myauthapp/screens/view_movie_screen.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../utilities/api_utilities.dart';

class SearchScreen extends StatefulWidget {
  final List<Movie> dataList;
  final Map<num, String> genre;

  const SearchScreen({super.key, required this.dataList, required this.genre});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final txt = TextEditingController();

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: txt,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: IconButton(
              onPressed: () {
                setState(() {
                  txt.text = "";
                  _searchQuery = "";
                });
              },
              icon: const Icon(Icons.close, size: 24),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Top Results'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final filteredData = widget.dataList.where((element) {
                  return element.title
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                }).toList();

                return ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredData
                      .length, // replace with actual number of search results
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          height: 250,
                          width: 150,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageUrl: ApiUtilities.getNetworkImageCompletePath(
                            filteredData[index].backdropImagePath,
                          ),
                        ),
                      ),
                      title: Text(filteredData[index].title),
                      subtitle: Text(
                        '${widget.genre[filteredData[index].genres[0]]}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewMovieScreen(
                              data: filteredData[index],
                              genre: widget.genre,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
