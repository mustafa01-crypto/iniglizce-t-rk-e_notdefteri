import 'package:cep_sozluk/KelimeDao.dart';
import 'package:cep_sozluk/Kelimeler.dart';
import 'package:cep_sozluk/main.dart';
import 'package:flutter/material.dart';

class Detay extends StatefulWidget {

  Kelimeler kelime ;


  Detay({this.kelime});

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {


  var tf1 = TextEditingController();
  var tf2 = TextEditingController();

  Future<void> guncelle(int kelime_id,String ingilizce,String turkce) async {

    await KelimeDao().guncelle(kelime_id, ingilizce, turkce);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
  }

  Future<void> sil(int kelime_id) async {

    await KelimeDao().sil(kelime_id);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
  }

  @override
  void initState() {
    super.initState();

    var kelime = widget.kelime;
    tf1.text = kelime.ingilizce;
    tf2.text = kelime.turkce;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kelime.ingilizce),
        actions: [
          IconButton(
            icon: Icon(Icons.update,color: Colors.white,),
            onPressed: (){
              guncelle(widget.kelime.kelime_id, tf1.text, tf2.text);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_forever,color: Colors.white,),

            onPressed: (){
              sil(widget.kelime.kelime_id);
            },
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tf1,
                style: TextStyle(color: Colors.deepPurple,fontSize: 25),
                decoration: InputDecoration(
                  hintText: "ingilizce"
                ),
              ),

              TextField(
                controller: tf2,
                style: TextStyle(color: Colors.deepPurple,fontSize: 25),
                decoration: InputDecoration(
                    hintText: "türkçe"
                ),
              ),

            ],
          ),
        )
      ),

    );
  }
}
