import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/feature/user/cubit/user_cubit.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('İsim Girişi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'İsminizi girin'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                if (name.isNotEmpty) {
                  context.read<UserCubit>().signInAnonymously(name);
                }
              },
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
