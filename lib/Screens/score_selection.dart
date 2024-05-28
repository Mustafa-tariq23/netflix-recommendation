import 'package:flutter/material.dart';

class ScoreSelectionScreen extends StatefulWidget {
  @override
  _ScoreSelectionScreenState createState() => _ScoreSelectionScreenState();
}

class _ScoreSelectionScreenState extends State<ScoreSelectionScreen> {
  RangeValues scoreRange = RangeValues(0, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Score Range')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RangeSlider(
              values: scoreRange,
              min: 0,
              max: 10,
              divisions: 10,
              labels: RangeLabels(
                scoreRange.start.round().toString(),
                scoreRange.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  scoreRange = values;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, scoreRange);
            },
            child: Text('Apply'),
          ),
        ],
      ),
    );
  }
}
