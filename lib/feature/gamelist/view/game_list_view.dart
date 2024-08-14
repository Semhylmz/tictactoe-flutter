import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/feature/gamecreate/view/game_create_view.dart';
import 'package:tictactoe/feature/gamelist/cubit/game_list_cubit.dart';
import 'package:tictactoe/feature/gamelist/cubit/game_list_state.dart';
import 'package:tictactoe/feature/gameplay/view/game_play_view.dart';
import 'package:tictactoe/feature/user/cubit/user_cubit.dart';
import 'package:tictactoe/feature/user/cubit/user_state.dart';

class GameListPage extends StatelessWidget {
  const GameListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game List')),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/gameCreate');
      //   },
      //   icon: const Icon(Icons.add_outlined),
      //   label: const Text('New Game'),
      // ),
      body: BlocProvider(
        create: (context) => GameListCubit(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            String userUid = '';
            if (userState is UserAuthenticated) {
              userUid = userState.user.uid;
            }
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                BlocBuilder<GameListCubit, GameListState>(
                  builder: (context, state) {
                    if (state is GameListLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GameListLoaded) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.games.length,
                        itemBuilder: (context, index) {
                          final game = state.games[index];
                          return Card(
                            child: ListTile(
                              title: Text('Game Name: ${game.gameName}'),
                              subtitle: Text(game.isGameOver
                                  ? 'Result: ${game.winnerId ?? 'Draw'}'
                                  : ' Game ID: ${game.gameId}'),
                              trailing: game.isGameOver
                                  ? const Text('Game Over')
                                  : const Text('Join'),
                              onTap: () {
                                game.isGameOver
                                    ? null
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GamePage(
                                              gameId:
                                                  state.games[index].gameId),
                                        ));
                                // Navigator.pushNamed(
                                //   context,
                                //   '/gameBoard',
                                //   arguments: state.games[index].gameId,
                                // );
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is GameListError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text('Something went wrong.'));
                    }
                  },
                ),
                OutlinedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/gameCreate',
                      //     arguments: userUid);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GameCreatePage(userUid: userUid),
                          ));
                    },
                    child: const Text('Create Game'))
              ],
            );
          },
        ),
      ),
    );
  }
}
