import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/core/models/game_model.dart';
import 'package:tictactoe/feature/gamelist/cubit/game_list_state.dart';

class GameListCubit extends Cubit<GameListState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GameListCubit() : super(GameListInitial()) {
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    try {
      emit(GameListLoading());
      final snapshot = await _firestore.collection('games').get();
      final games =
          snapshot.docs.map((doc) => GameModel.fromJson(doc.data())).toList();
      emit(GameListLoaded(games));
    } catch (e) {
      emit(GameListError(
          'An error occurred while loading games: ${e.toString()}'));
    }
  }
}
