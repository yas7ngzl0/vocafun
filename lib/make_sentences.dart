
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MakeSentencesScreen());
}

class MakeSentencesScreen extends StatefulWidget{
  @override
  _MakeSentencesScreenState createState() => _MakeSentencesScreenState();
}

class _MakeSentencesScreenState extends State<MakeSentencesScreen> with SingleTickerProviderStateMixin{
  List<String> words = ["I", "love", "play", "computer"," "," "," "," "];
  int currentIndex = 0;


  //kutularda kullanılmak üzere keliemelri içerecek listeler
  List<String> selectedSentenceWords = [];
  List<String> selectedTurkishSentenceWords = [];
  //bu liste kalp ikonlarının takibi için kullanılacak
  List<bool> favoriteIcons = [true,true,true,true,true];
  TextEditingController userTextController = TextEditingController();
  late String selectedSentence;
  late String selectedTurkishSentence;
  String userInput = "Girilen Cümle";
  //en başta istenilen cümlenin görünmez olması için
  bool isDecided = false;
  // Kullanıcının girdiği cümlenin doğruluğunu tutmak için
  bool isCorrect = false;
  //kulanıcının skorunu tutmak için bu eğişkeni kullanacağız
  int score = 0;
  int tempetureScore = 0;//gerçek skorun üstüne eklemek için her kelimeye özel olarak kullanılıyor
  String selectedSentenceString =  "";//ipucu butonu için kullanlıyor
  int bestScore = 0;
  SharedPreferences? prefs;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    loadSentences();
    getDataFromSharedPreferences();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  getDataFromSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      bestScore = prefs?.getInt("bestScore") ?? 0;
    });
  }



  Future<void> loadSentences() async {
    String content = await DefaultAssetBundle.of(context).loadString('assets/sentences.txt');
    List<String> sentences = LineSplitter.split(content).toList();
    //türkçe cümleler içinde dosyadan okuma yapıyoruz
    String turkishContent = await DefaultAssetBundle.of(context).loadString('assets/turkishsentences.txt');
    List<String> turkishSentences = LineSplitter.split(turkishContent).toList();

    // Örnek olarak ilk cümleyi seçtik, istediğiniz başka bir algoritma kullanabilirsiniz.
    Random random = new Random();
    int sentencesIndex = random.nextInt(sentences.length);
    selectedSentence = sentences[sentencesIndex];
    selectedTurkishSentence = turkishSentences[sentencesIndex];
    //131 --> denediğim cümle indeksi

    // Seçilen cümleyi kelimelere ayırarak listeye ekle
    selectedSentenceWords = selectedSentence.split(' ');
    selectedTurkishSentenceWords = selectedTurkishSentence.split(' ');
    tempetureScore = selectedSentenceWords.length;

    selectedSentenceString = selectedSentenceWords.sublist(currentIndex).join(" ");



    setState(() {});
  }












  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[900],
        //sanal klavye açıldığında nesnelerin kaymasını önlemek için
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Cümle Kurma Oyunu',
              style: TextStyle(fontWeight: FontWeight.w300,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 20,
              left: 10,
              child: Row(//listeye bakılara kalplerin içerisi boşaltılacak
                    children: List.generate(favoriteIcons.length, (index) {
                      return favoriteIcons[index]
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border, color: Colors.red);
                    }),
                  )
                ),

            Positioned(
              right: 10,
              top: 20,
              child: Row(
              children: [
                Text("PUAN : $score"
                    "\nBEST : $bestScore",style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),),
              ],
            ),
            ),

            // Gif ekleyin
            Positioned(
              top: 100,
              child: Image.asset('assets/catanimation.gif'), // Gif ekledik
            ),
            // Column ekleyerek Cümleyi ve ilk çizgiyi bir araya getir
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // İlk çizgi
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
                  child: Divider(
                    color: Colors.white,
                    height: 50,
                    thickness: 2,
                  ),
                ),

                // Cümleyi göster
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child : RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: userInput,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        WidgetSpan(
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _animationController.value,
                                child: Text(
                                  '|',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                ),

                // Cümleyi göster
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Opacity(
                    opacity: isDecided ? 1.0 : 0.0,
                    child: Text(
                      selectedSentenceString,
                      style: TextStyle(
                        color: isCorrect ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // İkinci çizgi
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
                  child: Divider(
                    color: Colors.white,
                    height: 50,
                    thickness: 2,
                  ),
                ),
                // İkinci çizgi
                SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      selectedTurkishSentenceWords.join(" "),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      maxLines: null,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Positioned(
              bottom: 180,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // bir kelime gösterilecek ve geçici skordan bir düşülecek
                      if(tempetureScore > 0){
                        tempetureScore--;
                      }
                      setState(() {
                        isDecided = true;
                        currentIndex +=1;
                        selectedSentenceString = selectedSentenceWords.sublist(0,currentIndex).join(" ");
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],// ElevatedButton rengi (sarısı)
                      elevation: 4,
                      shadowColor: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: Colors.white, // Ampul ikonunun rengi (beyaz)
                        ),
                        SizedBox(width: 8), // Ikon ile metin arasında boşluk bırakmak için
                        Text(
                          "İpucu Al",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      loadSentences();
                      isDecided = false;
                      isCorrect = false;
                      userInput = "Girilen Cümle";
                      userTextController.clear(); // TextField'ı temizle
                      currentIndex = 0;//görünen kelimeleri yeniden sıfır yapmak için
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],// ElevatedButton rengi (sarısı)
                      elevation: 4,
                      shadowColor: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.update,
                          color: Colors.white, // Ampul ikonunun rengi (beyaz)
                        ),
                        SizedBox(width: 8), // Ikon ile metin arasında boşluk bırakmak için
                        Text(
                          "Sonraki Cümle",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),


            Positioned(
              bottom: 10,
              height: 90,
              width: 300,
              child: Container(
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white,),
                      controller: userTextController,
                      onChanged: (text) {
                        // Girilen metni 24 boyutlu bir metne dönüştür
                        setState(() {
                          userInput = text;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            //girilen metin istenilen metinle karşılaştırılmak üzerefonksiyona gönderiliyor
                            bool result =
                            isDesiredSentence(userInput, selectedSentence);
                            setState(() {
                              isCorrect = result;
                              //eper güncel skor en yüksek skordan yükseğ çıkmışsa güncellmee yapacağız
                              if(score > bestScore){
                                prefs?.setInt("bestScore", score);//yeni en yüksek skor belirlendi
                              }

                              //sonuç yanlış ise kalplerin içerisi boşaltılmalı
                              // ve eğer hepsi boşsa skor sıfırlanıp yeniden doldurulmalı
                              if(!result){
                                for (int i = favoriteIcons.length - 1; i >= 0; i--) {
                                  if (favoriteIcons[i]) {
                                    favoriteIcons[i] = false;
                                    selectedSentenceString = selectedSentenceWords.join(" ");
                                    //daha sonra kullanıcı doğru olanı yazsa bile puan eklememek için
                                    tempetureScore = 0;
                                    if(i == 0){
                                      //skor sıfırlandı
                                      score = 0;
                                      //bütün kalpler yenilendi
                                      favoriteIcons = [true,true,true,true,true];

                                    }
                                    break;
                                  }

                                }
                              }
                              else{
                                //eğer kullanıcının girdiği cevap doğruysa
                                score += tempetureScore;//geçici puan asıl puanın üzerine eklendi
                                //kullancıya cümlenin tamamı gösteriliyor
                                selectedSentenceString = selectedSentenceWords.join(" ");
                                if(score > bestScore){
                                  prefs?.setInt("bestScore", score);//yeni en yüksek skor belirlendi
                                  bestScore = prefs?.getInt("bestScore") ?? 0;
                                }
                              }

                              isDecided = true;
                            });
                          },
                          icon: Icon(Icons.send, color: Colors.white),
                        ),
                        hintText: 'Cümleyi buraya girin',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //bu fonksiyon kullanıcın girdiği cüce ile olması gereken cümleyi kıyas ediyor
  bool isDesiredSentence(String input, String desiredSentence) {
    // Girdiğimiz cümleleri küçük harflere dönüştürüyoruz
    //ve başlarındaki ve sonlarındaki boşlukları kaldırıyoruz
    String lowercaseInput = input.toLowerCase().trim();
    String lowercaseDesired = desiredSentence.toLowerCase().trim();

    // Noktalama işaretlerini kaldırma
    final RegExp punctuationPattern = RegExp(r'[^\w\s]');
    lowercaseInput = lowercaseInput.replaceAll(punctuationPattern, '');
    lowercaseDesired = lowercaseDesired.replaceAll(punctuationPattern, '');

    // Girdi cümlesinin içerip içermediğini kontrol ediyoruz
    // İstenilen cümleyi ve girdi cümlesini boşluklara göre ayırıyoruz
    List<String> inputWords = lowercaseInput.split(" ");
    List<String> desiredWords = lowercaseDesired.split(" ");

    // Girdi cümlesinde fazladan kelimeler varsa, istenilen cümle tam olarak eşleşmiyor demektir
    if (inputWords.length > desiredWords.length) {
      // Burada bulunan cümlenin hangi kelimesi veya harfi fazlaysa o kırım kırmızı olarak gösterilmeli
      return false;
    }

    // Girdi cümlesindeki her kelime için kontrol ediyoruz
    for (String word in desiredWords) {
      // Eğer kelime girdi cümlesinde yoksa, istenilen cümle tam olarak eşleşmiyor demektir
      if (!inputWords.contains(word)) {
        return false;
      }
    }

    // Eğer herhangi bir eşleşme bulunmazsa, istenilen cümle tam olarak eşleşiyor demektir
    return true;
  }




}
