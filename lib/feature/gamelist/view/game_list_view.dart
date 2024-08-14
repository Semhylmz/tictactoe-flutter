import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/feature/gamelist/cubit/game_list_cubit.dart';
import 'package:tictactoe/feature/gamelist/cubit/game_list_state.dart';

class GameListPage extends StatelessWidget {
  const GameListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oyun Listesi'),
      ),
      body: BlocProvider(
        create: (context) => GameListCubit(),
        child: BlocBuilder<GameListCubit, GameListState>(
          builder: (context, state) {
            if (state is GameListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GameListLoaded) {
              return ListView.builder(
                itemCount: state.games.length,
                itemBuilder: (context, index) {
                  final game = state.games[index];
                  return ListTile(
                    title: Text('Oyun ID: ${game.gameId}'),
                    subtitle: Text(
                        'Oynayanlar: ${game.player1Id} vs ${game.player2Id}'),
                    trailing: game.isGameOver
                        ? Text('Sonuç: ${game.winnerId ?? 'Beraberlik'}')
                        : const Text('Katıl'),
                    onTap: () {},
                  );
                },
              );
            } else if (state is GameListError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Bir şeyler ters gitti.'));
            }
          },
        ),
      ),
    );
  }
}
