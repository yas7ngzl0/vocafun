
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MakeSentencesScreen());
}

class MakeSentencesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(20.0),

                  ),
                ),
              )
            ],
          ),

        )
    );
  }

}



