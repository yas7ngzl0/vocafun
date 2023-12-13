import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vocafun/dbHelper.dart';

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
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dil Seviyesi Seçimi',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 20),
              buildLanguageLevelButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLanguageLevelButtons(BuildContext context) {
    return Column(
      children: [
        buildLanguageLevelRow(context, ['A1', 'A2'] ),
        SizedBox(height: 20),
        buildLanguageLevelRow(context, ['B1', 'B2']),
        SizedBox(height: 20),
        buildLanguageLevelRow(context, ['C1','C2']),
      ],
    );
  }

  Widget buildLanguageLevelRow(BuildContext context, List<String> levels) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: levels
            .map((level) => buildLanguageLevelButton(context, level))
            .toList(),
      ),
    );
  }

  LanguageLevelButton buildLanguageLevelButton(BuildContext context, String level) {

    return LanguageLevelButton(
      level: level,
      onPressed: () {
        print('$level seviyesine tıklandı!');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameWidget(selectedLevel: level),
          ),
        );

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
  List<String> meanings = []; // Anlamlar listesi eklenmiş.
  bool isFilled = false;
  Set<int> shownIndices = Set();
  TextEditingController _controller = TextEditingController();

  int selectedWordIndex = 0; // Kullanıcının seçtiği kelimenin index'i
  List<int> visibleIndices = []; // Gösterilen harflerin index'leri
  int letterCount = 3; // Gösterilen harf sayısı



  @override
  void initState() {
    super.initState();
    _loadWords();
    _loadMeanings(); // Anlam dosyasını yükle
  }

  Future<void> _loadWords() async {
    /*final String data =
    await DefaultAssetBundle.of(context).loadString('assets/levela1.txt');*/
    String fileName = 'level${widget.selectedLevel.toLowerCase()}.txt';
    final String data = await DefaultAssetBundle.of(context).loadString('assets/$fileName');
    setState(() {
      words = data.split('\n'); // Satırlara ayır ve kelime listesini oluştur
      _updateSelectedWord();
    });
  }

  Future<void> _loadMeanings() async {
    /*final String meaningsData =
    await DefaultAssetBundle.of(context).loadString('assets/levela1turkish.txt');*/
    // Önce selectedLevel'i küçük harfe çevir ve başına "level" ekle
    String fileName = 'level${widget.selectedLevel.toLowerCase()}turkish.txt';
    final String meaningsData = await DefaultAssetBundle.of(context).loadString('assets/$fileName');
    setState(() {
      meanings = meaningsData.split('\n');
    });
  }

  void _updateSelectedWord() {
    if (words.isNotEmpty) {
      /*selectedWordIndex = Random().nextInt(words.length);
      letterCount = (words[selectedWordIndex].length/2).floor();
      visibleIndices = _generateVisibleIndices(words[selectedWordIndex]);*/
      selectedWordIndex = Random().nextInt(words.length);
      letterCount = (words[selectedWordIndex].length / 2).floor();
      shownIndices.clear();
       // Yeni kelime geldiğinde gösterilen harfleri sıfırla
    }
  }

  List<int> _generateVisibleIndices(String word,List<int> visibleIndices) {
    int wordLength = word.length;
    int visibleCount = letterCount;

    if (visibleCount >= wordLength) {
      visibleCount = wordLength;

      _updateSelectedWord();
    }

    List<int> indices = List.generate(wordLength, (index) => index);

    // Harf index'lerini karıştır ve visibleIndices dizisinde zaten bulunanları çıkart
    List<int> availableIndices = indices.toSet().difference(visibleIndices.toSet()).toList();

    // Eğer availableIndices boşsa, yani visibleIndices dizisindeki tüm harfler zaten gösterilmişse, sıfırdan başla
    if (availableIndices.isEmpty) {
      availableIndices = indices;
      visibleIndices.clear();
    }

    // Rastgele bir indeks seç
    int randomIndex = availableIndices[Random().nextInt(availableIndices.length)];

    // Seçilen indeksi visibleIndices dizisine ekle
    visibleIndices.add(randomIndex);

    return visibleIndices.toList();
  }

  void getLetter(){
    if (selectedWordIndex < 0 || selectedWordIndex >= words.length) {
      // Geçerli bir kelime seçilmemişse veya kelime listesi boşsa işlem yapma
      return;
    }

    String word = words[selectedWordIndex];

    // Görünen harflerin sayısını kontrol et
    int visibleCount = visibleIndices.length;

    // Eğer görünen harf sayısı kelimenin uzunluğuna eşitse, kelime tamamı görüntüleniyor demektir
    if (visibleCount == word.length) {
      setState(() {
        //görüntülenen indis sayısını sıfır yap
        visibleIndices = [];

        //yeni kelimeye gec
        _updateSelectedWord();
        //yeni kelime geldiği için yıldızın içi boşaltılıyor
        isFilled = false;
      });
    } else {
      setState(() {
        visibleIndices = _generateVisibleIndices(word, visibleIndices);
      });
    }
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
        //return '_';
        //son harf hariç diğerlerine çizgi koyuyoruz
        return index < words[selectedWordIndex].length - 1 ? ' _ ' : '';
      }
    }).join('')
        : '';

    String meaning = meanings.isNotEmpty
        ? meanings[selectedWordIndex]
        : ''; // Kelimenin anlamını al

    //Color boxColor = getBoxColor(widget.selectedLevel);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Arka plan rengi
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: getBoxColor(widget.selectedLevel),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: getBoxColor(widget.selectedLevel).withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Şeklin yukarıdan aşağıya düşme mesafesi
                    ),
                  ],
                ),
                // Place the star button within the colored square's container
                child: Stack(
                  children: [
                    Positioned(
                      top: 0.0, // Adjust the top position to align with the top corner
                      right: 0, // Adjust the right position to align with the right corner
                      child: IconButton(
                        onPressed: () {
                          setState(() {

                            if(!isFilled){
                               _loadWordAndMeaning(words[selectedWordIndex], meaning);

                               Fluttertoast.showToast(
                                 msg: 'Kelime kaydedildi',
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.BOTTOM,
                                 backgroundColor: getBoxColor(widget.selectedLevel),
                                 textColor: Colors.white,
                               );


                            }else{
                              _deleteWordAndMeaning(words[selectedWordIndex]);

                              Fluttertoast.showToast(
                                msg: 'Kelime kaydedilenlerden kaldırıldı',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: getBoxColor(widget.selectedLevel),
                                textColor: Colors.white,
                              );
                            }


                            // Tıklanınca durumu tersine çevir
                            isFilled ? isFilled = false : isFilled = true;

                          });
                        },
                        icon: Icon(
                          isFilled ? Icons.star : Icons.star_border,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 100,
                      left: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),),)
                        ),
                      onPressed: () {
                        setState(() {
                          //_updateSelectedWord();
                          //letterCount++;
                          getLetter();
                        });
                      },
                      child: Text('A',style: TextStyle(fontSize : 30, color: Colors.black,fontWeight: FontWeight.bold),),

                    ),
                   ),
                    Positioned(
                      top: 5,
                      left: 10,
                      child: Text(widget.selectedLevel,style: TextStyle(
                          fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),

                  ],
                ),
              ),
            ),
      //içeriğin devamı

              Container(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        meaning,
                        style: TextStyle(
                            fontSize: (words[selectedWordIndex].length > 10) ? 25 : 30,
                            color: Colors.white,fontWeight: FontWeight.w300),
                      ),
                        SizedBox(height: 10),
                        Text(
                          '$selectedWord',
                          style: TextStyle(
                              fontSize: (words[selectedWordIndex].length > 10) ? 25 : 30
                              , color: Colors.white),
                        ),

                      SizedBox(height: 20),


                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

            // Sağ üst köşedeki yıldız ikonu

          ],
        ),
      ),
    );

  }

  @override
  void dispose() {
    // Bellek sızıntısını önlemek için controller'ı dispose et
    _controller.dispose();
    super.dispose();
  }



  }



void _loadWordAndMeaning(String newWord,String newMeaning) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.insertWord(newWord, newMeaning);

}

void _deleteWordAndMeaning(String word) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.deleteWord(word);


}






  Color getBoxColor(String level) {
    switch (level) {
      case 'A1':
        return Colors.green.shade400;
      case 'A2':
        return Colors.blue.shade400;
      case 'B1':
        return Colors.yellow.shade600;
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
        style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
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
      return Colors.yellow.shade500;
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
