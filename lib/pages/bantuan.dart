import 'package:flutter/material.dart';
import 'menu.dart';
import 'login.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
        );
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Guide"),
        backgroundColor: const Color.fromARGB(255, 166, 201, 250),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Cara Menggunakan Aplikasi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildHelpSection(
              "1. Login/Registrasi",
              "• Jika Anda pengguna baru, silakan mendaftar dengan mengisi formulir registrasi.\n"
                  "• Setelah mendaftar, Anda bisa masuk menggunakan email dan password yang telah dibuat."),
          const SizedBox(height: 20),
          _buildHelpSection("2. Profil Pembuat",
              "• Pada halaman ini, Anda dapat melihat profil pembuat aplikasi. Profil ini hanya menampilkan informasi statis tentang pengembang."),
          const SizedBox(height: 20),
          _buildHelpSection(
              "3. Stopwatch",
              "• Aplikasi ini menyediakan fitur stopwatch untuk menghitung waktu.\n"
                  "• Anda dapat memulai, menjeda, dan mereset timer sesuai kebutuhan."),
          const SizedBox(height: 20),
          _buildHelpSection(
              "4. Daftar Situs Rekomendasi",
              "• Pada halaman ini, Anda akan menemukan daftar situs web populer.\n"
                  "• Untuk membuka situs, tekan salah satu situs yang ingin Anda kunjungi. Situs akan terbuka di browser."),
          const SizedBox(height: 20),
          _buildHelpSection(
              "5. Menambahkan Situs ke Favorit",
              "• Anda dapat menambahkan situs ke daftar favorit dengan menekan tombol berbentuk bintang pada daftar situs rekomendasi.\n"
                  "• Setelah menekan tombol tersebut, situs akan ditambahkan ke daftar favorit Anda."),
          const SizedBox(height: 20),
          _buildHelpSection(
              "6. Melihat Daftar Favorit",
              "• Untuk melihat situs-situs yang telah Anda favoritkan, buka halaman Favorit.\n"
                  "• Halaman ini hanya akan menampilkan situs-situs yang Anda tambahkan sebelumnya."),
          const SizedBox(height: 20),
          _buildHelpSection("7. Logout",
              "• Anda dapat logout dari aplikasi melalui tombol logout di bagian bawah navigasi."),
          const SizedBox(height: 20),
          _buildHelpSection("8. Bantuan Tambahan",
              "• Jika Anda memerlukan bantuan lebih lanjut, hubungi pengembang atau cek dokumentasi lebih lanjut pada bagian bantuan ini."),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Bantuan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHelpSection(String title, String content) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
