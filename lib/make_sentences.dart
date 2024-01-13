/*import 'package:flutter/material.dart';


void main() {
  runApp(MakeSentencesScreen());
}

class MakeSentencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(
          title: Center(
            child:  Text(
              'Cümle Kurma Oyunu',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30, color: Colors.white),
            ),
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: Column(
          children: <Widget>[
            Text(
                'Ben oyun onamayı severim',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
            // İlk çizgi
            Padding(
              padding: EdgeInsets.only(top: 200), // Üstte 20 piksel boşluk bırakır
              child: Divider(
                color: Colors.white,
                height: 50,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
            ),
            // İkinci çizgi
            Padding(
              padding: EdgeInsets.only(top: 20), // Üstte 20 piksel boşluk bırakır
              child: Divider(
                color: Colors.white,
                height: 50,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
            ),
            // Diğer çizgiler buraya gelebilir
          ],
        ),
      ),
    );
  }
}*/




import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MakeSentencesScreen());
}

class MakeSentencesScreen extends StatefulWidget {
  @override
  _MakeSentencesScreenState createState() => _MakeSentencesScreenState();
}

class _MakeSentencesScreenState extends State<MakeSentencesScreen> {
  List<String> words = ["I", "love", "play", "computer"," "," "," "," "];
  int currentIndex = 0;


  //kutularda kullanılmak üzere keliemelri içerecek listeler
  List<String> selectedSentenceWords = [];
  List<String> randomWords = [];
  List<bool> isDeleteCalledList = [false, false, false]; // Her satır için bayrakları içeren liste



  @override
  void initState() {
    super.initState();
    loadSentences();
  }

  Future<void> loadSentences() async {
    String content = await DefaultAssetBundle.of(context).loadString('assets/sentences.txt');
    List<String> sentences = LineSplitter.split(content).toList();

    // Örnek olarak ilk cümleyi seçtik, istediğiniz başka bir algoritma kullanabilirsiniz.
    Random random = new Random();
    int sentencesIndex  =random.nextInt(sentences.length);
    String selectedSentence = sentences[130];
    //131 --> denediğim cümle indeksi

    // Seçilen cümleyi kelimelere ayırarak listeye ekle
    selectedSentenceWords = selectedSentence.split(' ');
    selectedSentenceWords.shuffle();

    // Diğer cümlelerden rastgele kelimeleri seç
    randomWords = getRandomWords(sentences, selectedSentenceWords.length);

    // İlk liste karışık, ikinci liste rastgele seçilmiş kelimelerle dolduruldu
    setState(() {});
  }




  List<String> getRandomWords(List<String> sentences, int count) {
    List<String> result = [];
    Random random = Random();
    result.addAll(selectedSentenceWords);

    while (result.length < 12) {
      String randomWord;
      do {
        // Rastgele bir cümle seç
        String randomSentence = sentences[random.nextInt(sentences.length)];
        // Cümleyi kelimelere ayır ve rastgele bir kelime seç
        List<String> randomSentenceWords = randomSentence.split(' ');
        randomWord = randomSentenceWords[random.nextInt(randomSentenceWords.length)];
      } while (result.contains(randomWord)); // Aynı kelimeyi iki kez seçmemek için kontrol

      result.add(randomWord);
    }
    result.shuffle();

    return result;
  }







  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(
          title: Center(
            child: Text(
              'Cümle Kurma Oyunu',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30, color: Colors.white),
            ),
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Gif ekleyin
            Positioned(
              top: 100,
              child: Image.asset('assets/catanimation.gif'), // Gif ekledik
            ),
            // Column ekleyerek Cümleyi ve ilk çizgiyi bir araya getir
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // İlk çizgi
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Divider(
                    color: Colors.white,
                    height: 50,
                    thickness: 2,
                  ),
                ),



                // Cümleyi göster
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    words.join(" "),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                // İkinci çizgi
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Divider(
                    color: Colors.white,
                    height: 50,
                    thickness: 2,
                  ),
                ),
                // İkinci çizgi
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Ben oyun oynamayı severim ve arkadaşlarımda",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            // Kelimeleri göster
            Positioned(
              bottom: 20,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                          (index) => buildAnswerBox(index,0),
                    ),
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: List.generate(
                      4,
                          (index) => buildAnswerBox(index,1),
                    ),
                  ),
                  SizedBox(height:10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                          (index) => buildAnswerBox(index,2),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),


      ),
    );
  }





  Widget buildAnswerBox(int index,int counter) {
    /*if (index < 0 || index >= selectedSentenceWords.length + randomWords.length) {
      // İndeks sınırların dışında, boş bir konteyner döndür
      return Container();
    }*/

    if (randomWords.length > 4 && counter != 0 && !isDeleteCalledList[counter]) {
      //randomWords = deleteFirst4Words(randomWords);
      deleteFirst4Words(randomWords);
      isDeleteCalledList[counter] = true; // delete fonksiyonunun bir kez çağrıldığını belirt
    }

    String word;
    word = randomWords[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,  // 4 sütun
        height: 30,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        child: Center(
          child: Text(
            word,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 9 < selectedSentenceWords[index].length ? 12 : 15,
            ),
          ),
        ),
      ),
    );
  }



  /*List<String> deleteFirst4Words(List<String> randomWords) {
    for (int i = 0; i < 4; i++) {
      randomWords.removeAt(i);
    }
    return randomWords;
  }*/


  List<String> deleteFirst4Words(List<String> randomWords) {
    if (randomWords.length >= 4) {
      randomWords.removeRange(0, 4);
    }
    return randomWords;
  }



}
