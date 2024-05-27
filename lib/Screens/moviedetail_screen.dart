import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/Screens/genre_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;
  const MovieDetailScreen({super.key, required this.id});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Map<String, dynamic>? movieDetail;
  int movie_id = 0;

  @override
  void initState() {
    print(widget.id);
    setState(() {
      movie_id = widget.id;
    });
    super.initState();
    fetchMoviesdetail();
  }

  Future<void> fetchMoviesdetail() async {
    print(movie_id);
    final url = 'https://api.themoviedb.org/3/movie/$movie_id';
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
          movieDetail = jsonResponse;
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          movieDetail?['title'] ?? 'Movie Detail',
          style: TextStyle(color: const Color.fromARGB(255, 250, 50, 36)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/original${movieDetail?['poster_path'] ?? ''}'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              movieDetail?['title'] ?? '',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 250, 50, 36)),
            ),
            SizedBox(height: 10),
            Text(
              movieDetail?['tagline'] ?? '',
              style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 92, 91, 91)),
            ),
            SizedBox(height: 20),
            Text(
              'Overview',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              movieDetail?['overview'] ?? '',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Genres',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                for (var genre in movieDetail?['genres'] ?? [])
                  Chip(
                    label: Text(genre['name'] ?? ''),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Release Date',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              movieDetail?['release_date'] ?? '',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Production Companies',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var company in movieDetail?['production_companies'] ?? [])
                  Text(
                    company['name'] ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Production Countries',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var country in movieDetail?['production_countries'] ?? [])
                  Text(
                    country['name'] ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Spoken Languages',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var language in movieDetail?['spoken_languages'] ?? [])
                  Text(
                    language['name'] ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Vote Average',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              '${movieDetail?['vote_average'] ?? ''}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                // Open homepage URL
              },
              child: Text(
                movieDetail?['homepage'] ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
