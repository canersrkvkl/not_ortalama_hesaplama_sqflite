import 'package:flutter/material.dart';
import 'package:note_app/main.dart';
import 'package:note_app/models/not.dart';
import 'package:note_app/utils/notdao.dart';

class NoteDetail extends StatefulWidget {

  Not? not;
  NoteDetail({Key? key, this.not}) : super(key: key);

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {

  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  Future<void> sil(int notId) async {
    await Notdao().notSil(notId);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);
  }

  Future<void> guncelle(int notId, String dersAdi, int not1, int not2) async {
    await Notdao().notGuncelle(notId, dersAdi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tfDersAdi.text = widget.not!.dersAdi;
    tfNot1.text = widget.not!.not1.toString();
    tfNot2.text = widget.not!.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Detay"),
        actions: [
          TextButton(
            child: const Text("Sil", style: TextStyle(color: Colors.white),),
            onPressed: (){
              sil(widget.not!.notId);
            },
          ),
          TextButton(
            child: const Text("Güncelle", style: TextStyle(color: Colors.white),),
            onPressed: (){
              guncelle(widget.not!.notId, tfDersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50),
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
    );
  }
}