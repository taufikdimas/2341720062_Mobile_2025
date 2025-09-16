//Pratikum 1: langkah 1
// void main() {
//   var list = [1, 2, 3];
//   assert(list.length == 3);
//   assert(list[1] == 2);
//   print(list.length);
//   print(list[1]);

//   list[1] = 1;
//   assert(list[1] == 1);
//   print(list[1]);
// }

//Pratikum 1: langkah 3
void main() {
  final List<dynamic> list = List.filled(5, null, growable: false);

  list[1] = 'Taufik Dimas Edystara';
  list[2] = '2341720062';

  print(list);
  print("Index 1: ${list[1]}");
  print("Index 2: ${list[2]}");
}
