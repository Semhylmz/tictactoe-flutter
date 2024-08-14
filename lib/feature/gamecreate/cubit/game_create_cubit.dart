import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/core/models/game_model.dart';
import 'package:tictactoe/feature/gamecreate/cubit/game_create_state.dart';

class GameCreateCubit extends Cubit<GameCreateState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GameCreateCubit() : super(GameCreateInitial());

  Future<void> createGame(
      String player1Id, String gameName, String gameColor) async {
    try {
      final gameId = _firestore.collection('games').doc().id;

      final gameModel = GameModel(
        gameName: gameName,
        gameColor: gameColor,
        gameId: gameId,
        board: List<String>.filled(9, ''),
        currentPlayer: player1Id,
        player1Id: player1Id,
        player2Id: 'player2Id',
        player1Symbol: 'X',
        player2Symbol: 'O',
        isGameOver: false,
      );

      await _firestore.collection('games').doc(gameId).set(gameModel.toJson());

      emit(GameCreateSuccess(gameId));
    } catch (e) {
      emit(GameCreateError('Something went wrong: ${e.toString()}'));
    }
  }
}
