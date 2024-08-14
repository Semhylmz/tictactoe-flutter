import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/feature/gamecreate/cubit/game_create_cubit.dart';
import 'package:tictactoe/feature/gamecreate/cubit/game_create_state.dart';

class GameCreatePage extends StatefulWidget {
  const GameCreatePage({super.key});

  @override
  _GameCreatePageState createState() => _GameCreatePageState();
}

class _GameCreatePageState extends State<GameCreatePage> {
  final _player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Oyun Oluştur'),
      ),
      body: BlocProvider(
        create: (context) => GameCreateCubit(),
        child: BlocConsumer<GameCreateCubit, GameCreateState>(
          listener: (context, state) {
            if (state is GameCreateSuccess) {
              Navigator.pushNamed(
                context,
                '/game',
                arguments: state.gameId,
              );
            } else if (state is GameCreateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is GameCreateInitial) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _player2Controller,
                      decoration: const InputDecoration(
                        labelText: 'İkinci Oyuncunun ID\'sini Girin',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final player2Id = _player2Controller.text.trim();
                        if (player2Id.isNotEmpty) {
                          context.read<GameCreateCubit>().createGame(
                                'player1Id',
                                player2Id,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Lütfen ikinci oyuncunun ID\'sini girin.')),
                          );
                        }
                      },
                      child: const Text('Oyun Oluştur'),
                    ),
                    if (state is GameCreateError)
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
