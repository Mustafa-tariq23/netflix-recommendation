import 'package:flutter/material.dart';

class GenreSelectionScreen extends StatefulWidget {
  @override
  _GenreSelectionScreenState createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  List<String> genres = ['Action', 'Adventure', 'Animation', 'Comedy', 'Drama'];
  Map<String, bool> selectedGenres = {};
  String condition = 'AND';

  @override
  void initState() {
    super.initState();
    for (var genre in genres) {
      selectedGenres[genre] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Genres')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: genres.map((genre) {
                return CheckboxListTile(
                  title: Text(genre),
                  value: selectedGenres[genre],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedGenres[genre] = value!;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text('AND'),
            leading: Radio<String>(
              value: 'AND',
              groupValue: condition,
              onChanged: (String? value) {
                setState(() {
                  condition = value!;
                });
              },
            ),
          ),
          ListTile(
            title: Text('OR'),
            leading: Radio<String>(
              value: 'OR',
              groupValue: condition,
              onChanged: (String? value) {
                setState(() {
                  condition = value!;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                  context, {'genres': selectedGenres, 'condition': condition});
            },
            child: Text('Apply'),
          ),
        ],
      ),
    );
  }
}
