import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Screens/genre_screen.dart';
import 'package:movie_app/WidgetScreens/nowplaying_screen.dart';
import 'package:movie_app/WidgetScreens/popularmovies_screen.dart';
import 'package:movie_app/WidgetScreens/topmovies_screen.dart';
import 'package:movie_app/WidgetScreens/upcomming_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            UpcommingScreen(),
            SizedBox(
              height: 10,
            ),
            TopRatedScreen(),
            SizedBox(
              height: 10,
            ),
            PopularMoviesScreen(),
            SizedBox(
              height: 10,
            ),
            NowPlayingScreen(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.0),
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.9),
              Colors.black
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenreScreen()),
                  );
                },
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
