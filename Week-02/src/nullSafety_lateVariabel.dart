void main() {
  //Contoh Null Safety
  String? nama; // boleh null
  print("Nama awal: $nama"); // Output: null

  nama = "Taufik";
  print("Nama setelah diisi: $nama");

  //Contoh Late Variable
  late String alamat;
  // print(alamat); // ERROR: belum diinisialisasi

  alamat = "Blitar";
  print("Alamat: $alamat");
}
