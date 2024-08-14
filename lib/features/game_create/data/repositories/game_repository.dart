import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/core/services/game_service.dart';
import 'package:tictactoe/features/game_create/data/models/game_model.dart';

class GameRepository {
  final GameService _gameService;

  GameRepository(this._gameService);

  Future<void> createGame(GameModel game) {
    return _gameService.createGame(game);
  }

  Stream<DocumentSnapshot> getGameStream(String gameId) {
    return _gameService.getGameStream(gameId);
  }

  Future<void> updateGameParticipants(
      String gameId, List<String> participants) {
    return _gameService.updateGameParticipants(gameId, participants);
  }
}
