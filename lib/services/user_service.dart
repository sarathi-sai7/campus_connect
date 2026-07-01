import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserService {

  final FirebaseFirestore _firestore =

      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // =========================
  // SAVE USER
  // =========================

  Future<void> saveUser(

    UserModel user,
  ) async {

    await _firestore

        .collection("users")

        .doc(user.uid)

        .set(user.toMap());
  }

  // =========================
  // GET USER BY UID
  // =========================

  Future<UserModel?> getUser(

    String uid,
  ) async {

    final doc =

        await _firestore

            .collection("users")

            .doc(uid)

            .get();

    if (doc.exists) {

      return UserModel.fromMap(
        doc.data()!,
      );
    }

    return null;
  }

  // =========================
  // GET CURRENT LOGGED USER
  // =========================

  Future<UserModel?>
      getCurrentUserData() async {

    try {

      User? currentUser =
          _auth.currentUser;

      // NO USER LOGGED IN

      if (currentUser == null) {

        return null;
      }

      final doc =

          await _firestore

              .collection("users")

              .doc(currentUser.uid)

              .get();

      // USER EXISTS

      if (doc.exists) {

        return UserModel.fromMap(
          doc.data()!,
        );
      }

      return null;

    } catch (e) {

      return null;
    }
  }

  // =========================
  // UPDATE USER DATA
  // =========================

  Future<void> updateUser({

    required String uid,

    required Map<String, dynamic>
        data,
  }) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update(data);
  }

  // =========================
  // DELETE USER
  // =========================

  Future<void> deleteUser(
      String uid) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .delete();
  }

  // =========================
  // CHECK IF USER IS STUDENT
  // =========================

  Future<bool>
      isOfficialStudent() async {

    UserModel? user =
        await getCurrentUserData();

    if (user == null) {

      return false;
    }

    return user.isOfficialStudent;
  }

  // =========================
  // GET USER ROLE
  // =========================

  Future<String> getUserRole()
      async {

    UserModel? user =
        await getCurrentUserData();

    if (user == null) {

      return "guest";
    }

    return user.role;
  }
}