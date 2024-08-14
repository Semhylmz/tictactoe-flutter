import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/feature/gamelist/view/game_list_view.dart';
import 'package:tictactoe/feature/user/cubit/user_cubit.dart';
import 'package:tictactoe/feature/user/cubit/user_state.dart';
import 'package:tictactoe/feature/user/view/register/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => BlocProvider(
        create: (context) => UserCubit()..checkUserStatus(),
        child: Scaffold(
          body: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserAnonymous) {
                return RegisterPage();
              } else if (state is UserAuthenticated) {
                return const GameListPage();
              } else if (state is UserError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
