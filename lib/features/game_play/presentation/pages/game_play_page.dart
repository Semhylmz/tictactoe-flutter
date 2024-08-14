import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GamePlayPage extends StatelessWidget {
  final String gameId;

  const GamePlayPage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oyun Ekranı'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('games')
            .doc(gameId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Oyun bulunamadı.'));
          }

          final gameData = snapshot.data!.data() as Map<String, dynamic>;
          final participants =
              List<String>.from(gameData['participants'] ?? []);

          if (participants.length < 2) {
            return const Center(
                child: Text('Diğer oyuncunun katılmasını bekliyoruz...'));
          }

          return const Center(
            child: Text('Oyun başlıyor!'),
          );
        },
      ),
    );
  }
}
