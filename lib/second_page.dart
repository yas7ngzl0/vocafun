import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İkinci Sayfa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bu İkinci Sayfanın İçeriğidir.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // İkinci sayfadan ana sayfaya geri dön
                Navigator.pop(context);
              },
              child: Text('Ana Sayfaya Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }
}
