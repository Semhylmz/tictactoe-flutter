import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/core/models/user_model.dart';
import 'package:tictactoe/feature/user/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserCubit() : super(UserInitial());

  Future<void> checkUserStatus() async {
    try {
      final user = _auth.currentUser;

      if (user != null && user.isAnonymous) {
        emit(UserAuthenticated(user));
      } else {
        emit(UserAnonymous());
      }
    } catch (e) {
      emit(UserError('Kullanıcı durumu kontrol edilirken hata oluştu: $e'));
    }
  }

  Future<void> signInAnonymously(String userName) async {
    try {
      final userCredential = await _auth.signInAnonymously();
      final user = userCredential.user;

      if (user != null) {
        final userModel = UserModel(
          userUuid: user.uid,
          userName: userName,
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson());

        emit(UserAuthenticated(user));
      }
    } catch (e) {
      emit(UserError('Anonim giriş sırasında hata oluştu: $e'));
    }
  }
}
