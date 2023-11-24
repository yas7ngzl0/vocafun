import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DictionaryPage extends StatelessWidget {
  final List<String> savedWords;

  DictionaryPage(this.savedWords);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelimelerim'),
      ),
      body: ListView.builder(
        itemCount: savedWords.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(savedWords[index]),
            onDismissed: (direction) {
              // Kaydedilen kelimeyi silme işlemi
              savedWords.removeAt(index);
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Silme Onayı"),
                    content: const Text("Bu kelimeyi silmek istiyor musunuz?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("Evet"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Hayır"),
                      ),
                    ],
                  );
                },
              );
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(savedWords[index]),
            ),
          );
        },
      ),
    );
  }
}
