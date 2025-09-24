# **Tugas Pratikum Mobile Week 5**

---

## **Praktikum 4: Menerapkan Widget Dasar**

### **Langkah 1 & 2**

> Kode Program

```
void main() {
  var list = [1, 2, 3];
  assert(list.length == 3);
  assert(list[1] == 2);
  print(list.length);
  print(list[1]);

  list[1] = 1;
  assert(list[1] == 1);
  print(list[1]);
}
```

> Output

![Output](img/p1.png)

> Hasil Running

- Karena semua assert terpenuhi, program berjalan normal tanpa error.

### **Langkah 3**

> Kode Program

```
void main() {
  final List<dynamic> list = List.filled(5, null, growable: false);

  list[1] = 'Taufik Dimas Edystara';
  list[2] = '2341720062';

  print(list);
  print("Index 1: ${list[1]}");
  print("Index 2: ${list[2]}");
}
```

> Output

![Output](img/p12.png)
