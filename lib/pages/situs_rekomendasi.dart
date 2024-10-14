import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menu.dart';
import 'bantuan.dart';
import 'login.dart';

class WebsiteListPage extends StatefulWidget {
  const WebsiteListPage({super.key});

  @override
  _WebsiteListPageState createState() => _WebsiteListPageState();
}

class _WebsiteListPageState extends State<WebsiteListPage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuPage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HelpPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Situs Rekomendasi"),
        backgroundColor: const Color.fromARGB(255, 166, 201, 250),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('websites').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final websites = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: websites.length,
            itemBuilder: (context, index) {
              final website = websites[index];
              final isFavorited =
                  (website['isFavoritedBy'] as List).contains(currentUser?.uid);

              return Card(
                elevation: 3,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.network(website['image']),
                  title: Text(
                    website['name'],
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    website['description'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => toggleFavorite(website.id, isFavorited),
                  ),
                  onTap: () => launchWebsite(website['url']),
                ),
              );
            },
          );
        },
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

  void toggleFavorite(String websiteId, bool isFavorited) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final websiteRef =
        FirebaseFirestore.instance.collection('websites').doc(websiteId);

    if (isFavorited) {
      websiteRef.update({
        'isFavoritedBy': FieldValue.arrayRemove([currentUserId])
      });
    } else {
      websiteRef.update({
        'isFavoritedBy': FieldValue.arrayUnion([currentUserId])
      });
    }
  }

  void launchWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
