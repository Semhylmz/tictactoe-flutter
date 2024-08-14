import 'package:equatable/equatable.dart';
import 'package:tictactoe/features/user/data/models/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends UserState {
  final UserModel? user;

  AuthenticatedState({this.user});

  @override
  List<Object?> get props => [user];
}

class UnauthenticatedState extends UserState {}

class UserSaveSuccess extends UserState {}

class UserFetchSuccess extends UserState {
  final UserModel user;

  UserFetchSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String error;

  UserError(this.error);

  @override
  List<Object?> get props => [error];
}
