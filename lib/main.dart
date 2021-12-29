import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_app/models/not.dart';
import 'package:note_app/note_detail.dart';
import 'package:note_app/save_note_page.dart';
import 'package:note_app/utils/notdao.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<Not>> showAllNotes() async {
    var notlarListesi = await Notdao().tumNotlar();
    return notlarListesi;
  }

  Future<bool?> closeApp() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            closeApp();
          },
        ),
        title: Column(
          children: [
            const Text("Anasayfa", style: TextStyle(color: Colors.white, fontSize: 16,),),
            FutureBuilder<List<Not>>(
              future: showAllNotes(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  var notlarListesi = snapshot.data;
                  double ortalama = 0.0;
                  if(!notlarListesi!.isEmpty){
                    double toplam = 0.0;
                    for(var n in notlarListesi){
                      toplam = toplam + (n.not1 + n.not2) / 2;
                    }
                    ortalama = toplam / notlarListesi.length;
                  }
                  return Text("Ortalama: ${ortalama.toInt()}", style: const TextStyle(color: Colors.white, fontSize: 14,),);
                }else{
                  return const Text("Ortalama: 0", style: TextStyle(color: Colors.white, fontSize: 14,),);
                }
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Not>>(
        future: showAllNotes(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var notlarListesi = snapshot.data;
            return ListView.builder(
              itemCount: notlarListesi!.length,
              itemBuilder: (context, index){
                var not = notlarListesi[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NoteDetail(not: not,),),);
                  },
                  child: Card(
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(not.dersAdi, style: const TextStyle(fontWeight: FontWeight.bold),),
                          Text(not.not1.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                          Text(not.not2.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Note",
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SaveNote(),),);
        },
      ),
    );
  }
}
