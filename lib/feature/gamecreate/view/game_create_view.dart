import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/feature/gamecreate/cubit/game_create_cubit.dart';
import 'package:tictactoe/feature/gamecreate/cubit/game_create_state.dart';
import 'package:tictactoe/feature/gameplay/view/game_play_view.dart';
import 'package:tictactoe/feature/user/cubit/user_cubit.dart';
import 'package:tictactoe/feature/user/cubit/user_state.dart';

class GameCreatePage extends StatefulWidget {
  const GameCreatePage({
    super.key,
    required this.userUid,
  });

  final String userUid;

  @override
  _GameCreatePageState createState() => _GameCreatePageState();
}

class _GameCreatePageState extends State<GameCreatePage> {
  final TextEditingController _gameNameController = TextEditingController();
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
  ];

  Color? selectedColor;

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Game')),
      body: BlocProvider(
        create: (context) => GameCreateCubit(),
        child: BlocConsumer<GameCreateCubit, GameCreateState>(
          listener: (context, state) {
            if (state is GameCreateSuccess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(gameId: state.gameId),
                  ));
              // Navigator.pushNamed(
              //   context,
              //   '/gameBoard',
              //   arguments: state.gameId,
              // );
            } else if (state is GameCreateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, gameState) {
            if (gameState is GameCreateInitial) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _gameNameController,
                      // TextEditingController
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Game Name',
                        hintText: 'Enter game name here',
                      ),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Select Color'),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 10.0,
                          children: colors.map((Color color) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor = color;
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: color,
                                  border: selectedColor == color
                                      ? Border.all(
                                          color: Colors.black,
                                          width: 3,
                                        )
                                      : null,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        // final player2Id = _player2Controller.text.trim();
                        // if (player2Id.isNotEmpty) {
                        //   context.read<GameCreateCubit>().createGame(
                        //         'player1Id',
                        //         player2Id,
                        //       );
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('')),
                        //   );
                        // }

                        context.read<GameCreateCubit>().createGame(
                              widget.userUid,
                              _gameNameController.text.trim(),
                              colorToHex(selectedColor!),
                            );
                      },
                      child: const Text('Create Game'),
                    ),
                    if (gameState is GameCreateError)
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'state.message',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
