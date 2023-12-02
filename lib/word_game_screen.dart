import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(WordGameScreen());
}

class WordGameScreen extends StatelessWidget {
  final List<String> savedWords = [
    'Merhaba',
    'Flutter',
    'Dart',
    'Geliştirici',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Arka plan rengi beyaz yapıldı
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dil Seviyesi Seçimi',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildLanguageLevelButton(context,'A1'),
                   buildLanguageLevelButton(context,'A2'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   buildLanguageLevelButton(context,'B1'),
                    buildLanguageLevelButton(context,'B2'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildLanguageLevelButton(context,'C1'),
                    buildLanguageLevelButton(context,'C2'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LanguageLevelButton buildLanguageLevelButton(BuildContext context,String level) {
    return LanguageLevelButton(
                    level: level,
                    onPressed: () {
                      print('$level seviyesine tıklandı!');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GameWidget(selectedLevel: level,)),
                      );
                      // Buraya istediğiniz widget'ın açılmasını sağlayacak kodları ekleyebilirsiniz
                    },
                  );
  }
}






class GameWidget extends StatefulWidget {
  final String selectedLevel;

  GameWidget({required this.selectedLevel});


  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  List<String> words = [];
  bool isFilled = false;

  int selectedWordIndex = 0; // Kullanıcının seçtiği kelimenin index'i
  List<int> visibleIndices = []; // Gösterilen harflerin index'leri
  int letterCount = 3; // Gösterilen harf sayısı

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    final String data =
    await DefaultAssetBundle.of(context).loadString('assets/levela1.txt');
    setState(() {
      words = data.split('\n'); // Satırlara ayır ve kelime listesini oluştur
      _updateSelectedWord();
    });
  }

  void _updateSelectedWord() {
    if (words.isNotEmpty) {
      selectedWordIndex = Random().nextInt(words.length);
      visibleIndices = _generateVisibleIndices(words[selectedWordIndex]);
    }
  }

  List<int> _generateVisibleIndices(String word) {
    int wordLength = word.length;
    int visibleCount = letterCount;
    if (visibleCount > wordLength) {
      visibleCount = wordLength;
    }

    List<int> indices = List.generate(wordLength, (index) => index);
    indices.shuffle(); // Harf index'lerini karıştır

    return indices.sublist(0, visibleCount);
  }

  @override
  Widget build(BuildContext context) {
    String selectedWord = words.isNotEmpty
        ? words[selectedWordIndex]
        .split('')
        .asMap()
        .entries
        .map((entry) {
      int index = entry.key;
      if (visibleIndices.contains(index)) {
        return entry.value;
      } else {
        return '_';
      }
    }).join()
        : '';

    //Color boxColor = getBoxColor(widget.selectedLevel);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Arka plan rengi
            Center(
              child: Container(
                //width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: getBoxColor(widget.selectedLevel),
                    borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            // İçerik
            Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$selectedWord',
                      style: TextStyle(fontSize: 30,color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _updateSelectedWord();
                        });
                      },
                      child: Text('Yeni Kelime'),
                    ),
                    SizedBox(height: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // Tıklanınca durumu tersine çevir
                          isFilled ? isFilled = false : isFilled = true;
                        });

                      },
                      icon: Icon(isFilled ? Icons.star : Icons.star_border,size: 35,color: Colors.white,),



                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  Color getBoxColor(String level) {
    switch (level) {
      case 'A1':
        return Colors.green.shade400;
      case 'A2':
        return Colors.blue.shade400;
      case 'B1':
        return Colors.yellow.shade400;
      case 'B2':
        return Colors.orange.shade400;
      case 'C1':
        return Colors.red.shade400;
      case 'C2':
        return Colors.purple.shade300;
      default:
        return Colors.blue.shade400;
    }
  }





class LanguageLevelButton extends StatelessWidget {
  final String level;
  final VoidCallback onPressed;

  LanguageLevelButton({required this.level, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: getButtonColor(level),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        minimumSize: Size(150, 150),
      ),
      child: Text(
        level,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

Color getButtonColor(String level) {
  switch (level) {
    case 'A1':
      return Colors.green.shade400;
    case 'A2':
      return Colors.blue.shade400;
    case 'B1':
      return Colors.yellow.shade400;
    case 'B2':
      return Colors.orange.shade400;
    case 'C1':
      return Colors.red.shade400;
    case 'C2':
      return Colors.purple.shade400;
    default:
      return Colors.blue.shade400;
  }
}
