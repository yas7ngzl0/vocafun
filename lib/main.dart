import 'package:flutter/material.dart';
import 'package:vocafun/second_page.dart';

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
                        builder: (context) => DictionaryPage(savedWords)),
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

/*class MyStatefulWidget extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) => Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              width: 300,
              height: 300,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: customColors[index % customColors.length],
                borderRadius: BorderRadius.circular(20),
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
    );
  }
}*/

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) => GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => LanguageSelectionWidget(),
              );
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

class LanguageSelectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            'Dil Seviyesi Seçimi',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LanguageLevelButton(level: 'A1'),
              LanguageLevelButton(level: 'A2'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LanguageLevelButton(level: 'B1'),
              LanguageLevelButton(level: 'B2'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LanguageLevelButton(level: 'C1'),
              LanguageLevelButton(level: 'C2'),
            ],
          ),
        ],
      ),
    );
  }
}

class LanguageLevelButton extends StatelessWidget {
  final String level;

  LanguageLevelButton({required this.level});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Seviye seçildiğinde yapılacak işlemler
        Navigator.pop(context); // Bottom sheet'i kapat
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: getButtonColor(
            level), // İstediğiniz rengi buradan belirleyebilirsiniz
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        minimumSize: Size(100, 100), // Kare boyutu
      ),
      child: Text(
        level,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

Color getButtonColor(String level) {
  // Her bir seviye için farklı renkleri döndür
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
      return Colors.blue.shade400; // Varsayılan renk
  }
}
