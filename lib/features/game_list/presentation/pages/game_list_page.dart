import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/features/game_create/presentation/pages/game_create_page.dart';

class GameListPage extends StatelessWidget {
  const GameListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oyun Listesi')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GameCreatePage()),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('games').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Bir hata oluştu'));
          }

          final games = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final gameData = games[index].data() as Map<String, dynamic>;
              final gameName = gameData['name'] ?? 'Bilinmiyor';
              final backgroundColor =
                  Color(int.parse(gameData['backgroundColor'] ?? '0xFFFFFFFF'));
              final status = gameData['status'] ?? 'unknown';

              return ListTile(
                title: Text(gameName),
                subtitle: Text('Durum: $status'),
                tileColor: backgroundColor,
                onTap: () {
                  if (status == 'ongoing') {
                    Navigator.pushNamed(context, '/game',
                        arguments: games[index].id);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Bu oyun tamamlandı, tekrar oynanamaz.')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
