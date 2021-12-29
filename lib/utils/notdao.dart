import 'package:note_app/models/not.dart';
import 'package:note_app/utils/database_helper.dart';

class Notdao{
  Future<List<Not>> tumNotlar() async{
    var db = await DatabaseHelper.databaseAccess();
    List<Map<String, dynamic>> maps = await db!.rawQuery("SELECT * FROM notlar");
    return List.generate(maps.length, (index){
      var satir = maps[index];
      return Not(satir["not_id"], satir["ders_adi"], satir["not1"], satir["not2"]);
    });
  }

  Future<void> notEkle(String dersAdi, int not1, int not2) async{
    var db = await DatabaseHelper.databaseAccess();
    var bilgiler = <String, dynamic>{};
    bilgiler["ders_adi"] = dersAdi;
    bilgiler["not1"] = not1;
    bilgiler["not2"] = not2;
    await db!.insert("notlar", bilgiler);
  }

  Future<void> notGuncelle(int notId, String dersAdi, int not1, int not2) async{
    var db = await DatabaseHelper.databaseAccess();
    var bilgiler = <String, dynamic>{};
    bilgiler["ders_adi"] = dersAdi;
    bilgiler["not1"] = not1;
    bilgiler["not2"] = not2;
    await db!.update("notlar", bilgiler, where: "not_id = ?", whereArgs: [notId]);
  }

  Future<void> notSil(int notId) async{
    var db = await DatabaseHelper.databaseAccess();
    await db!.delete("notlar", where: "not_id = ?", whereArgs: [notId]);
  }
}