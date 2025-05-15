class Mahasiswa {
  String? nim;
  String? nama;
  String? prodi;

  Mahasiswa({this.nim, this.nama, this.prodi});
  factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        nim: json['nim'],
        nama: json['nama'],
        prodi: json['prodi'],
      );

  Map<String, dynamic> toJson() => {
        'nim': nim,
        'nama': nama,
        'prodi': prodi,
      };
}
