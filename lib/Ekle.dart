import 'package:cep_sozluk/KelimeDao.dart';
import 'package:cep_sozluk/Kelimeler.dart';
import 'package:cep_sozluk/VeritabaniYardimcisi.dart';
import 'package:cep_sozluk/main.dart';
import 'package:flutter/material.dart';

class Duzenle extends StatefulWidget {

  Kelimeler kelime ;


  Duzenle({this.kelime});

  @override
  _DuzenleState createState() => _DuzenleState();
}

class _DuzenleState extends State<Duzenle> {


  var tf1 = TextEditingController();
  var tf2 = TextEditingController();


  Future<void> ekle(String ingilizce,String turkce) async {

    await KelimeDao().ekle(ingilizce, turkce);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Duzenle"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              TextField(
                controller: tf1,
                style: TextStyle(color: Colors.pink,fontSize: 25),
                decoration: InputDecoration(
                  hintText: "english word",
                ),
              ),
              TextField(
                controller: tf2,
                style: TextStyle(color: Colors.pink,fontSize: 25),
                decoration: InputDecoration(
                    hintText: "türkçe kelime"
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          setState(() {
            ekle(tf1.text, tf2.text);
          });
        },
        tooltip: "kaydet",
        icon: Icon(Icons.save),
        label: Text("Ekle"),
      ),

    );
  }
}
