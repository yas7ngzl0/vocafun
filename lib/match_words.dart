
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MatchWords());
}




class MatchWords extends StatefulWidget {
  @override
  _MatchWordsState createState() => _MatchWordsState();
}

class _MatchWordsState extends State<MatchWords> {
  List<String> englishWords = [];
  List<String> meanings = [];
  List<String> shuffledEnglishWords = [];
  List<String> shuffledMeanings = [];

  @override
  void initState() {
    super.initState();
    _loadWords();
    _loadMeanings();
  }

  Future<void> _loadWords() async {
    String fileName = 'levelb2.txt';
    final String data = await DefaultAssetBundle.of(context).loadString('assets/$fileName');
    setState(() {
      englishWords = data.split('\n');
      _shuffleWords();
    });
  }

  Future<void> _loadMeanings() async {
    String fileName = 'levelb2turkish.txt';
    final String meaningsData = await DefaultAssetBundle.of(context).loadString('assets/$fileName');
    setState(() {
      meanings = meaningsData.split('\n');
      _shuffleWords();
    });
  }

  void _shuffleWords() {
    // Rastgele seçim için bir Random nesnesi oluştur
    Random random = Random();

    // Rastgele seçilecek kelime sayısı
    int numberOfItemsToSelect = 5;

    // Orijinal listeyi karıştırmadan rastgele seçim yap
    for (int i = 0; i < numberOfItemsToSelect; i++) {
      int randomIndex = random.nextInt(englishWords.length);
      String selectedWord = englishWords[randomIndex];
      String selectedMean = meanings[randomIndex];

      // Eğer seçilen kelime zaten shuffledList'te yoksa ekle
      if (!shuffledEnglishWords.contains(selectedWord) || !meanings.contains(selectedMean)) {
        shuffledEnglishWords.add(selectedWord);
        shuffledEnglishWords.shuffle();
        shuffledMeanings.add(selectedMean);
        shuffledMeanings.shuffle();
      } else {
        // Eğer seçilen kelime zaten shuffledList'te varsa, bir daha seç
        i--;
      }
    }

    // shuffledList'i ekrana yazdır
    print('shuffledList: $shuffledEnglishWords');
  }

  void _shuffleMeanings() {
    shuffledMeanings = List.from(meanings);
    shuffledMeanings.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange.shade100,
        body: Stack(
          children: [
            Center(
              child: Container(
                height: (MediaQuery.of(context).size.height) * 0.5,
                width: (MediaQuery.of(context).size.width) * 0.95,
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  border: Border.all(color: Colors.grey, width: 2.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade200,
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      child: Column(
                        children: [
                          buildRowOfBoxes(true),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Column(
                        children: [
                          buildRowOfBoxes(false),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRowOfBoxes(bool isLeftColumn) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        5,
            (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 170.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blueGrey, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text(
                isLeftColumn
                    ? shuffledEnglishWords[index]
                    : shuffledMeanings[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


