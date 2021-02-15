import 'package:cep_sozluk/Kelimeler.dart';
import 'package:cep_sozluk/VeritabaniYardimcisi.dart';

class KelimeDao {

  Future<List<Kelimeler>> kelimeGotur() async {

    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");
    return List.generate(maps.length, (i) {
      var satir= maps[i];
      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }

  Future<List<Kelimeler>> aramaYap(String arama) async {

    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$arama%' OR turkce like  '%$arama%' ");
    return List.generate(maps.length, (i) {
      var satir= maps[i];
      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }



  Future<void> ekle(String ingilizce,String turkce) async {

    var db =await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String,dynamic>();
    bilgiler["ingilizce"] = ingilizce;
    bilgiler["turkce"] = turkce;

    await db.insert("kelimeler", bilgiler);
  }

  Future<void> guncelle(int kelime_id,String ingilizce,String turkce) async {

    var db =await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String,dynamic>();

    bilgiler["ingilizce"] = ingilizce;
    bilgiler["turkce"] = turkce;

    await db.update("kelimeler", bilgiler, where: "kelime_id=?",whereArgs: [kelime_id]);
  }

  Future<void> sil(int kelime_id) async {

    var db =await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("kelimeler",where: "kelime_id=?",whereArgs: [kelime_id]);
  }

}