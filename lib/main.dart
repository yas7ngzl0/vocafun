import 'package:flutter/material.dart';
import 'package:vocafun/make_sentences.dart';
import 'package:vocafun/match_words.dart';
import 'package:vocafun/second_page.dart';
import 'package:vocafun/tabu.dart';
import 'package:vocafun/word_game_screen.dart';
import 'package:vocafun/word_repait/word_repait_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> savedWords = [
    'Merhaba',
    'Flutter',
    'Dart',
    'Geliştirici',
  ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      /*theme: ThemeData.light(), // Varsayılan tema
      darkTheme: ThemeData.dark(), // Koyu tema
      themeMode: ThemeMode.system, // Sistem temasını kullan*/
      debugShowCheckedModeBanner: false,
      title: 'VocaFun',

      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[500],
          title: const Text('Welcome!',
            style: TextStyle(color: Colors.white),),
          elevation: 10.0,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DictionaryPage()),
                  );
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyStatelessWidget('Aşagıdaki kutucuğa tıklayarak oyun '
                  '\nsayfasına gidebilirsiniz'),
              MyStatefulWidget(),
              //MyStatelessWidget('Stateless Widget 2'),
            ],
          ),
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  final String title;

  MyStatelessWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350, // İstediğiniz genişliği ayarlayın
      height: 70, // İstediğiniz yüksekliği ayarlayın
      decoration: BoxDecoration(
        color: Colors.deepPurple[500],
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.lightbulb,
            size: 40,
            color: Colors.yellowAccent,
          ),
          const SizedBox(width: 10), // İki öğe arasında bir boşluk ekleyin

          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}



class MyStatefulWidget extends StatelessWidget {
  final List<Color> customColors = [
    Colors.deepPurple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purpleAccent,
    Colors.redAccent,
  ];

  final List<String> boxTexts = [
    'KELİME OYUNU',
    'CÜMLE KURMA',
    'TABU',
    'KELİME EŞLEŞTİRME',
    'KELİME TEKRARI',
    'GRAMER OYUNU',
  ];

  final List<String> boxInfo = [
    'Karşına ingilizce kelimeler ve içlerinden bazı harfler ve aynı zamanda türkçe anlamlar çıkacak. Kelime bilgini test et',
    'Karşına bir cümlenin kelimeleri sıralanmamış bir şekilde gelecek ve senin o cümleyi sırlaman gerekecek ',
    'Karşına çıkan 5 adet kelimeden diğerleri ile alakalı olmayanı seç!',
    'Kelimeleri anlamlarıyla eşleştirmeceğin eğlenceli bir oyun!',
    'Daha önce kaydetmiş olduğun kelimeleri tekrar edebileceğin bir oyun!',
    'Gramer bilgini test edebileceğin ve geliştirebileceğin harika bir oyun!',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildBox(0,context),
              buildBox(1,context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildBox(2,context),
              buildBox(3,context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildBox(4,context),
              buildBox(5,context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBox(int index,BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WordGameScreen()),
          );
        }
        if(index == 1){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MakeSentencesScreen()),
          );
        }
        if(index == 2){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TabuScreen()),
          );

        }
        //bu kısma 2. indexteki işlemi ayz
        if(index == 3){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MatchWords()),
          );
        }

        if(index == 4){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WordRepaitScreen()),
          );
        }


      },
      child: Container(
        width: 180,
        height: 180,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: customColors[index],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: customColors[index].withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              boxTexts[index],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                boxInfo[index],
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








