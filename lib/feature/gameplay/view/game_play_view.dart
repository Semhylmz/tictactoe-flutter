import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/feature/gameplay/cubit/tictactoe_cubit.dart';
import 'package:tictactoe/feature/gameplay/cubit/tictactoe_state.dart';

class GamePage extends StatelessWidget {
  final String gameId;

  const GamePage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game ID: $gameId')),
      body: BlocProvider(
        create: (context) => TicTacToeCubit(gameId),
        child: const GameBoard(),
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicTacToeCubit, TicTacToeState>(
      builder: (context, state) {
        if (state is TicTacToeInProgress) {
          final game = state.game;

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: game.board.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<TicTacToeCubit>().makeMove(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: hexToColor(state.game.gameColor),
                          border: Border.all(color: Colors.white, width: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            game.board[index],
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (game.isGameOver) ...[
                Text(
                  game.winnerId != null ? 'Winner: ${game.winnerId}' : 'Draw!',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ],
          );
        } else if (state is TicTacToeError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        } else {
          return const Center(child: Text('Loading...'));
        }
      },
    );
  }
}
