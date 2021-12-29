import 'package:flutter/material.dart';
import 'package:note_app/main.dart';
import 'package:note_app/utils/notdao.dart';

class SaveNote extends StatefulWidget {
  @override
  _SaveNoteState createState() => _SaveNoteState();
}

class _SaveNoteState extends State<SaveNote> {

  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  Future<void> kayitEkle(String dersAdi, int not1, int not2) async {
    await Notdao().notEkle(dersAdi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Kayıt"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfDersAdi,
                decoration: const InputDecoration(
                  hintText: "Ders Adı",
                ),
              ),
              TextField(
                controller: tfNot1,
                decoration: const InputDecoration(
                  hintText: "Not 1",
                ),
              ),
              TextField(
                controller: tfNot2,
                decoration: const InputDecoration(
                  hintText: "Not 2",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: "Save Note",
        icon: const Icon(Icons.save),
        label: const Text("Kaydet"),
        onPressed: () {
          kayitEkle(tfDersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));
        },
      ),
    );
  }
}