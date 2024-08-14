import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserAnonymous extends UserState {}

class UserAuthenticated extends UserState {
  final User user;

  UserAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}
