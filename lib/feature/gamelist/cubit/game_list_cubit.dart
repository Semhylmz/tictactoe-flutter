import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/core/models/tictactoe_model.dart';
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
      final games = snapshot.docs
          .map((doc) => TicTacToeModel.fromJson(doc.data()))
          .toList();
      emit(GameListLoaded(games));
    } catch (e) {
      emit(
          GameListError('Oyunları yüklerken bir hata oluştu: ${e.toString()}'));
    }
  }
}
