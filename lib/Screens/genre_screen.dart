// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:movie_app/Screens/home_screen.dart';
// import 'package:movie_app/Screens/moviedetail_screen.dart';

// class GenreScreen extends StatefulWidget {
//   const GenreScreen({Key? key}) : super(key: key);

//   @override
//   State<GenreScreen> createState() => _GenreScreenState();
// }

// class _GenreScreenState extends State<GenreScreen> {
//   Map<String, dynamic>? _selectedGenre;
//   List moviesbygenre = [];
//   int votingvalue = 0;
//   bool buttonclicked = false;

//   final List<int> votevalue = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

//   final List<Map<String, dynamic>> genres = [
//     {"id": 28, "name": "Action"},
//     {"id": 12, "name": "Adventure"},
//     {"id": 16, "name": "Animation"},
//     {"id": 35, "name": "Comedy"},
//     {"id": 80, "name": "Crime"},
//     {"id": 99, "name": "Documentary"},
//     {"id": 18, "name": "Drama"},
//     {"id": 10751, "name": "Family"},
//     {"id": 14, "name": "Fantasy"},
//     {"id": 36, "name": "History"},
//     {"id": 27, "name": "Horror"},
//     {"id": 10402, "name": "Music"},
//     {"id": 9648, "name": "Mystery"},
//     {"id": 10749, "name": "Romance"},
//     {"id": 878, "name": "Science Fiction"},
//     {"id": 10770, "name": "TV Movie"},
//     {"id": 53, "name": "Thriller"},
//     {"id": 10752, "name": "War"},
//     {"id": 37, "name": "Western"}
//   ];

//   Future<void> fetchpopularMovies(int value, int genreid) async {
//     final url =
//         'https://api.themoviedb.org/3/discover/movie?vote_average.lte=$value&with_genres=$genreid';
//     const String authorizationToken =
//         'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNWExYWJmZjZhM2QzZjYzNWY0NWQ5NTdlNDBkYjlkYiIsInN1YiI6IjY2M2RjZDEzZGRlZjY0MjhlNzBmN2ZkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OLrLtBx-VemJECT9wN32WS_-4ZXsY3TPK6gdbviP2OA';

//     final headers = {
//       'Accept': 'application/json',
//       'Authorization': authorizationToken,
//     };

//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         setState(() {
//           moviesbygenre = jsonResponse['results'];
//         });
//         print(moviesbygenre);
//       } else {
//         print('Error: ${response.reasonPhrase}');
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.black,
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 200,
//                       padding: EdgeInsets.all(16.0),
//                       child: DropdownButtonFormField<Map<String, dynamic>>(
//                         decoration: InputDecoration(
//                           fillColor: const Color.fromARGB(255, 253, 98, 87),
//                           filled: true,
//                           border: OutlineInputBorder(),
//                           labelText: 'Select Genre',
//                         ),
//                         value: _selectedGenre,
//                         dropdownColor: Colors.red,
//                         style: TextStyle(color: Colors.white),
//                         onChanged: (Map<String, dynamic>? newValue) {
//                           setState(() {
//                             _selectedGenre = newValue;
//                             print(_selectedGenre);
//                           });
//                         },
//                         items: genres
//                             .map<DropdownMenuItem<Map<String, dynamic>>>(
//                                 (genre) {
//                           return DropdownMenuItem<Map<String, dynamic>>(
//                             value: genre,
//                             child: Text(genre["name"]),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     Container(
//                       width: 100,
//                       padding: EdgeInsets.all(16.0),
//                       child: DropdownButtonFormField<int>(
//                         decoration: InputDecoration(
//                           fillColor: const Color.fromARGB(255, 253, 98, 87),
//                           filled: true,
//                           border: OutlineInputBorder(),
//                         ),
//                         value: votingvalue,
//                         dropdownColor: Colors.red,
//                         style: TextStyle(color: Colors.white),
//                         onChanged: (newValue) {
//                           setState(() {
//                             votingvalue = newValue!;
//                             print(votingvalue);
//                           });
//                         },
//                         items:
//                             votevalue.map<DropdownMenuItem<int>>((int value) {
//                           return DropdownMenuItem<int>(
//                             value: value,
//                             child: Text(value.toString()),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           buttonclicked = true;
//                         });
//                         fetchpopularMovies(votingvalue, _selectedGenre!["id"]);
//                       },
//                       child: Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(255, 253, 98, 87),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Icon(
//                           Icons.search,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height - 100,
//                 width: double.infinity,
//                 child: moviesbygenre.isEmpty
//                     ? buttonclicked == true
//                         ? Center(child: CircularProgressIndicator())
//                         : SizedBox(height: 10)
//                     : GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           childAspectRatio: 0.6,
//                           crossAxisSpacing: 10.0,
//                           mainAxisSpacing: 10.0,
//                         ),
//                         itemCount: moviesbygenre.length,
//                         itemBuilder: (context, index) {
//                           final movie = moviesbygenre[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       MovieDetailScreen(id: movie['id']),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               color: Color.fromARGB(255, 252, 36, 21),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(25),
//                                       bottomRight: Radius.circular(25),
//                                       topLeft: Radius.circular(10),
//                                       topRight: Radius.circular(10),
//                                     ),
//                                     child: Image.network(
//                                       "https://image.tmdb.org/t/p/original" +
//                                           movie['poster_path'],
//                                       fit: BoxFit.cover,
//                                       height: 170,
//                                       width: double.infinity,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       movie['title'],
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8.0),
//                                     child: Text(
//                                       movie['release_date'],
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               )
//             ],
//           ),
//         ),
//         bottomNavigationBar: Container(
//           height: 80,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.black.withOpacity(0.0),
//                 Colors.black.withOpacity(0.5),
//                 Colors.black.withOpacity(0.7),
//                 Colors.black.withOpacity(0.9),
//                 Colors.black
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => HomeScreen()),
//                     );
//                   },
//                   child: Icon(
//                     Icons.home,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Icon(
//                   Icons.search,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'genre_selection.dart';
import 'score_selection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenreScreen extends StatefulWidget {
  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  Map<String, bool> selectedGenres = {};
  String condition = 'AND';
  RangeValues scoreRange = RangeValues(0, 10);
  List<dynamic> filteredMovies = [];

  Future<void> fetchFilteredMovies() async {
    const apiKey = '05a1abff6a3d3f635f45d957e40db9db';
    final genreIds = selectedGenres.entries
        .where((entry) => entry.value)
        .map((entry) => getGenreId(entry.key))
        .join(',');
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreIds&vote_average.gte=${scoreRange.start}&vote_average.lte=${scoreRange.end}';

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer YOUR_ACTUAL_ACCESS_TOKEN',
    };

    try {
      print('Fetching movies with URL: $url');
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          filteredMovies = jsonResponse['results'] ?? [];
        });
      } else {
        print(
            'Error occurred: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  int getGenreId(String genre) {
    Map<String, int> genreMap = {
      'Action': 28,
      'Adventure': 12,
      'Animation': 16,
      'Comedy': 35,
      'Drama': 18,
    };
    return genreMap[genre] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Genres and Score')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GenreSelectionScreen()),
              );
              if (result != null) {
                setState(() {
                  selectedGenres = result['genres'];
                  condition = result['condition'];
                });
              }
            },
            child: Text('Select Genres'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScoreSelectionScreen()),
              );
              if (result != null) {
                setState(() {
                  scoreRange = result;
                });
              }
            },
            child: Text('Select Score Range'),
          ),
          ElevatedButton(
            onPressed: fetchFilteredMovies,
            child: Text('Fetch Movies'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                    title: Text(movie['title'] ?? 'No Title'),
                    subtitle: Text(movie['release_date'] ?? 'No Release Date'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
