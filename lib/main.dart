import 'dart:io';

import 'package:cep_sozluk/Ekle.dart';
import 'package:cep_sozluk/KelimeDao.dart';
import 'package:cep_sozluk/KelimeDetay.dart';
import 'package:cep_sozluk/Kelimeler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool aramaVarmi = false;
  String arama = "";

  Future<List<Kelimeler>> tumKelimeler() async {

    var kelimeListe = await KelimeDao().kelimeGotur();

    return kelimeListe;
  }

  Future<List<Kelimeler>> aramaYap(String arama) async {

    var kelimeListe = await KelimeDao().aramaYap(arama);
    return kelimeListe;
  }

  Future<bool> kapat() async {
    await exit(0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            kapat();
          },
        ),
        title: aramaVarmi ?
            TextField(
              style: TextStyle(color: Colors.white,fontSize: 20),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Aradığınız kelimeyi girin"
              ),
              onChanged: (aramaSonucu){
                setState(() {
                  arama = aramaSonucu;
                });
              },
            )
            : Text("Kelime Listesi"),
        actions: [
          aramaVarmi ?
          IconButton(icon: Icon(Icons.cancel),
              onPressed:(){
            setState(() {
              aramaVarmi = false;
              arama= "";
            });
              })
              :
          IconButton(icon: Icon(Icons.search),
              onPressed:(){
            setState(() {
              aramaVarmi = true;
            });
              })
        ],
      ),
      body: WillPopScope(
        onWillPop: kapat,
        child: FutureBuilder<List<Kelimeler>>(
          future: aramaVarmi ? aramaYap(arama) : tumKelimeler(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var kelimeliste = snapshot.data;

              return ListView.builder(
                itemCount: kelimeliste.length,
                itemBuilder: (context,index){
                  var  kelime = kelimeliste[index];

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Detay(kelime: kelime,)));
                    },
                    child: SizedBox(height: 50,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(kelime.ingilizce,style: TextStyle(fontSize: 26,color: Colors.deepPurple),),
                            Text(kelime.turkce,style: TextStyle(fontSize: 26),),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Duzenle()));
        },
        tooltip: "Kelime ekle",
        child: Icon(Icons.add),
      ),
    );
  }
}