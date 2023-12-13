import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MatchWords());
}

class MatchWords extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.orange.shade100,
          body: Stack(
            children: [
              Center(
                child: Container(
                  height: (MediaQuery.of(context).size.height)*0.5,
                  width: (MediaQuery.of(context).size.width)*0.95,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200, // İç kısmın rengini belirtmeyerek saydam yapabilirsiniz.
                    border: Border.all(color: Colors.grey, width: 2.0), // Dış çizgiyi ekleyin
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start, // Buradaki değişiklik
                          children: [
                            buildRowOfBoxes(),

                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start, // Buradaki değişiklik
                          children: [
                            buildRowOfBoxes(),

                          ],
                        ),
                      )
                    ],
                  ),


                ),
              )
            ],
          )



        )
    );
  }

  Widget buildRowOfBoxes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        5, // Her satırda 4 kutucuk olacaksa buradaki sayıyı değiştirin
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                        width: 170.0, // Kutucuk genişliği
                        height: 60.0, // Kutucuk yüksekliği
                        //color: Colors.blue, // Kutucuk rengi
                decoration: BoxDecoration(
                  color: Colors.white, // İç kısmın rengini belirtmeyerek saydam yapabilirsiniz.
                  border: Border.all(color: Colors.blueGrey, width: 2.0), // Dış çizgiyi ekleyin
                  borderRadius: BorderRadius.circular(20.0),
                ),
                      ),
            ),
      ),
    );
  }

}