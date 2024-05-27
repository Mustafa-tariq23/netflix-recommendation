import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app/Screens/moviedetail_screen.dart';

class UpcommingScreen extends StatefulWidget {
  const UpcommingScreen({super.key});

  @override
  State<UpcommingScreen> createState() => _UpcommingScreenState();
}

class _UpcommingScreenState extends State<UpcommingScreen> {
  List upcommingmovies = [];
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    fetchUpcomingMovies();
    super.initState();
    _pageController.addListener(() {
      int nextPage = _pageController.page!.round();
      if (_currentPage != nextPage) {
        setState(() {
          _currentPage = nextPage;
        });
      }
    });
  }

  Future<void> fetchUpcomingMovies() async {
    const url = 'https://api.themoviedb.org/3/movie/upcoming?page=1';
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
          upcommingmovies = jsonResponse['results'];
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
        Container(
          height: MediaQuery.of(context).size.height - 80,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: upcommingmovies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onDoubleTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                              id: upcommingmovies[index]['id'])));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height - 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        "https://image.tmdb.org/t/p/original" +
                            upcommingmovies[index]['poster_path'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity - 80,
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.46,
                              child: Text(
                                upcommingmovies[index]['title'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                                overflow: TextOverflow.visible,
                                maxLines: null,
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.50,
                              child: Text(
                                'Release Date: ' +
                                    upcommingmovies[index]['release_date'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                                overflow: TextOverflow.visible,
                                maxLines: null,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(upcommingmovies.length, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 3.0),
          height: _currentPage == index ? 12.0 : 5.0,
          width: _currentPage == index ? 12.0 : 5.0,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color.fromARGB(255, 253, 20, 3)
                : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        );
      }),
    );
  }
}
