import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Center(child: Text('Welcome')),
          elevation: 10.0,
        ),
        body: MyStatefulWidget(),
      ),
    );
  }
}*/

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
  String myText = 'Kelime Oyunu';
  String infoText =
      'Kelime oyununda size bazı ingilizce kelimelerin içerisindeki rastegele birkaç harf'
      've kelimenin türkçesi verilecek ve sizde kelimeyi doğru tahmin etmeye çalışacaksınız';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
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
              top: 150, // Metnin yüksekliğini ayarla
              left: 25, // Metnin sol tarafındaki boşluğu ayarla
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
              top: 10, // İlk metnin yüksekliğini ayarla
              left: 20, // İlk metnin sol tarafındaki boşluğu ayarla
              child: Text(
                infoText,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
