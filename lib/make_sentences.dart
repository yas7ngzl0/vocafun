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
  List<String> words = ["I", "love", "play", "computer","ve","games","and"];
  int currentIndex = 0;

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
            // Column ekleyerek Cümleyi ve ilk çizgiyi bir araya getir
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cümleyi göster

                Positioned(
                  child: Image.asset('assets/catanimation.gif'),
                ),


                // İlk çizgi
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Divider(
                    color: Colors.white,
                    height: 50,
                    thickness: 2,

                  ),
                ),
                // İlk çizgi
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    words.join(" "),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.center, // Bu satırı ekledik
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Divider(
                    color: Colors.white,
                    height: 50,
                    thickness: 2,

                  ),
                ),
              ],
            ),
            // Kelimeleri göster
            Positioned(
              bottom: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  words.length,
                      (index) => buildAnswerBox(index),
                ),
              ),
            ),
            // İkinci çizgi
            Positioned(
              top: 60,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  "Ben oyun oynamayı severim ve arkadaşlarımda",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible, // Kelimeler sığmazsa devamını göster
                  maxLines: null, // Satır sayısı sınırsız olsun
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

  Widget buildAnswerBox(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        child: Center(
          child: Text(
            words[index],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
