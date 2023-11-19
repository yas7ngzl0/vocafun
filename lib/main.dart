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
          backgroundColor: Colors.deepPurple,
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
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String myText = 'Merhaba, Flutter!';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        color: Colors.grey,
      ),
    );
  }
}
