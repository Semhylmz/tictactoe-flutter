import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/features/game_create/data/models/game_model.dart';

class GameService {
  final FirebaseFirestore _firestore;

  GameService(this._firestore);

  Future<void> createGame(GameModel game) async {
    await _firestore.collection('games').doc(game.id).set(game.toJson());
  }

  Stream<DocumentSnapshot> getGameStream(String gameId) {
    return _firestore.collection('games').doc(gameId).snapshots();
  }

  Future<void> updateGameParticipants(
      String gameId, List<String> participants) async {
    await _firestore.collection('games').doc(gameId).update({
      'participants': participants,
    });
  }
}
