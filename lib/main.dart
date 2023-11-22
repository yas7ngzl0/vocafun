import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[200],
          title: Text('Welcome'), // Doğrudan Text widget'ını kullan
          elevation: 10.0,
          actions: [
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                // Yıldıza tıklandığında yapılacak işlemler
              },
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
            color: Colors.yellow,
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
            ),
          ),
        ),
      ),
    );
  }
}

/*class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String myText = 'Kelime Oyunu';
  String infoText =
      'Kelime oyununda size bazı İngilizce kelimelerin içerisindeki rastgele birkaç harf'
      've kelimenin Türkçesi verilecek ve siz de kelimeyi doğru tahmin etmeye çalışacaksınız';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[200],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 25,
                  child: Text(
                    myText,
                    style: TextStyle(
                      color: Colors.yellow[600],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 20,
                  child: Text(
                    infoText,
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Yatay Scroll View içinde aynı boyutta ve farklı renkte kutular
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.primaries[index % Colors.primaries.length],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // İçeriği özelleştirebilirsiniz
                    child: Center(
                      child: Text(
                        'Kutu $index',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
