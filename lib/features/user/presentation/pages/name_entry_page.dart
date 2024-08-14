import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/features/game_list/presentation/pages/game_list_page.dart';
import 'package:tictactoe/features/user/data/models/user_model.dart';
import 'package:tictactoe/features/user/presentation/bloc/user_bloc.dart';
import 'package:tictactoe/features/user/presentation/bloc/user_event.dart';
import 'package:tictactoe/features/user/presentation/bloc/user_state.dart';

class NameEntryPage extends StatelessWidget {
  const NameEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final userAuthBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('İsim Girişi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Adınızı Girin'),
            ),
            const SizedBox(height: 20),
            BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserSaveSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameListPage()),
                  );
                }
                if (state is UserError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    final userName = nameController.text;
                    if (userName.isNotEmpty) {
                      final userUuid =
                          'user_${DateTime.now().millisecondsSinceEpoch}';
                      final user =
                          UserModel(userUuid: userUuid, userName: userName);
                      userAuthBloc.add(SaveUserEvent(user));
                    }
                  },
                  child: state is UserSaveSuccess
                      ? const CircularProgressIndicator()
                      : const Text('Devam Et'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
