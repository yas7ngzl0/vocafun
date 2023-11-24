import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LanguageSelectionPage());
}

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dil Seviyesi Seçimi'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => LanguageSelectionWidget(),
                  );
                },
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Tıkla ve Dil Seviyenizi Seçin',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
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
      width: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Text(
            'Dil Seviyesi Seçimi',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Seviye 1 seçildiğinde yapılacak işlemler
              Navigator.pop(context); // Bottom sheet'i kapat
            },
            child: Text('Seviye 1'),
          ),
          ElevatedButton(
            onPressed: () {
              // Seviye 2 seçildiğinde yapılacak işlemler
              Navigator.pop(context); // Bottom sheet'i kapat
            },
            child: Text('Seviye 2'),
          ),
        ],
      ),
    );
  }
}
