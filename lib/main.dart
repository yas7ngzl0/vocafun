import 'package:flutter/material.dart';
import 'package:vocafun/second_page.dart';
import 'package:vocafun/word_game_screen.dart';

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
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[200],
          title: const Text('Welcome'), // Doğrudan Text widget'ını kullan
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyStatelessWidget('Aşagıdaki kutucuğa tıklayarak oyun '
                '\nsayfasına gidebilirsiniz'),
            MyStatefulWidget(),
            //MyStatelessWidget('Stateless Widget 2'),
          ],
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
        color: Colors.deepPurple[200],
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
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}



class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<Color> customColors = [
    Colors.deepPurple.shade200,
    Colors.blue.shade200,
    Colors.green.shade200,
    Colors.orange.shade200,
  ];

  final List<String> boxTexts = [
    'KELİME OYUNU',
    'YAKINDA',
    'YAKINDA',
    'YAKINDA',
  ];

  final List<String> boxInfo = [
    'Karşına ingilizce kelimeler ve içlerinden \nbazı harfler ve aynı zamanda türkçe \nanlamlar çıkacak. Kelime bilgini test et',
    ' ',
    ' ',
    ' ',
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) => GestureDetector(
            onTap: () {
              if (index == 0) { // İlk kutuya tıklandığında
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WordGameScreen()),

                );

              }
            },
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                width: 300,
                height: 300,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: customColors[index % customColors.length],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: customColors[index % customColors.length].withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Şeklin yukarıdan aşağıya düşme mesafesi
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Positioned(
                        child: Text(
                          boxTexts[index % boxTexts.length],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 70, // İstediğiniz yüksekliği ayarlayın
                      left: 10, // İstediğiniz sol tarafındaki boşluğu ayarlayın
                      child: Text(
                        boxInfo[index % boxInfo.length],
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




