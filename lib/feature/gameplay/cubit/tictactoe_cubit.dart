import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/core/models/game_model.dart';
import 'package:tictactoe/feature/gameplay/cubit/tictactoe_state.dart';

class TicTacToeCubit extends Cubit<TicTacToeState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final Stream<DocumentSnapshot> _gameStream;
  final String gameId;
  late GameModel _gameModel;

  TicTacToeCubit(this.gameId) : super(TicTacToeInitial()) {
    _gameStream = _firestore.collection('games').doc(gameId).snapshots();
    _gameStream.listen((snapshot) {
      if (snapshot.exists) {
        _gameModel =
            GameModel.fromJson(snapshot.data() as Map<String, dynamic>);
        emit(TicTacToeInProgress(_gameModel));
      }
    });
  }

  Future<void> makeMove(int index) async {
    if (_gameModel.isGameOver ||
        _gameModel.currentPlayer != _gameModel.player1Id) return;

    final newBoard = List<String>.from(_gameModel.board);
    if (newBoard[index] == '') {
      newBoard[index] =
          _gameModel.currentPlayer == _gameModel.player1Id ? 'x' : 'o';

      final winner = _checkWinner(newBoard);
      final isGameOver = winner != null || !newBoard.contains('');

      final updatedGame = GameModel(
        gameName: _gameModel.gameName,
        gameColor: _gameModel.gameColor,
        gameId: _gameModel.gameId,
        board: newBoard,
        currentPlayer: _gameModel.currentPlayer == _gameModel.player1Id
            ? _gameModel.player2Id
            : _gameModel.player1Id,
        player1Id: _gameModel.player1Id,
        player2Id: _gameModel.player2Id,
        player1Symbol: _gameModel.player1Symbol,
        player2Symbol: _gameModel.player2Symbol,
        isGameOver: isGameOver,
        winnerId: winner,
      );

      await _firestore
          .collection('games')
          .doc(gameId)
          .update(updatedGame.toJson());
    }
  }

  String? _checkWinner(List<String> board) {
    const winningPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winningPatterns) {
      final a = board[pattern[0]];
      final b = board[pattern[1]];
      final c = board[pattern[2]];
      if (a != '' && a == b && a == c) {
        return a;
      }
    }
    return null;
  }
}
