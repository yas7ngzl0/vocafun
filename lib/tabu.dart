import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(TabuScreen());
}

class TabuScreen extends StatefulWidget {
  @override
  _TabuScreenState createState() => _TabuScreenState();
}

class _TabuScreenState extends State<TabuScreen> {
  List<String> words = [];
  List<String> selectedSentenceWords = [];
  List<String> UsingWords = [];
  late String selectedSentence;

  @override
  void initState() {
    super.initState();
    loadWords();
  }

  Future<void> loadWords() async {
    try {
      String content = await DefaultAssetBundle.of(context).loadString('assets/tabuwords.txt');
      words = LineSplitter.split(content).toList();

      Random random = new Random();
      int sentencesIndex = random.nextInt(words.length);
      selectedSentence = words[sentencesIndex];
      selectedSentenceWords = selectedSentence.split(' ');
      for (String word in selectedSentenceWords) {
        if (word.startsWith('!')) {
          UsingWords.add(word.substring(1)); // Başındaki ünlem işaretini kaldır
        } else {
          UsingWords.add(word);
        }
      }

     UsingWords.shuffle();

      setState(() {}); // State'i güncelle
    } catch (e) {
      print('Dosya okuma hatası: $e');
    }
  }

  @override
  Widget build(Object context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[300],
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: const Center(
            child: Text(
              "ALAKASIZ KELİMEYİ BUL",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: List.generate(5, (index) {
            return Positioned(
              top: 50 + index * 140,
              child: Container(
                width: 200,
                height: 90,
                decoration: BoxDecoration(
                  //color: Colors.lime[(index + 1) * 100],
                  //color: Colors.amber[(index + 1) * 100],
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey.shade900, width: 2.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(child: Text(UsingWords[index])),
              ),
            );
          }),
        ),
      ),
    );
  }
}
