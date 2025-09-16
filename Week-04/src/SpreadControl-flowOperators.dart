void main() {
  // Pratikum 4 : langkah 1
  // List<int?> list1 = [1, 2, 3];
  // var list2 = [0, ...list1];
  // print(list1);
  // print(list2);
  // print(list2.length);

  // //Pratikum 4 : langkah 3
  // list1 = [1, 2, null];
  // print(list1);
  // var list3 = [0, ...?list1];
  // print(list3.length);

  // //modifikasi NIM
  // var nim = ['2', '3', '4', '1', '7', '2', '0', '0', '6', '2'];
  // var spreadNim = [...nim];
  // print('NIM dengan spread: $spreadNim');
  // print('NIM dengan join: ${nim.join()}');

  //Pratikum 4 : langkah 4
  // bool promoActive = true;
  // var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  // print(nav);

  // promoActive = false;
  // var nav2 = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  // print(nav2);

  // //Praktikum 4 : langkah 5
  // void printNavigation(String login) {
  //   var nav = [
  //     'Home',
  //     'Furniture',
  //     'Plants',
  //     if (login == 'Manager') 'Inventory',
  //   ];
  //   print('Login $login : $nav');
  // }

  // printNavigation('Manager');
  // printNavigation('NPC');

  //Praktikum 4 : langkah 6
  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  assert(listOfStrings[1] == '#1');
  print(listOfStrings);
}
