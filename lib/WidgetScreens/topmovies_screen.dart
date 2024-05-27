import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app/Screens/moviedetail_screen.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({super.key});

  @override
  State<TopRatedScreen> createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  List topratedmovies = [];

  @override
  void initState() {
    super.initState();
    fetchtopratedMovies();
  }

  Future<void> fetchtopratedMovies() async {
    const url = 'https://api.themoviedb.org/3/movie/top_rated?page=1';
    const String authorizationToken =
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNWExYWJmZjZhM2QzZjYzNWY0NWQ5NTdlNDBkYjlkYiIsInN1YiI6IjY2M2RjZDEzZGRlZjY0MjhlNzBmN2ZkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OLrLtBx-VemJECT9wN32WS_-4ZXsY3TPK6gdbviP2OA';

    final headers = {
      'Accept': 'application/json',
      'Authorization': authorizationToken,
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          topratedmovies = jsonResponse['results'];
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Top Rated Movies',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        Container(
          height: 280,
          width: double.infinity,
          child: topratedmovies.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topratedmovies.length,
                  itemBuilder: (context, index) {
                    final movie = topratedmovies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(id: movie['id']),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [Colors.red, Colors.black],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/original" +
                                        movie['poster_path'],
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Text(
                                    movie['title'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    movie['release_date'],
                                    style: TextStyle(
                                      color: Color.fromARGB(220, 225, 224, 224),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
