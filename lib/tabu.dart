import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  ///BU Oyuna da istersen can ve skor özelliği getirebilirsin eğleceli olabilir
  runApp(TabuScreen());
}

class TabuScreen extends StatefulWidget {
  @override
  _TabuScreenState createState() => _TabuScreenState();
}

class _TabuScreenState extends State<TabuScreen> {
  List<String> words = [];
  List<String> selectedSentenceWords = [];
  List<String> usingWords = [];
  late String selectedSentence;
  int currentIndex = 6;
  bool isAnswerTrue = false;

  @override
  void initState() {
    super.initState();
    loadWords();
  }

  Future<void> loadWords() async {
    try {
      String content = await DefaultAssetBundle.of(context).loadString('assets/tabuwords.txt');
      words = LineSplitter.split(content).toList();

      Random random = Random();
      int sentencesIndex = random.nextInt(words.length);
      selectedSentence = words[sentencesIndex];
      selectedSentenceWords = selectedSentence.split(' ');
      // Karıştırmayı burada yapıyoruz
      // Çünkü bu liste doğruluk kontrolü için lazım olabilir
      selectedSentenceWords.shuffle();
      usingWords.clear();
      for (String word in selectedSentenceWords) {
        if (word.startsWith('!')) {
          usingWords.add(word.substring(1)); // Başındaki ünlem işaretini kaldır
        } else {
          usingWords.add(word);
        }
      }

      setState(() {}); // State'i güncelle
    } catch (e) {
      print('Dosya okuma hatası: $e');
    }
    currentIndex = 6;
  }

  void checkAndLoadNextWord() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (selectedSentenceWords[currentIndex].startsWith('!')) {
        // Eğer seçilen kelimenin başında ünlem işareti varsa, arka plan rengini yeşil yap
        // ve yeni bir kelimeye geçmek için loadWords fonksiyonunu çağır

        setState(() {

        });
        loadWords(); // Yeni bir kelimeye geç
      } else {
        // Eğer seçilen kelimenin başında ünlem işareti yoksa, sadece yeni bir kelimeye geç
        //loadWords(); // Yeni bir kelimeye geç
      }
    });
  }


  @override
  Widget build(BuildContext context) {
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
            Color backgroundColor = Colors.white;
            if (currentIndex == index && usingWords.isNotEmpty) {
              // Eğer kullanıcının seçtiği kelime bu kutuda gösteriliyorsa ve kelime başında ünlem işareti varsa
              if (selectedSentenceWords[index].startsWith('!')) {
                backgroundColor = Colors.green;// Arka plan rengini yeşil yap

              }
              else{
               backgroundColor = Colors.red;
              }

            }
            return Positioned(
              top: 50 + index * 140,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                    checkAndLoadNextWord();// Seçilen kelimeye göre kontrol yap ve yeni bir kelimeye geç

                  });
                },
                child: Container(
                  width: 200,
                  height: 90,
                  decoration: BoxDecoration(
                    color: backgroundColor,
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
                  child: Center(
                    child: Text(
                      usingWords.isNotEmpty ? usingWords[index] : '',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
