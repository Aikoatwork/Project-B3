import 'package:flutter/material.dart';
import 'menu.dart';
import 'login.dart';
import 'bantuan.dart';

class DataKelompokPage extends StatefulWidget {
  const DataKelompokPage({super.key});

  @override
  _DataKelompokPageState createState() => _DataKelompokPageState();
}

class _DataKelompokPageState extends State<DataKelompokPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MenuPage(),
    HelpPage(),
    LoginPage(),
  ];

  static const List<String> _appBarTitles = <String>[
    'Data Kelompok',
    'Bantuan',
    'Login',
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      if (index == 0) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MenuPage()));
      } else if (index == 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HelpPage()));
      } else if (index == 2) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    }
  }

  final List<Map<String, String>> dataKelompok = [
    {
      'nama': 'Bagas Luqman Nur Hakim',
      'nim': '1244220004',
      'foto': 'assets/images/1.jpg'
    },
    {
      'nama': 'Brigitta Chrishyandra',
      'nim': '124220010',
      'foto': 'assets/images/3.jpg'
    },
    {
      'nama': 'Andaris Bintang Perkasa',
      'nim': '124220027',
      'foto': 'assets/images/2.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        backgroundColor: const Color.fromARGB(255, 166, 201, 250),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: _selectedIndex == 0
            ? SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: dataKelompok.map((data) {
                    return Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              data['foto']!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              data['nama']!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(data['nim']!),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            : _widgetOptions[_selectedIndex],
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
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
