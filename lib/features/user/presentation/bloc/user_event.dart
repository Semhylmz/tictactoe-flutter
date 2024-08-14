import 'package:equatable/equatable.dart';
import 'package:tictactoe/features/user/data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckUserEvent extends UserEvent {}

class SaveUserEvent extends UserEvent {
  final UserModel user;

  SaveUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class FetchUserEvent extends UserEvent {
  final String userUuid;

  FetchUserEvent(this.userUuid);

  @override
  List<Object?> get props => [userUuid];
}
