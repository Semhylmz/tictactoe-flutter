import 'package:equatable/equatable.dart';
import 'package:tictactoe/features/game_create/data/models/game_model.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class CreateGameEvent extends GameEvent {
  final GameModel game;

  const CreateGameEvent(this.game);

  @override
  List<Object> get props => [game];
}

class LoadGameEvent extends GameEvent {
  final String gameId;

  const LoadGameEvent(this.gameId);

  @override
  List<Object> get props => [gameId];
}

class JoinGameEvent extends GameEvent {
  final String gameId;
  final List<String> participants;

  const JoinGameEvent(this.gameId, this.participants);

  @override
  List<Object> get props => [gameId, participants];
}
