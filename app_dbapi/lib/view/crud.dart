import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/mahasiswa.dart';

class Crud extends StatefulWidget {
  final Map<String, dynamic>? datamhs;
  const Crud({Key? key, this.datamhs}) : super(key: key);
  @override
  CrudState createState() => CrudState();
}

class CrudState extends State<Crud> {
  String status = "";
  TextEditingController nimController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();
  TextEditingController prodiController = new TextEditingController();

  //Menambahkan data tabel
  Future tambahmhs() async {
    return await http.post(
      Uri.parse("http://localhost/iwima/create.php"),
      body: {
        "nim": nimController.text,
        "nama": namaController.text,
        "prodi": prodiController.text,
      },
    );
  }

  //Update data tabel
  Future ubahmhs() async {
    return await http.post(
      Uri.parse("http://localhost/iwima/update.php"),
      body: {
        "nim": widget.datamhs?['nim'],
        "nama": namaController.text,
        "prodi": prodiController.text
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.datamhs != null) {
      status = "Ubah Data Mahasiswa";
      nimController.text = "${widget.datamhs?['nim']}";
      namaController.text = "${widget.datamhs?['nama']}";
      prodiController.text = "${widget.datamhs?['prodi']}";
    } else {
      status = "Tambah Data Mahasiswa";
      nimController.text = "";
      namaController.text = "";
      prodiController.text = "";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(status),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: nimController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Nim'),
                ),
                TextFormField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Nama'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: prodiController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Prodi'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () async {
                      if (widget.datamhs == null) {
                        await tambahmhs();
                      } else {
                        await ubahmhs();
                      }
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    },
                    child: Text(widget.datamhs == null ? 'Tambah' : 'Ubah')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
