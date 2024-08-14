import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/features/user/data/repositories/user_repository.dart';
import 'package:tictactoe/features/user/presentation/bloc/user_event.dart';
import 'package:tictactoe/features/user/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userAuthRepository;

  UserBloc({required this.userAuthRepository}) : super(UnauthenticatedState()) {
    on<CheckUserEvent>((event, emit) async {
      final user = userAuthRepository.currentUser;

      if (user != null) {
        final userModel = await userAuthRepository.getUser(user.uid);
        emit(AuthenticatedState(user: userModel));
      } else {
        emit(UnauthenticatedState());
      }
    });

    on<SaveUserEvent>((event, emit) async {
      try {
        await userAuthRepository.signInAnonymously();
        await userAuthRepository.saveUser(event.user);
        emit(UserSaveSuccess());
      } catch (e) {
        emit(UserError("Kullanıcı kaydedilirken bir hata oluştu."));
      }
    });

    on<FetchUserEvent>((event, emit) async {
      try {
        final user = await userAuthRepository.getUser(event.userUuid);
        if (user != null) {
          emit(UserFetchSuccess(user));
        } else {
          emit(UserError("Kullanıcı bulunamadı."));
        }
      } catch (e) {
        emit(UserError("Kullanıcı getirilirken bir hata oluştu."));
      }
    });
  }
}
