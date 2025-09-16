// void main() {
// //Pratikum 3 : langkah 1
//   var gifts = {'first': 'partridge', 'second': 'turtledoves', 'fifth': 1};
//   var nobleGases = {2: 'helium', 10: 'neon', 18: 2};

//   print(gifts);
//   print(nobleGases);

//   // Praktikum 3 : Langkah 3
//   var mhs1 = <String, String>{};
//   mhs1['first'] = 'partridge';
//   mhs1['second'] = 'turtledoves';
//   mhs1['fifth'] = 'golden rings';

//   var mhs2 = <int, String>{};
//   mhs2[2] = 'helium';
//   mhs2[10] = 'neon';
//   mhs2[18] = 'argon';

//   print(mhs1);
//   print(mhs2);
// }

// Modifikasi Langkah 3 Pratikum 3
void main() {
  var gifts = {'first': 'partridge', 'second': 'turtledoves', 'fifth': 1};

  var nobleGases = {2: 'helium', 10: 'neon', 18: 2};

  var mhs1 = Map<String, String>();
  var mhs2 = Map<int, String>();

  gifts['first'] = 'partridge';
  gifts['second'] = 'turtledoves';
  gifts['fifth'] = 'golden rings';

  nobleGases[2] = 'helium';
  nobleGases[10] = 'neon';
  nobleGases[18] = 'argon';

  // Tambahkan Nama & NIM
  gifts['nama'] = 'Taufik Dimas Edystara';
  gifts['nim'] = '123456789';

  nobleGases[99] = 'Taufik Dimas Edystara';
  nobleGases[100] = '2341720062';

  mhs1['nama'] = 'Taufik Dimas Edystara';
  mhs1['nim'] = '2341720062';

  mhs2[1] = 'Taufik Dimas Edystara';
  mhs2[2] = '2341720062';

  print(gifts);
  print(nobleGases);
  print(mhs1);
  print(mhs2);
}
