import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/features/game_create/data/models/game_model.dart';
import 'package:tictactoe/features/game_create/data/repositories/game_repository.dart';
import 'package:tictactoe/features/game_create/presentation/bloc/game_create_event.dart';
import 'package:tictactoe/features/game_create/presentation/bloc/game_create_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _gameRepository;

  GameBloc(this._gameRepository) : super(GameInitial()) {
    on<CreateGameEvent>(_onCreateGame);
    on<LoadGameEvent>(_onLoadGame);
    on<JoinGameEvent>(_onJoinGame);
  }

  Future<void> _onCreateGame(
      CreateGameEvent event, Emitter<GameState> emit) async {
    emit(GameLoading());
    try {
      await _gameRepository.createGame(event.game);
      emit(GameCreated(game: event.game));
    } catch (e) {
      emit(const GameError(message: 'Oyun oluşturulamadı.'));
    }
  }

  Future<void> _onLoadGame(LoadGameEvent event, Emitter<GameState> emit) async {
    try {
      final stream = _gameRepository.getGameStream(event.gameId);
      await emit.forEach(
        stream,
        onData: (DocumentSnapshot snapshot) {
          final gameData = snapshot.data() as Map<String, dynamic>;
          final game = GameModel.fromJson(gameData);
          return GameLoaded(game: game);
        },
      );
    } catch (e) {
      emit(const GameError(message: 'Oyun yüklenemedi.'));
    }
  }

  Future<void> _onJoinGame(JoinGameEvent event, Emitter<GameState> emit) async {
    try {
      await _gameRepository.updateGameParticipants(
          event.gameId, event.participants);
      emit(GameJoined());
    } catch (e) {
      emit(const GameError(message: 'Oyuna katılınamadı.'));
    }
  }
}
