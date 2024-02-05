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
  TextEditingController userTextController = TextEditingController();



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
    int sentencesIndex = random.nextInt(sentences.length);
    String selectedSentence = sentences[sentencesIndex];
    //131 --> denediğim cümle indeksi

    // Seçilen cümleyi kelimelere ayırarak listeye ekle
    selectedSentenceWords = selectedSentence.split(' ');
    selectedSentenceWords.shuffle();


    setState(() {});
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
              style: TextStyle(fontWeight: FontWeight.w300,
                  fontSize: 30,
                  color: Colors.white),
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
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
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                // İkinci çizgi
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
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
            Positioned(
              bottom: 10,
              height: 90,
              width: 300,
              child: Container(
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white,),
                      controller: userTextController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.send,color: Colors.yellow,),
                        hintText: 'Metni buraya girin',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),


      ),
    );
  }
}
