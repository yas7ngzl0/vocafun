import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vocafun/dbHelper.dart';

class DictionaryPage extends StatefulWidget {
  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  late Future<List<Map<String, dynamic>>> savedWordsFuture;

  @override
  void initState() {
    super.initState();
    savedWordsFuture = _loadSavedWords();
  }

  Future<List<Map<String, dynamic>>> _loadSavedWords() async {
    DBHelper dbHelper = DBHelper();
    List<Map<String, dynamic>> words = await dbHelper.getWords();
    return words;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelimelerim'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: savedWordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Kaydedilmiş kelime bulunamadı.'));
          } else {
            List<Map<String, dynamic>> savedWords = snapshot.data!;
            return ListView.builder(
              itemCount: savedWords.length,
              itemBuilder: (context, index) {
                final wordMap = savedWords[index];
                return Dismissible(
                  key: Key(wordMap['word']),
                  onDismissed: (direction) {
                    _deleteWord(index);
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
                    title: Text(wordMap['word']),
                    subtitle: Text(wordMap['meaning']),
                    trailing: Icon(Icons.star, color: Colors.deepPurple[200]), // Burada mor yıldız ekleniyor
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _deleteWord(int index) async {
    DBHelper dbHelper = DBHelper();
    List<Map<String, dynamic>> words = await dbHelper.getWords();
    if (index >= 0 && index < words.length) {
      await dbHelper.deleteWord(words[index]['word']);
      setState(() {
        savedWordsFuture = _loadSavedWords();
      });
    }
  }
}

