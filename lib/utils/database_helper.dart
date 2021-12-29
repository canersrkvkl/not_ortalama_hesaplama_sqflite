import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static const String databaseName = "rehber.db";
  static Future<Database?> databaseAccess() async { 
    String databasePath = join(await getDatabasesPath(), databaseName);
    if(await databaseExists(databasePath)){
      debugPrint("Veri tabanı zaten var kopyalamaya gerek yok.");
    }else{
      ByteData data = await rootBundle.load("assets/notlar.db");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes, flush: true);
      debugPrint("Veritabanı kopyalandı.");
    }
    return openDatabase(databasePath);
  }
}