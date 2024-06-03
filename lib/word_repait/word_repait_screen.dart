import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'AnimatedFloatingActionButton.dart';


void main() {
  runApp(WordRepaitScreen());
}

class WordRepaitScreen extends StatefulWidget {
  @override
  _WordRepaitScreenState createState() => _WordRepaitScreenState();
}

class _WordRepaitScreenState extends State<WordRepaitScreen> {
  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.centerDocked;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purpleAccent,
        floatingActionButton: AnimatedFloatingActionButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
              _fabLocation = _isExpanded
                  ? FloatingActionButtonLocation.centerDocked
                  : FloatingActionButtonLocation.centerDocked;
            });
          },

          isExpanded: _isExpanded,
        ),
        floatingActionButtonLocation: _fabLocation,
        bottomNavigationBar: BottomAppBar(
          color: Colors.purple,
          shape: CircularNotchedRectangle(),
        ),
        body: Stack(
          children: [
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Hello world!',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 2000),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



