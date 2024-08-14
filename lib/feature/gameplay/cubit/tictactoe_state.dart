import 'package:equatable/equatable.dart';
import 'package:tictactoe/core/models/tictactoe_model.dart';

abstract class TicTacToeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TicTacToeInitial extends TicTacToeState {}

class TicTacToeInProgress extends TicTacToeState {
  final TicTacToeModel game;

  TicTacToeInProgress(this.game);

  @override
  List<Object?> get props => [game];
}

class TicTacToeError extends TicTacToeState {
  final String message;

  TicTacToeError(this.message);

  @override
  List<Object?> get props => [message];
}
