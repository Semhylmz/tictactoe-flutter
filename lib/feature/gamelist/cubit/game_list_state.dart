import 'package:equatable/equatable.dart';
import 'package:tictactoe/core/models/tictactoe_model.dart';

abstract class GameListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameListInitial extends GameListState {}

class GameListLoading extends GameListState {}

class GameListLoaded extends GameListState {
  final List<TicTacToeModel> games;

  GameListLoaded(this.games);

  @override
  List<Object?> get props => [games];
}

class GameListError extends GameListState {
  final String message;

  GameListError(this.message);

  @override
  List<Object?> get props => [message];
}
