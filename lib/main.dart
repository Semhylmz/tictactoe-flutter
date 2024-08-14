import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/core/services/game_service.dart';
import 'package:tictactoe/core/services/user_service.dart';
import 'package:tictactoe/features/game_create/data/repositories/game_repository.dart';
import 'package:tictactoe/features/game_create/presentation/bloc/game_create_bloc.dart';
import 'package:tictactoe/features/game_list/presentation/pages/game_list_page.dart';
import 'package:tictactoe/features/user/data/repositories/user_repository.dart';
import 'package:tictactoe/features/user/presentation/bloc/user_bloc.dart';
import 'package:tictactoe/features/user/presentation/bloc/user_event.dart';
import 'package:tictactoe/features/user/presentation/bloc/user_state.dart';
import 'package:tictactoe/features/user/presentation/pages/name_entry_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final userService = UserService();
  final userRepository = UserRepository(userService);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GameService gameService = GameService(firestore);
  final GameRepository gameRepository = GameRepository(gameService);

  runApp(MyApp(
    userRepository: userRepository
    gameRepository: gameRepository,
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final GameRepository gameRepository;

  const MyApp(
      {super.key, required this.userRepository, required this.gameRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  UserBloc(userAuthRepository: userRepository)),
          BlocProvider(create: (context) => GameBloc(gameRepository)),
        ],
        child: const InitialScreen(),
      ),
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(CheckUserEvent());

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return const GameListPage();
        } else {
          return const NameEntryPage();
        }
      },
    );
  }
}
