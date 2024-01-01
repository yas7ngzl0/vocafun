
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
  List<WordPair> wordPairs = [];
  List<int> usedRandom = [];
  List<int> matchedPairsLeft = [];
  List<int> matchedPairsRight = [];
  int selectedWordIndex = -1;
  int selectedMeaningIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadWords();
    _loadMeanings();
  }

  Future<void> _loadWords() async {
    String fileName = 'levelb2.txt';
    final String data = await DefaultAssetBundle.of(context).loadString(
        'assets/$fileName');
    setState(() {
      englishWords = data.split('\n');
      //_shuffleWords();
    });
  }

  Future<void> _loadMeanings() async {
    String fileName = 'levelb2turkish.txt';
    final String meaningsData = await DefaultAssetBundle.of(context).loadString(
        'assets/$fileName');
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
      WordPair wordPair = WordPair(
          word: englishWords[randomIndex], meaning: meanings[randomIndex]);

      // Eğer seçilen kelime zaten shuffledList'te yoksa ekle
      if (!wordPairs.contains(wordPair)) {
        wordPairs.add(wordPair);
      } else {
        // Eğer seçilen kelime zaten shuffledList'te varsa, bir daha seç
        i--;
      }
    }
    wordPairs.shuffle();
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
                height: (MediaQuery
                    .of(context)
                    .size
                    .height) * 0.5,
                width: (MediaQuery
                    .of(context)
                    .size
                    .width) * 0.95,
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


  bool allWordsMatched() {
    // Tüm kelimeler eşleştirildi mi kontrol et
    return matchedPairsLeft.length == 5 && matchedPairsRight.length == 5;
  }

  void getNewWords() {
    // Yeni rastgele kelimeleri al
    setState(() {
      wordPairs.clear();
      matchedPairsLeft.clear();
      matchedPairsRight.clear();
      usedRandom.clear();
      selectedWordIndex = -1;
      _shuffleWords();
    });
  }


  //rastegele kelimeler için bu fonksiyon kullanılıyor
  List<int> generateUniqueNumbers() {
    Random random = Random();

    while (usedRandom.length < 5) {
      int newNumber = random.nextInt(5);

      if (!usedRandom.contains(newNumber)) {
        usedRandom.add(newNumber);
      }
    }

    return usedRandom;
  }


  Widget buildRowOfBoxes(bool isLeftColumn) {
    generateUniqueNumbers();
    int i = 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        5,
            (index) {
          int randomIndex = usedRandom[i];
          i++;

          //sağ ve sol sütunların kontrolu için bu değişkenler kullanılıyor
          bool isMatchedLeft = matchedPairsLeft.contains(index);
          bool isMatchedRight = matchedPairsRight.contains(randomIndex);// Sadece kutunun kendisinin eşleşip eşleşmediğini kontrol et

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                if (isLeftColumn) {
                  setState(() {
                    selectedWordIndex = index;
                  });
                } else {
                  //eğer kelimeler eşleşiyorsa ve sağ veya sol sütun boşsa seçilen keliemelri eşleştir
                  if (selectedWordIndex != -1 &&
                      wordPairs[selectedWordIndex].word ==
                          wordPairs[randomIndex].word &&
                      (!isMatchedRight || !isMatchedLeft)) {
                    setState(() {
                      matchedPairsLeft.add(selectedWordIndex);
                      matchedPairsRight.add(randomIndex);
                      selectedWordIndex = -1;

                      // Tüm kelimeler eşleştirildi mi kontrol et
                      if (allWordsMatched()) {
                        // Tüm kelimeler eşleştirildiyse yeni kelimeleri al
                        getNewWords();
                      }

                    });
                  } else {
                    setState(() {
                      selectedWordIndex = -1;
                    });
                  }
                }
              },
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 0.0, -10.0 * (1 - (selectedWordIndex == index && selectedWordIndex != -1 ? 1.0 : 0.0))),
                child: Container(
                  width: 170.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    //eşleşen kelimeler doğru ise kutuların rengini yeşile çevir
                    color: (isLeftColumn && isMatchedLeft) || (!isLeftColumn && isMatchedRight)
                        ? Colors.green
                        : (isLeftColumn && selectedWordIndex == index
                        ? Colors.white38
                        : Colors.white),
                    border: Border.all(color: Colors.blueGrey, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      isLeftColumn ? wordPairs[index].word : wordPairs[randomIndex].meaning,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }





}

  class WordPair {

  String word;
  String meaning;

  WordPair({required this.word, required this.meaning});



}
