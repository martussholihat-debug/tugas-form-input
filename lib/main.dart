import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

// =====================================================
// WARNA APLIKASI
// =====================================================

const maroon = Color(0xFF781D32);
const maroonDark = Color(0xFF511323);
const redSoft = Color(0xFFA84458);
const gold = Color(0xFFD5AD68);
const cream = Color(0xFFFAF5F0);
const background = Color(0xFFF8F6F5);

// =====================================================
// APLIKASI UTAMA
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIAKAD Mahasiswa',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: maroon,
          primary: maroon,
          secondary: gold,
        ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          foregroundColor: maroonDark,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFAF8F7),
          contentPadding: const EdgeInsets.all(17),
          prefixIconColor: maroon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFE8DEDC)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFE8DEDC)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: maroon, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

// =====================================================
// DATA MAHASISWA
// =====================================================

final List<Map<String, String>> daftarMahasiswa = [
  {
    'nama': 'Rina Amelia',
    'nim': '2023001',
    'prodi': 'Sistem Informasi',
    'semester': '5',
    'email': 'rina@contoh.ac.id',
  },
  {
    'nama': 'Budi Santoso',
    'nim': '2023002',
    'prodi': 'Sistem Informasi',
    'semester': '5',
    'email': 'budi@contoh.ac.id',
  },
  {
    'nama': 'Siti Rahma',
    'nim': '2023003',
    'prodi': 'Sistem Informasi',
    'semester': '3',
    'email': 'siti@contoh.ac.id',
  },
];

// =====================================================
// HEADER IDENTITAS KAMPUS
// =====================================================

class IdentitasKampus extends StatelessWidget {
  const IdentitasKampus({super.key});


@override
Widget build(BuildContext context) {
  return Row(
    children: [
      // Logo UIN
      Image.asset(
        'assets/logo_uin.jpg',
        width: 55,
        height: 55,
        fit: BoxFit.contain,
      ),

      const SizedBox(width: 8),

      // Logo Fakultas
      Image.asset(
        'assets/logo_FST.jpg',
        width: 55,
        height: 55,
        fit: BoxFit.contain,
      ),

      const SizedBox(width: 12),

      // Identitas kampus
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'UNIVERSITAS ISLAM NEGERI',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
                color: maroon,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Sulthan Thaha Saifuddin Jambi',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: maroonDark,
              ),
            ),
            Text(
              'Fakultas Sains dan Teknologi',
              style: TextStyle(
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

  Widget logoPlaceholder(String text, String label) {
    return Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: gold),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 9,
            color: maroon,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =====================================================
// DASHBOARD
// =====================================================

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}
class _DashboardPageState extends State<DashboardPage> {

  Future<void> tambahMahasiswa() async {
    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => const TambahMahasiswaPage(),
      ),
    );

    // Memastikan halaman masih aktif setelah await
    if (!mounted) return;

    if (hasil != null) {
      setState(() {
        daftarMahasiswa.add(hasil);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mahasiswa berhasil ditambahkan!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sistem Akademik',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: maroon,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Icon(
              Icons.notifications_none,
              color: maroon,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: tambahMahasiswa,
        backgroundColor: maroon,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Tambah Data'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const IdentitasKampus(),

          const SizedBox(height: 22),

          // BANNER UTAMA
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [maroon, maroonDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: maroon.withValues(alpha: 0.18),
                  blurRadius: 15,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.13),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'SISTEM INFORMASI AKADEMIK',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1,
                      color: gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Portal Akademik Mahasiswa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 9),

                const Text(
                  'Kelola informasi dan data mahasiswa '
                  'dalam satu aplikasi yang praktis.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: 45,
                  height: 3,
                  decoration: BoxDecoration(
                    color: gold,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Ringkasan Akademik',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: maroonDark,
            ),
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              Expanded(
                child: StatistikCard(
                  judul: 'Mahasiswa',
                  angka: '${daftarMahasiswa.length}',
                  icon: Icons.groups_rounded,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: StatistikCard(
                  judul: 'Program Studi',
                  angka: '1',
                  icon: Icons.school_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // PROFIL SAYA
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(
                color: Color(0xFFECE3E0),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(13),
              leading: const CircleAvatar(
                backgroundColor: cream,
                child: Icon(Icons.person, color: maroon),
              ),
              title: const Text(
                'Profil Saya',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Identitas dan keahlian mahasiswa',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: maroon,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfilPage(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daftar Mahasiswa',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: maroonDark,
                ),
              ),
              Text(
                '${daftarMahasiswa.length} Data',
                style: const TextStyle(
                  color: maroon,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          for (final mhs in daftarMahasiswa)
            Card(
              margin: const EdgeInsets.only(bottom: 11),
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(
                  color: Color(0xFFECE3E0),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 7,
                ),
                leading: CircleAvatar(
                  backgroundColor: cream,
                  child: Text(
                    mhs['nama']![0],
                    style: const TextStyle(
                      color: maroon,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  mhs['nama']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('NIM: ${mhs['nim']}'),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: maroon,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailMahasiswaPage(
                        mahasiswa: mhs,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// =====================================================
// KARTU STATISTIK
// =====================================================

class StatistikCard extends StatelessWidget {
  const StatistikCard({
    super.key,
    required this.judul,
    required this.angka,
    required this.icon,
  });

  final String judul;
  final String angka;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFECE3E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: maroon, size: 28),
          const SizedBox(height: 13),
          Text(
            angka,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: maroon,
            ),
          ),
          Text(
            judul,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// VALIDASI
// =====================================================

String? validasiNama(String? val) {
  final t = val?.trim() ?? '';

  if (t.isEmpty) return 'Nama wajib diisi';
  if (t.length < 3) return 'Nama minimal 3 huruf';

  return null;
}

String? validasiNim(String? val) {
  final t = val?.trim() ?? '';

  if (t.isEmpty) return 'NIM wajib diisi';

  if (!RegExp(r'^[0-9]+$').hasMatch(t)) {
    return 'NIM hanya boleh berisi angka';
  }

  if (t.length < 7) return 'NIM minimal 7 digit';

  return null;
}

String? validasiEmail(String? val) {
  final t = val?.trim() ?? '';

  if (t.isEmpty) return 'Email wajib diisi';

  if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$')
      .hasMatch(t)) {
    return 'Format email tidak valid';
  }

  return null;
}

String? validasiSemester(String? val) {
  final t = val?.trim() ?? '';

  if (t.isEmpty) return 'Semester wajib diisi';

  final a = int.tryParse(t);

  if (a == null) return 'Semester harus berupa angka';

  if (a < 1 || a > 14) {
    return 'Semester harus antara 1 dan 14';
  }

  return null;
}

// =====================================================
// FORM TAMBAH MAHASISWA
// =====================================================

class TambahMahasiswaPage extends StatefulWidget {
  const TambahMahasiswaPage({super.key});

  @override
  State<TambahMahasiswaPage> createState() =>
      _TambahMahasiswaPageState();
}

class _TambahMahasiswaPageState
    extends State<TambahMahasiswaPage> {

  final _formKey = GlobalKey<FormState>();

  final _namaC = TextEditingController();
  final _nimC = TextEditingController();
  final _emailC = TextEditingController();
  final _semC = TextEditingController();

  final _namaF = FocusNode();

  AutovalidateMode _mode = AutovalidateMode.disabled;

  Map<String, String>? _hasil;

  @override
  void dispose() {
    _namaC.dispose();
    _nimC.dispose();
    _emailC.dispose();
    _semC.dispose();
    _namaF.dispose();
    super.dispose();
  }

  void _simpan() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _hasil = {
          'nama': _namaC.text.trim(),
          'nim': _nimC.text.trim(),
          'prodi': 'Sistem Informasi',
          'email': _emailC.text.trim(),
          'semester': _semC.text.trim(),
        };
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil divalidasi!'),
        ),
      );
    } else {
      setState(() {
        _mode = AutovalidateMode.onUserInteraction;
        _hasil = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Periksa kembali data yang diisi.'),
        ),
      );
    }
  }

  void _konfirmasiSimpan() {
    if (_hasil == null) return;

    Navigator.pop(context, _hasil);
  }

  void _kosongkan() {
    _formKey.currentState!.reset();

    _namaC.clear();
    _nimC.clear();
    _emailC.clear();
    _semC.clear();

    setState(() {
      _hasil = null;
      _mode = AutovalidateMode.disabled;
    });

    _namaF.requestFocus();
  }

  Widget fieldJudul(String judul) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        judul,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: maroonDark,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: _mode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // HEADER FORM
              Container(
                padding: const EdgeInsets.all(21),
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: const Color(0xFFE8D8D0)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.assignment_ind_outlined,
                      color: maroon,
                      size: 35,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Formulir Data Mahasiswa',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: maroon,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Silakan lengkapi seluruh informasi '
                      'mahasiswa dengan benar.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'INFORMASI PRIBADI',
                style: TextStyle(
                  color: maroon,
                  fontSize: 12,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 17),

              fieldJudul('Nama Lengkap'),

              TextFormField(
                controller: _namaC,
                focusNode: _namaF,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: validasiNama,
                onChanged: (_) {
                  if (_hasil != null) {
                    setState(() => _hasil = null);
                  }
                },
              ),

              const SizedBox(height: 19),

              fieldJudul('Nomor Induk Mahasiswa'),

              TextFormField(
                controller: _nimC,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 12,
                decoration: const InputDecoration(
                  hintText: 'Masukkan NIM',
                  prefixIcon: Icon(Icons.badge_outlined),
                  counterText: '',
                ),
                validator: validasiNim,
                onChanged: (_) {
                  if (_hasil != null) {
                    setState(() => _hasil = null);
                  }
                },
              ),

              const SizedBox(height: 19),

              fieldJudul('Alamat Email'),

              TextFormField(
                controller: _emailC,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'nama@kampus.ac.id',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: validasiEmail,
                onChanged: (_) {
                  if (_hasil != null) {
                    setState(() => _hasil = null);
                  }
                },
              ),

              const SizedBox(height: 19),

              fieldJudul('Semester'),

              TextFormField(
                controller: _semC,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 2,
                decoration: const InputDecoration(
                  hintText: 'Semester 1 sampai 14',
                  prefixIcon: Icon(Icons.school_outlined),
                  counterText: '',
                ),
                validator: validasiSemester,
                onChanged: (_) {
                  if (_hasil != null) {
                    setState(() => _hasil = null);
                  }
                },
                onFieldSubmitted: (_) => _simpan(),
              ),

              const SizedBox(height: 25),

              FilledButton.icon(
                onPressed: _hasil == null ? _simpan : _konfirmasiSimpan,
                style: FilledButton.styleFrom(
                  backgroundColor: maroon,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: Icon(
                  _hasil == null ? Icons.check_circle_outline : Icons.save,
                ),
                label: Text(
                  _hasil == null
                      ? 'Validasi Data'
                      : 'Simpan ke Dashboard',
                ),
              ),

              const SizedBox(height: 11),

              OutlinedButton.icon(
                onPressed: _kosongkan,
                style: OutlinedButton.styleFrom(
                  foregroundColor: maroon,
                  side: const BorderSide(color: maroon),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Kosongkan Form'),
              ),

              // PRATINJAU DATA
              if (_hasil != null) ...[
                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(19),
                  decoration: BoxDecoration(
                    color: cream,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: gold),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.verified,
                            color: maroon,
                          ),
                          SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              'Data Berhasil Divalidasi',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: maroon,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      BarisInfo(
                        label: 'Nama',
                        nilai: _hasil!['nama']!,
                      ),
                      BarisInfo(
                        label: 'NIM',
                        nilai: _hasil!['nim']!,
                      ),
                      BarisInfo(
                        label: 'Email',
                        nilai: _hasil!['email']!,
                      ),
                      BarisInfo(
                        label: 'Semester',
                        nilai: _hasil!['semester']!,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// DETAIL MAHASISWA
// =====================================================

class DetailMahasiswaPage extends StatelessWidget {
  const DetailMahasiswaPage({
    super.key,
    required this.mahasiswa,
  });

  final Map<String, String> mahasiswa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundColor: cream,
              child: Icon(
                Icons.person,
                size: 55,
                color: maroon,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              mahasiswa['nama'] ?? '-',
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: maroon,
              ),
            ),

            Text(
              mahasiswa['nim'] ?? '-',
              style: const TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 25),

            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Color(0xFFECE3E0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    BarisInfo(
                      label: 'Nama',
                      nilai: mahasiswa['nama'] ?? '-',
                    ),
                    BarisInfo(
                      label: 'NIM',
                      nilai: mahasiswa['nim'] ?? '-',
                    ),
                    BarisInfo(
                      label: 'Prodi',
                      nilai: mahasiswa['prodi'] ?? '-',
                    ),
                    BarisInfo(
                      label: 'Semester',
                      nilai: mahasiswa['semester'] ?? '-',
                    ),
                    BarisInfo(
                      label: 'Email',
                      nilai: mahasiswa['email'] ?? '-',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: maroon,
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// PROFIL MAHASISWA
// =====================================================

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const Map<String, String> profil = {
    'Nama': 'Marttus Sholihat',
    'NIM': '701240053',
    'Program Studi': 'Sistem Informasi',
    'Semester': '5',
    'Email': 'martussholihat@gmail.com',
  };

  static const List<String> keahlian = [
    'Flutter',
    'Basis Data',
    'Desain UI',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [maroon, maroonDark],
                ),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 47,
                    backgroundColor: cream,
                    child: Icon(
                      Icons.person,
                      size: 55,
                      color: maroon,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    profil['Nama']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    profil['Program Studi']!,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: gold,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'NIM ${profil['NIM']}',
                      style: const TextStyle(
                        color: maroonDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Identitas Mahasiswa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: maroon,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Color(0xFFECE3E0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  children: [
                    for (final item in profil.entries)
                      BarisInfo(
                        label: item.key,
                        nilai: item.value,
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Keahlian',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: maroon,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: [
                for (final item in keahlian)
                  Chip(
                    avatar: const Icon(
                      Icons.check_circle,
                      size: 17,
                      color: maroon,
                    ),
                    label: Text(item),
                    backgroundColor: cream,
                    side: const BorderSide(color: Color(0xFFE8D8D0)),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'Sistem Informasi • Fakultas Sains dan Teknologi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// KOMPONEN BARIS INFORMASI
// =====================================================

class BarisInfo extends StatelessWidget {
  const BarisInfo({
    super.key,
    required this.label,
    required this.nilai,
  });

  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              nilai,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
