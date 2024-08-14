import 'package:equatable/equatable.dart';

abstract class GameCreateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameCreateInitial extends GameCreateState {}

class GameCreateSuccess extends GameCreateState {
  final String gameId;

  GameCreateSuccess(this.gameId);

  @override
  List<Object?> get props => [gameId];
}

class GameCreateError extends GameCreateState {
  final String message;

  GameCreateError(this.message);

  @override
  List<Object?> get props => [message];
}
