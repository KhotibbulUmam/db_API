import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/mahasiswa.dart';
import './crud.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    refreshdatamhs();
    super.initState();
  }

  // Ambil Semua Data
  List _mahasiswa = [];
  void refreshdatamhs() async {
    final hasil = await http.get(Uri.parse("http://localhost/iwima/list.php"));
    print(hasil.statusCode);
    print(hasil.body);
    // final data = json.decode(hasil.body);
    
    setState(() {
      _mahasiswa = json.decode(hasil.body);
      // _mahasiswa = data.where((item) => item['status'].toString() == '1').toList();
      // _mahasiswa = json.decode(hasil.body).where((item) => item['status'].toString() == '1').toList();
    });
  }

  // Hapus Data
  void hapusdatamhs(String nim) async {
    await http.post(
      Uri.parse("http://localhost/iwima/delete.php"),
      body: {
        'nim': nim,
      },
    );
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  // Confirm Hapus Data
  void confhapusdatamhs(String nim) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Apakah anda yakin akan menghapus data ini?'),
          actions: <Widget>[
            ElevatedButton.icon(
              icon: const Icon(Icons.cancel),
              label: const Text("Batal"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle),
              label: const Text("Hapus"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () => hapusdatamhs(nim),
            ),

            // RaisedButton(
            //   child: Icon(Icons.cancel),
            //   color: Colors.red,
            //   textColor: Colors.white,
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            // RaisedButton(
            //   child: Icon(Icons.check_circle),
            //   color: Colors.blue,
            //   textColor: Colors.white,
            //   onPressed: () => hapusdatamhs(nim),
            // ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Mahasiswa API MYSQL')),
      body: ListView.builder(
        itemCount: _mahasiswa.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            title: Text(_mahasiswa[index]['nama'].toString()),
            subtitle: Text(_mahasiswa[index]['prodi'].toString()),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              Crud(datamhs: _mahasiswa[index]),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      confhapusdatamhs(_mahasiswa[index]['nim']);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => Crud(datamhs: null),
            ),
          );
        },
      ),
    );
  }
}
