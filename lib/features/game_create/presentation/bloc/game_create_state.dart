import 'package:equatable/equatable.dart';
import 'package:tictactoe/features/game_create/data/models/game_model.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameCreated extends GameState {
  final GameModel game;

  const GameCreated({required this.game});

  @override
  List<Object> get props => [game];
}

class GameLoaded extends GameState {
  final GameModel game;

  const GameLoaded({required this.game});

  @override
  List<Object> get props => [game];
}

class GameJoined extends GameState {}

class GameError extends GameState {
  final String message;

  const GameError({required this.message});

  @override
  List<Object> get props => [message];
}
