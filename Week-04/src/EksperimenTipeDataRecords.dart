void main() {
  //Praktikum 5 : langkah 1 dan 2
  // var record = ('first', a: 2, b: true, 'last');
  // print(record);

  //Praktikum 5 : langkah 3
  // var angka = (10, 20);
  // print('Sebelum tukar: $angka');
  // var hasil = tukar(angka);
  // print('Sesudah tukar: $hasil');

  //Praktikum 5 : langkah 4
  // //Record type annotation in a variable declaration:
  // (String, int) mahasiswa = ('Taufik Dimas', 2341720062);
  // print(mahasiswa);
  // print('Nama: ${mahasiswa.$1}');
  // print('NIM : ${mahasiswa.$2}');

  //Praktikum 5 : langkah 5
  var mahasiswa2 = ('Taufik', a: 2341720062, b: true, 'ジョコウィ氏の生涯');

  print(mahasiswa2.$1);
  print(mahasiswa2.a);
  print(mahasiswa2.b);
  print(mahasiswa2.$2);
}

(int, int) tukar((int, int) record) {
  var (a, b) = record;
  return (b, a);
}
