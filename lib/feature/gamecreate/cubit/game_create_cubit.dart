import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/core/models/tictactoe_model.dart';
import 'package:tictactoe/feature/gamecreate/cubit/game_create_state.dart';

class GameCreateCubit extends Cubit<GameCreateState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GameCreateCubit() : super(GameCreateInitial());

  Future<void> createGame(String player1Id, String player2Id) async {
    try {
      final gameId = _firestore.collection('games').doc().id;

      final gameModel = TicTacToeModel(
        gameId: gameId,
        board: List<String>.filled(9, ''),
        currentPlayer: player1Id,
        player1Id: player1Id,
        player2Id: player2Id,
        player1Symbol: 'X',
        player2Symbol: 'O',
        isGameOver: false,
      );

      await _firestore.collection('games').doc(gameId).set(gameModel.toJson());

      emit(GameCreateSuccess(gameId));
    } catch (e) {
      emit(GameCreateError(
          'Oyun oluşturulurken bir hata oluştu: ${e.toString()}'));
    }
  }
}
