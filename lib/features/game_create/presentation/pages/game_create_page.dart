import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/features/game_create/data/models/game_model.dart';
import 'package:tictactoe/features/game_create/presentation/bloc/game_create_bloc.dart';
import 'package:tictactoe/features/game_create/presentation/bloc/game_create_event.dart';
import 'package:tictactoe/features/game_create/presentation/bloc/game_create_state.dart';

class GameCreatePage extends StatefulWidget {
  const GameCreatePage({super.key});

  @override
  _GameCreatePageState createState() => _GameCreatePageState();
}

class _GameCreatePageState extends State<GameCreatePage> {
  final _nameController = TextEditingController();
  String _selectedColor = 'FFFFFF'; // Varsayılan beyaz renk
  final List<String> _participants = [];

  final List<Color> _colorOptions = [
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
  ];

  void _createGame() {
    final gameName = _nameController.text;
    if (gameName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Oyun adı boş olamaz')),
      );
      return;
    }
    final gameId = DateTime.now().millisecondsSinceEpoch.toString(); // Basit bir ID
    final game = GameModel(
      id: gameId,
      name: gameName,
      backgroundColor: _selectedColor,
      participants: _participants,
    );

    context.read<GameBloc>().add(CreateGameEvent(game));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oyun Oluştur'),
      ),
      body: BlocListener<GameBloc, GameState>(
        listener: (context, state) {
          if (state is GameCreated) {
            // Oyun başarıyla oluşturuldu
            Navigator.pushNamed(context, '/gameScreen', arguments: state.game.id);
          } else if (state is GameError) {
            // Oyun oluşturma hatası
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Oyun Adı'),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Oyun adını girin',
                ),
              ),
              SizedBox(height: 16.0),
              Text('Arka Plan Rengi'),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _colorOptions.map((color) {
                  final colorHex = color.value.toRadixString(16).padLeft(6, '0').toUpperCase();
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = colorHex;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      color: color,
                      child: _selectedColor == colorHex
                          ? Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _createGame,
                child: Text('Oyunu Oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
