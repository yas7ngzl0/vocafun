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
                  // ... diğer Dismissible özellikleri ...
                  child: ListTile(
                    title: Text(wordMap['word']),
                    subtitle: Text(wordMap['meaning']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
