# Codelab #10 — Dasar State Management

---

## Praktikum 1: Dasar State dengan Model-View

## Langkah 1: Buat Project Baru

Buatlah sebuah project flutter baru dengan nama master_plan di folder src week-10 repository GitHub Anda atau sesuai style laporan praktikum yang telah disepakati. Lalu buatlah susunan folder dalam project seperti gambar berikut ini.

## Langkah 2: Membuat model task.dart

Praktik terbaik untuk memulai adalah pada lapisan data (data layer). Ini akan memberi Anda gambaran yang jelas tentang aplikasi Anda, tanpa masuk ke detail antarmuka pengguna Anda. Di folder model, buat file bernama task.dart dan buat class Task. Class ini memiliki atribut description dengan tipe data String dan complete dengan tipe data Boolean, serta ada konstruktor. Kelas ini akan menyimpan data tugas untuk aplikasi kita. Tambahkan kode berikut:

```dart
class Task {
	final String description;
	final bool complete;

	const Task({
		this.complete = false,
		this.description = '',
	});
}
```

## Langkah 3: Buat file plan.dart

Kita juga perlu sebuah List untuk menyimpan daftar rencana dalam aplikasi to-do ini. Buat file plan.dart di dalam folder models dan isi kode seperti berikut.

```dart
import './task.dart';

class Plan {
	final String name;
	final List<Task> tasks;

	const Plan({this.name = '', this.tasks = const []});
}
```

### Langkah 4: Buat file data_layer.dart

Kita dapat membungkus beberapa data layer ke dalam sebuah file yang nanti akan mengekspor kedua model tersebut. Dengan begitu, proses impor akan lebih ringkas seiring berkembangnya aplikasi. Buat file bernama data_layer.dart di folder models. Kodenya hanya berisi export seperti berikut.

```dart
export 'plan.dart';
export 'task.dart';
```

### Langkah 5: Pindah ke file main.dart

Hapus semua kode yang ada di dalam `main.dart` dan ganti dengan kode ini

```dart
import 'package:flutter/material.dart';
import './views/plan_screen.dart';

void main() => runApp(MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
	const MasterPlanApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
		 theme: ThemeData(primarySwatch: Colors.purple),
		 home: PlanScreen(),
		);
	}
}
```

### Langkah 6: buat plan_screen.dart

Pada folder views, buatlah sebuah file plan_screen.dart dan gunakan templat StatefulWidget untuk membuat class PlanScreen. Isi kodenya adalah sebagai berikut. Gantilah teks ‘Namaku' dengan nama panggilan Anda pada title AppBar.

```dart
import '../models/data_layer.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
	const PlanScreen({super.key});

	@override
	State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
	Plan plan = const Plan();

	@override
	Widget build(BuildContext context) {
	 return Scaffold(

		appBar: AppBar(title: const Text('Master Plan Muhammad Rifda Musyaffa')),
		body: _buildList(),
		floatingActionButton: _buildAddTaskButton(),
	 );
	}
}
```

### Langkah 7: buat method \_buildAddTaskButton()

Anda akan melihat beberapa error di langkah 6, karena method yang belum dibuat. Ayo kita buat mulai dari yang paling mudah yaitu tombol Tambah Rencana. Tambah kode berikut di bawah method build di dalam class \_PlanScreenState.

```dart
Widget _buildAddTaskButton() {
		return FloatingActionButton(
		 child: const Icon(Icons.add),
		 onPressed: () {
			 setState(() {
				plan = Plan(
				 name: plan.name,
				 tasks: List<Task>.from(plan.tasks)
				 ..add(const Task()),
			 );
			});
		 },
		);
	}
```

### Langkah 8: buat widget \_buildList()

Kita akan buat widget berupa List yang dapat dilakukan scroll, yaitu ListView.builder. Buat widget ListView seperti kode berikut ini.

```dart
Widget _buildList() {
		return ListView.builder(
		 itemCount: plan.tasks.length,
		 itemBuilder: (context, index) =>
		 _buildTaskTile(plan.tasks[index], index),
		);
	}
```

### Langkah 9: buat widget \_buildTaskTile

Dari langkah 8, kita butuh ListTile untuk menampilkan setiap nilai dari plan.tasks. Kita buat dinamis untuk setiap index data, sehingga membuat view menjadi lebih mudah. Tambahkan kode berikut ini

````dart
Widget _buildTaskTile(Task task, int index) {
		return ListTile(
			leading: Checkbox(
					value: task.complete,
					onChanged: (selected) {
						setState(() {
							plan = Plan(
								name: plan.name,
								tasks: List<Task>.from(plan.tasks)
									..[index] = Task(
										description: task.description,
										complete: selected ?? false,
									),
							);
						});
					}),
			title: TextFormField(
				initialValue: task.description,
				onChanged: (text) {
					setState(() {
						plan = Plan(
							name: plan.name,
							tasks: List<Task>.from(plan.tasks)
								..[index] = Task(
									description: text,
									complete: task.complete,
								),
						);
					});
				},
			),
		);
	}

# Langkah 10: Tambah Scroll Controller

Anda dapat menambah tugas sebanyak-banyaknya, menandainya jika sudah beres, dan melakukan scroll jika sudah semakin banyak isinya. Namun, ada salah satu fitur tertentu di iOS perlu kita tambahkan. Ketika keyboard tampil, Anda akan kesulitan untuk mengisi yang paling bawah. Untuk mengatasi itu, Anda dapat menggunakan ScrollController untuk menghapus focus dari semua TextField selama event scroll dilakukan. Pada file plan_screen.dart, tambahkan variabel scroll controller di class State tepat setelah variabel plan.

```dart
late ScrollController scrollController;
````

# Langkah 11: Tambah Scroll Listener'

Tambahkan method initState() setelah deklarasi variabel scrollController seperti kode berikut.

```dart
@override
	void initState() {
		super.initState();
		scrollController = ScrollController()
			..addListener(() {
				FocusScope.of(context).requestFocus(FocusNode());
			});
	}
```

# Langkah 12: Tambah controller dan keyboard behavior

Tambahkan controller dan keyboard behavior pada ListView di method \_buildList seperti kode berikut ini.

```dart
return ListView.builder(
	controller: scrollController,
 keyboardDismissBehavior: Theme.of(context).platform ==
 TargetPlatform.iOS
					? ScrollViewKeyboardDismissBehavior.onDrag
					: ScrollViewKeyboardDismissBehavior.manual,
```

# Langkah 13: Terakhir, tambah method dispose()

Terakhir, tambahkan method dispose() berguna ketika widget sudah tidak digunakan lagi.

```dart
@override
	void dispose() {
		scrollController.dispose();
		super.dispose();
	}
```

## Hasil Pratikum

![Output](img/01.webp)

## Tugas Praktikum 1: Dasar State dengan Model-View

---

2. Maksud Langkah 4 dan alasan dilakukannya

- Penafsiran (asumsi): Langkah 4 biasanya meminta memisahkan logika/data (model) dari tampilan (view) — mis. memindahkan struktur data Plan/Task ke kelas model, atau menghubungkan model ke widget melalui `setState`, `InheritedWidget`/`Provider`, atau parameter konstruktor.
- Mengapa: Pemisahan ini mengikuti prinsip single responsibility dan arsitektur MV\* sehingga UI menjadi lebih sederhana, mudah diuji, dan mudah di-maintain. Dengan memisahkan model, perubahan data tidak bercampur langsung dengan logika tampilan.

3. Mengapa perlu variabel `plan` di Langkah 6? Mengapa dibuat konstanta?

- Penafsiran (asumsi): Langkah 6 meminta menyiapkan instance data awal (mis. sebuah `Plan` atau daftar `Plan`) yang akan ditampilkan pada view.
- Mengapa perlu: Variabel `plan` dibutuhkan untuk menyimpan data yang akan di-render di UI (judul, tanggal, daftar task, dsb.). Tanpa variabel tersebut, view tidak punya sumber data.
- Mengapa `const`/`final`: Jika data bersifat statis/immutable (tidak diubah setelah dibuat), mendeklarasikannya sebagai `const` atau `final` lebih aman dan dapat memberikan optimisasi performa pada Flutter:
  - `const` (hanya jika objek dan konstruktornya compile-time constant) memungkinkan Flutter melakukan canonicalization (objek sama dipakai ulang) dan mengurangi rebuild.
  - `final` cocok bila ingin immutability pada runtime (nilai hanya di-set sekali) tapi tidak bisa `const` karena bukan compile-time constant.

4. Hasil Langkah 9 (instruksi capture GIF) — apa yang dibuat?

- Penafsiran (asumsi): Langkah 9 biasanya menunjukkan interaksi utama aplikasi (mis. menambah plan, melihat detail, mengambil foto dengan kamera, atau preview hasil). Hasil yang harus dicapture adalah alur kerja tersebut.
- Contoh deskripsi yang harus ditulis setelah capture GIF:
  - Menjalankan aplikasi di emulator atau perangkat.
  - Menekan tombol "Tambah Plan" untuk membuat rencana baru.
  - Mengisi form, mengambil foto (jika ada integrasi kamera), lalu menyimpan.
  - Memastikan item baru muncul di daftar.

Tambahkan GIF yang menunjukkan langkah di atas dan jelaskan tiap aksi singkat di README.

5. Kegunaan method pada Langkah 11 dan 13 dalam lifecycle state

- Karena instruksi asli tidak disertakan, saya mengasumsikan dua method yang umum dibahas di lab state Flutter:

  - `initState()` — dipanggil sekali ketika `State` pertama kali dibuat. Kegunaan: melakukan inisialisasi (mis. mulai listener, fetch data awal, buat controller seperti `TextEditingController` atau `AnimationController`). Jangan panggil `BuildContext.dependOnInheritedWidgetOfExactType` di sini jika bergantung pada `InheritedWidget` yang bergantung pada context; gunakan `didChangeDependencies` untuk itu.
  - `dispose()` — dipanggil saat `State` dihapus permanen (widget di-destroy). Kegunaan: membersihkan resource (membatalkan subscription stream, membuang controller) untuk mencegah memory leak.

  - Jika Langkah 11/13 merujuk pada `didChangeDependencies()` atau `didUpdateWidget(oldWidget)`, kegunaannya:
  - `didChangeDependencies()` dipanggil setelah `initState` dan tiap kali dependensi InheritedWidget berubah — cocok untuk membaca data dari `InheritedWidget` atau `Provider`.
  - `didUpdateWidget(oldWidget)` dipanggil ketika widget konfigurasi baru diberikan kepada State — cocok untuk mereset atau memperbarui state yang bergantung pada properti widget lama vs baru.

---

## Praktikum 2: Mengelola Data Layer dengan InheritedWidget dan InheritedNotifier
