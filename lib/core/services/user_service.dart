import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tictactoe/features/user/data/models/user_model.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print("Oturum açma hatası: $e");
      return null;
    }
  }

  Future<void> saveUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.userUuid)
          .set(user.toJson());
    } catch (e) {
      print("Kullanıcı kaydetme hatası: $e");
    }
  }

  Future<UserModel?> getUser(String userUuid) async {
    try {
      final doc = await _firestore.collection('users').doc(userUuid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
    } catch (e) {
      print("Kullanıcı getirme hatası: $e");
    }
    return null;
  }
}
